//
//  DetailWorker.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//  
//
import Combine

class DetailWorker {
    private var subscriptions: Set<AnyCancellable>
    private var networkExecutor: NetworkExecutor
    private var detailApi: DetailApi

    public init(
        subscriptions: Set<AnyCancellable> = Set<AnyCancellable>(),
        networkExecutor: NetworkExecutor = NetworkExecutorImpl(),
        detailApi: DetailApi = DetailApiImpl()
    ) {
        self.subscriptions = subscriptions
        self.networkExecutor = networkExecutor
        self.detailApi = detailApi
    }

    func fetch(movieId: String,
        completionHandler: @escaping (Result<VideosResponse>) -> Void
    ) {
        networkExecutor.fetch(
            VideosResponse.self,
            service: detailApi.fetchVideosInfo(id: movieId)
        )
        .sink(
            receiveCompletion: {_ in},
            receiveValue: { value in
                completionHandler(value)
            })
        .store(in: &subscriptions)
    }

    func getBaseVideoUrl() -> String {
        return detailApi.getVideoUrl()
    }
}
