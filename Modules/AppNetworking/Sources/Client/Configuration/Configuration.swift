import Foundation

/// The configuration used within the client.
public struct Configuration {
    public let baseURLProvider: BaseURLProvider
    public let interceptors: [Interceptor]
    public let encoder: Encoder
    public let decoder: Decoder
    public let cache: URLCache

    /**
     * Initialises a new configuration instance to use within the client.
     *
     * - Parameter baseURLProvider: The provider which provides the base URL used within the client.
     * Note: URL itself is implementing the protocol itself to pass a static baseURL.
     * - Parameter interceptors: A list of interceptors to intercept the request before sending (`RequestInterceptor`) it or intersect the response after receiving it (`ResponseInterceptor`).
     * - Parameter encoder: The standard encoder to use to encode the request body data before sending it.
     * - Parameter decoder: The standard decoder to use to decode the response body data before returning it.
     * - Parameter cache: A cache object that realizes caching mechanism. IMPORTANT: At least one instance of `SessionCacheInterceptor` is required.
     */
    public init(
        baseURLProvider: BaseURLProvider,
        interceptors: [Interceptor],
        encoder: Encoder = JSONEncoder(),
        decoder: Decoder = JSONDecoder(),
        cache: URLCache = .shared
    ) {
        self.baseURLProvider = baseURLProvider
        self.interceptors = interceptors
        self.encoder = encoder
        self.decoder = decoder
        self.cache = cache
    }
}
