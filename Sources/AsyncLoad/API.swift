//
//  APICall.swift
//  AsyncLoad
//
//  Created by Alexey Naumov on 23.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation

public protocol API {
    var version: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

public enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        }
    }
}

public extension API {
    func url(for host: String) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        return url
    }

    func urlRequest(for host: String, with token: String?, and cacheTTL: Int? = nil) throws -> URLRequest {
        let requestUrl = try url(for: host)
        return try urlRequest(from: requestUrl, with: token, and: cacheTTL)
    }

    func urlRequest(from url: URL, with token: String? = nil, and cacheTTL: Int? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = try body()
        request.setValue("application/json; charset=utf-8",
                         forHTTPHeaderField: "Content-Type")
        if let key = token, key != "" {
            request.setValue("token \(key)", forHTTPHeaderField: "Authorization")
        }
        if let ttl = cacheTTL {
            request.setValue("max-age=\(ttl)", forHTTPHeaderField: "Cache-Control")
        }
        return request
    }
}

public typealias HTTPCode = Int
public typealias HTTPCodes = Range<HTTPCode>

public extension HTTPCodes {
    static let success = 200 ..< 300
    static let badRequest = 400
    static let unauthorized = 401
    static let notFound = 404
    static let internalServerError = 500
}

public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE, OPTIONS, HEAD, PATCH, TRACE, CONNECT
}
