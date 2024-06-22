//
//  URLRequestExt.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

public extension URLRequest {
    init(urlComponents: URLComponents) {
        guard let url = urlComponents.url else {
            preconditionFailure("Unable to get URL from URLComponent: \(urlComponents)")
        }
        self = Self(url: url)
    }

    private func map(_ transform: (inout Self) -> Void) -> Self {
        var request = self
        transform(&request)
        return request
    }

    func add(httpMethod: HTTPMethod) -> Self {
        map { $0.httpMethod = httpMethod.rawValue }
    }

    func add<Body: Encodable>(body: Body) -> Self {
        map {
            do {
                $0.httpBody = try JSONEncoder().encode(body)
            } catch {
                preconditionFailure("Failed to encode request Body: \(body) doe to Error: \(error)")
            }
        }
    }

    func add(headers: [String: String]) -> Self {
        map {
            let allHTTPHeaderFields = $0.allHTTPHeaderFields ?? [:]
            let updatedAllHTTPHeaderFields = headers.merging(allHTTPHeaderFields, uniquingKeysWith: { $1 })
            $0.allHTTPHeaderFields = updatedAllHTTPHeaderFields
        }
    }

//    func add(queryParams: [String: Any]) -> Self {
//        map {
//            let parameters = queryParams.stringFromHttpParameters()
//            var components = URLComponents(url: $0.url!, resolvingAgainstBaseURL: true)
//            components?.query = parameters
//            $0.url = components?.url
//        }
//    }

    func toDataTaskPublisher() -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: self)
    }
}
