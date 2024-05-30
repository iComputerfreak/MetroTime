import AppFoundation
import Foundation

/// An error occuring  while sending a request
public enum APIError: LocalizedError {
    case unexpectedError
    case responseMissing
    case decodingError(Error)
    case unexpectedStatusCode(statusCode: Int, headers: [AnyHashable: Any], body: Data?)
    case serverError(statusCode: Int, body: Data?)
    case informationalResponse(statusCode: Int, body: Data?)
    case missingResponseBody
    case invalidURLComponents
    
    public var errorDescription: String? {
        switch self {
        case .unexpectedError:
            return String(localized: "apiError.unexpectedError")
        
        case .responseMissing:
            return String(localized: "apiError.responseMissing")
        
        case let .decodingError(error):
            return String(localized: "apiError.decodingError \(error.localizedDescription)")
        
        case let .unexpectedStatusCode(statusCode, _, _):
            return String(localized: "apiError.unexpectedStatusCode \(statusCode) \(statusCodeString(statusCode))")
        
        case let .serverError(statusCode, _):
            return String(localized: "apiError.serverError \(statusCode) \(statusCodeString(statusCode))")
        
        case let .informationalResponse(statusCode, _):
            return String(localized: "apiError.informationalResponse \(statusCode) \(statusCodeString(statusCode))")
        
        case .missingResponseBody:
            return String(localized: "apiError.missingResponseBody")
        
        case .invalidURLComponents:
            return String(localized: "apiError.invalidURLComponents")
        }
    }
    
    private func statusCodeString(_ statusCode: Int) -> String {
        HTTPURLResponse.localizedString(forStatusCode: statusCode).capitalized
    }
}

public final class Client {
    public typealias RequestCompletion<ResponseType> = (HTTPURLResponse?, Result<ResponseType, Error>) -> Void
    
    // MARK: - Properties
    public lazy var sessionCache: SessionCache = .init(configuration: configuration)

    public let configuration: Configuration

    public let session: URLSession
    private lazy var responseHandler: ResponseHandler = .init(configuration: configuration)

    // MARK: - Initialisation
    /**
     * Initialises a new client instance with a default url session.
     *
     * - Parameter configuration: The client configuration.
     * - Parameter session: The URLSession which is used for executing requests
     */
    public init(
        configuration: Configuration,
        session: URLSession = .init(configuration: .default)
    ) {
        self.configuration = configuration
        self.session = session
    }

    // MARK: - Methods
    @discardableResult
    public func get<ResponseType: Decodable>(
        endpoint: Endpoint<ResponseType>,
        andAdditionalHeaderFields additionalHeaderFields: [String: String] = [:]
    ) async throws -> ResponseType {
        try await executeRequest(method: .get, endpoint: endpoint, andAdditionalHeaderFields: additionalHeaderFields)
    }

    @discardableResult
    public func post<BodyType: Encodable, ResponseType: Decodable>(
        endpoint: Endpoint<ResponseType>,
        body: BodyType? = nil,
        andAdditionalHeaderFields additionalHeaderFields: [String: String] = [:]
    ) async throws -> ResponseType {
        try await executeRequest(method: .post, endpoint: endpoint, body: body, andAdditionalHeaderFields: additionalHeaderFields)
    }

    @discardableResult
    public func put<BodyType: Encodable, ResponseType: Decodable>(
        endpoint: Endpoint<ResponseType>,
        body: BodyType,
        andAdditionalHeaderFields additionalHeaderFields: [String: String] = [:]
    ) async throws -> ResponseType {
        try await executeRequest(method: .put, endpoint: endpoint, body: body, andAdditionalHeaderFields: additionalHeaderFields)
    }

    @discardableResult
    public func patch<BodyType: Encodable, ResponseType: Decodable>(
        endpoint: Endpoint<ResponseType>,
        body: BodyType,
        andAdditionalHeaderFields additionalHeaderFields: [String: String] = [:]
    ) async throws -> ResponseType {
        try await executeRequest(method: .patch, endpoint: endpoint, body: body, andAdditionalHeaderFields: additionalHeaderFields)
    }

    @discardableResult
    public func delete<ResponseType: Decodable>(
        endpoint: Endpoint<ResponseType>,
        parameter: [String: Any] = [:],
        andAdditionalHeaderFields additionalHeaderFields: [String: String] = [:]
    ) async throws -> ResponseType {
        try await executeRequest(method: .delete, endpoint: endpoint, andAdditionalHeaderFields: additionalHeaderFields)
    }

    /// Sends a custom `URLRequest` and returns the response
    ///
    /// - Important: Does **not** apply interceptors!
    @discardableResult
    public func send(request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }

    private func createRequest<ResponseType>(
        forHttpMethod httpMethod: HTTPMethod,
        and endpoint: Endpoint<ResponseType>,
        and body: Data? = nil,
        andAdditionalHeaderFields additionalHeaderFields: [String: String]
    ) throws -> URLRequest {
        var request = URLRequest(
            url: try URLFactory.makeURL(from: endpoint, withBaseURL: configuration.baseURLProvider.baseURL),
            httpMethod: httpMethod,
            httpBody: body
        )

        var requestInterceptors: [Interceptor] = configuration.interceptors

        // Extra case: POST-request with empty content
        //
        // Adds custom interceptor after last interceptor for header fields
        // to avoid conflict with other custom interceptor if any.
        if body == nil && httpMethod == .post {
            let targetIndex = requestInterceptors.lastIndex { $0 is HeaderFieldsInterceptor }
            let indexToInsert = targetIndex.flatMap { requestInterceptors.index(after: $0) }
            requestInterceptors.insert(
                EmptyContentHeaderFieldsInterceptor(),
                at: indexToInsert ?? requestInterceptors.endIndex
            )
        }

        // Append additional header fields.
        additionalHeaderFields.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return requestInterceptors.reduce(request) { request, interceptor in
            return interceptor.intercept(request)
        }
    }
    
    private func executeRequest<BodyType: Encodable, ResponseType: Decodable>(
        method: HTTPMethod,
        endpoint: Endpoint<ResponseType>,
        body: BodyType? = nil as Empty?,
        andAdditionalHeaderFields additionalHeaderFields: [String: String] = [:]
    ) async throws -> ResponseType {
        let encoder = endpoint.encoder ?? configuration.encoder
        let bodyData = try body.map { try encoder.encode($0) }
        let request = try createRequest(
            forHttpMethod: method,
            and: endpoint,
            and: bodyData,
            andAdditionalHeaderFields: additionalHeaderFields
        )
        do {
            let (data, urlResponse) = try await session.data(for: request)
            return try responseHandler.handleResponse(
                data: data,
                urlResponse: urlResponse,
                endpoint: endpoint
            )
        } catch {
            DefaultLogger().log("Error executing request: \(error)")
            throw error
        }
    }
}
