//
//  HomeWorker.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Combine

class HomeWorker {
    private var subscriptions: Set<AnyCancellable>
    private var networkExecutor: NetworkExecutor
    private var homeApi: HomeApi

    public init(
        subscriptions: Set<AnyCancellable> = Set<AnyCancellable>(),
        networkExecutor: NetworkExecutor = NetworkExecutorImpl(),
        homeApi: HomeApi = HomeApiImpl()
    ) {
        self.subscriptions = subscriptions
        self.networkExecutor = networkExecutor
        self.homeApi = homeApi
    }

    func fetchPopular(completionHandler: @escaping (Result<ResultsResponse>) -> Void) {
        networkExecutor.fetch(
            ResultsResponse.self,
            service: homeApi.fetchPopularMovies()
        )
        .sink(
            receiveCompletion: {_ in},
            receiveValue: { value in
                completionHandler(value)
            })
        .store(in: &subscriptions)
    }

    func fetchTopRated(completionHandler: @escaping (Result<ResultsResponse>) -> Void) {
        networkExecutor.fetch(
            ResultsResponse.self,
            service: homeApi.fetchTopRatedMovies()
        )
        .sink(
            receiveCompletion: {_ in},
            receiveValue: { value in
                completionHandler(value)
            })
        .store(in: &subscriptions)
    }

    func fetchUpcoming(completionHandler: @escaping (Result<ResultsResponse>) -> Void) {
        networkExecutor.fetch(
            ResultsResponse.self,
            service: homeApi.fetchUpcomingMovies()
        )
        .sink(
            receiveCompletion: {_ in},
            receiveValue: { value in
                completionHandler(value)
            })
        .store(in: &subscriptions)
    }

    func getBaseUrl() -> String {
        return homeApi.getPosterBaseUrl()
    }
}
