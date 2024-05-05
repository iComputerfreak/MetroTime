import Foundation

final class ResponseHandler {
    private let configuration: Configuration

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    // The endpoint is required for the custom decoder
    func handleResponse<ResponseType: Decodable>(
        data: Data,
        urlResponse: URLResponse,
        endpoint: Endpoint<ResponseType>? = nil
    ) throws -> ResponseType {
        return try evaluate(data: data, urlResponse: urlResponse, endpoint: endpoint)
    }

    private func evaluate<ResponseType: Decodable>(
        data: Data,
        urlResponse: URLResponse,
        endpoint: Endpoint<ResponseType>? = nil
    ) throws -> ResponseType {
        let interceptedResponse = configuration.interceptors.reduce(urlResponse) { response, interceptor in
            interceptor.intercept(response: response, data: data)
        }

        guard let httpURLResponse = interceptedResponse as? HTTPURLResponse else {
            throw APIError.responseMissing
        }

        switch HTTPStatusCodeType(statusCode: httpURLResponse.statusCode) {
        case .successful:
            return try decode(data: data, decoder: endpoint?.decoder ?? configuration.decoder)

        default:
            throw APIError.unexpectedStatusCode(
                statusCode: httpURLResponse.statusCode,
                headers: httpURLResponse.allHeaderFields,
                body: data
            )
        }
    }
    
    private func decode<ResponseType: Decodable>(data: Data, decoder: Decoder) throws -> ResponseType {
        guard ResponseType.self != Void.self else {
            return () as! ResponseType
        }
        
        do {
            let decodedData = try decoder.decode(ResponseType.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
