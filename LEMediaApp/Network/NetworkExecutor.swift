//
//  NetworkExecutor.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation
import Combine

protocol NetworkExecutor {
    func fetch<T>(_ type: T.Type, service: URLRequest) -> AnyPublisher<Result<T>, Error> where T: Decodable
}

extension NetworkExecutor {
    func fetch<T>(_ type: T.Type, service: URLRequest) -> AnyPublisher<Result<T>, Error> where T: Decodable {
        return fetch(type, service: service)
    }
}

struct NetworkExecutorImpl: NetworkExecutor {
    private var dispatchQueue: DispatchQueue
    private var decoder: JSONDecoder
    private var requestInterceptor: RequestInterceptor
    private var responseInterceptor: ResponseInterceptor

    init(
        dispatchQueue: DispatchQueue = DispatchQueue.main,
        decoder: JSONDecoder = JSONDecoder(),
        requestInterceptor: RequestInterceptor = RequestInterceptorImpl(),
        responseInterceptor: ResponseInterceptor = ResponseInterceptorImpl()
    ) {
        self.dispatchQueue = dispatchQueue
        self.decoder = decoder
        self.requestInterceptor = requestInterceptor
        self.responseInterceptor = responseInterceptor
    }

    public func fetch<T>(_ responseType: T.Type, service: URLRequest) -> AnyPublisher<Result<T>, Error> where T: Decodable {
        return requestInterceptor
            .intercept(request: service)
            .toDataTaskPublisher()
            .tryMap { data, response in
                return try self.handleResponse(data: data, response: (response as? HTTPURLResponse)!)
            }
            .tryCatch({ handler in
                print(handler)
                return Just(Result<T>.failure(handler as NSError))
            })
            .receive(on: dispatchQueue)
            .eraseToAnyPublisher()
    }

    private func handleResponse<T: Decodable>(data: Data, response: HTTPURLResponse) throws -> Result<T> {
        let payload = try responseInterceptor.intercept(data: data, response: response)
        let object = try JSONDecoder().decode(T.self, from: payload)
        return Result<T>.success(object)
    }
}
