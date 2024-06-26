import Foundation

/// Implementation of a request interceptor which adds header fields to the request.
public class HeaderFieldsInterceptor: Interceptor {
    private let addContentLength: Bool
    internal var headerFields: () -> [String: String]

    /**
     * # Summary
     * The initialiser for the `HeaderFieldsRequestInterceptor`
     *
     * - Parameter addContentLength: Whether to add the `Content-Length` header field to the request
     * - Parameter headerFields:
     *  Either pass in a dictionary of header fields to be added or an `autoclosure` which then returns a dictionary of header fields to be added.
     */
    public init(addContentLength: Bool, headerFields: @escaping @autoclosure (() -> [String: String])) {
        self.addContentLength = addContentLength
        self.headerFields = headerFields
    }

    /**
     * # Summary
     * Intercepting the request by adding the given header fields.
     *
     * - Parameter request:
     *  The request to be intercepted.
     *
     * - Returns:
     * The intercepted request.
     */
    public func intercept(_ request: URLRequest) -> URLRequest {
        var mutatedRequest: URLRequest = request
        headerFields().forEach { key, value in
            mutatedRequest.addValue(value, forHTTPHeaderField: key)
        }
        if addContentLength {
            let contentLength = mutatedRequest.httpBody?.count ?? 0
            mutatedRequest.setValue("\(contentLength)", forHTTPHeaderField: "Content-Length")
        }

        return mutatedRequest
    }
}
