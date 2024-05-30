import Foundation

/// Implementation of a request interceptor which logs the request information.
public final class LoggingInterceptor: Interceptor {
    private var logger: LoggerProtocol

    /**
     * # Summary
     * The initialiser for the `LoggingRequestInterceptor`
     *
     * - Parameter logger:
     *  The logger to be used to pass the request information to. Default value for the logger is the `DefaultLogger`.
     */
    public init(logger: LoggerProtocol = DefaultLogger()) {
        self.logger = logger
    }

    /**
     * # Summary
     * Intercepting the request by taking its information and creating a message to be logged.
     *
     * - Parameter request:
     *  The request to be intercepted.
     *
     * - Returns:
     * The intercepted request.
     */
    public func intercept(_ request: URLRequest) -> URLRequest {
        var messageLines: [String] = []

        if let url = request.url {
            let method = request.httpMethod.map { "\($0) " } ?? ""
            let scheme = url.scheme ?? ""
            let host = url.host() ?? "No host"
            messageLines.append("Request: \(method)\(scheme)\(host)")
            let query = url.query() ?? "No query"
            messageLines.append("Query: \(query)")
        }

        if let allHTTPHeaderFields = request.allHTTPHeaderFields {
            messageLines.append("Headers:")
            for (key, value) in allHTTPHeaderFields {
                messageLines.append("  \(key): \(value)")
            }
        }

        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            let indentedBody = bodyString
                .components(separatedBy: .newlines)
                .map({ "  \($0)" })
                .joined(separator: "\n")
            
            messageLines.append("Body:")
            messageLines.append(indentedBody)
        }

        let message = [
            "<-- Request",
            messageLines
                .map { "|   \($0)" }
                .joined(separator: "\n"),
            "--> End Request"
        ].joined(separator: "\n")
        
        logger.log(message)

        return request
    }

    /**
     * # Summary
     * Intercepting the response by taking its information and creating a message to be logged.
     *
     * - Parameter response:
     *  The response returned by the data task
     * - Parameter data:
     *  The data returned by the data task.
     * - Parameter error:
     *  The error returned by the data task.
     *
     * - Returns:
     * The intercepted response.
     */
    public func intercept(response: URLResponse?, data: Data?) -> URLResponse? {
        var messageLines: [String] = []

        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            let url = httpResponse.url?.absoluteString ?? "No URL"
            messageLines.append("Response: \(statusCode) \(HTTPURLResponse.localizedString(forStatusCode: statusCode).capitalized)")
            messageLines.append("Request: \(url)")

            messageLines.append("Headers:")
            for (key, value) in httpResponse.allHeaderFields {
                messageLines.append("  \(key): \(value)")
            }
        } else if let url = response?.url {
            messageLines.append("Request: \(url.absoluteString)")
        }

        if let data, let bodyString = String(data: data, encoding: .utf8) {
            let indentedBody = bodyString
                .components(separatedBy: .newlines)
                .map { "  \($0)" }
                .joined(separator: "\n")
            
            messageLines.append("Body:")
            messageLines.append(indentedBody)
        }

        let message = [
            "<-- Response",
            messageLines
                .map { "|   \($0)" }
                .joined(separator: "\n"),
            "--> End Response"
        ].joined(separator: "\n")
        
        logger.log(message)

        return response
    }
}
