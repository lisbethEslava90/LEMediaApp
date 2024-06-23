//
//  DetailInteractor.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//  
//
import Foundation

protocol DetailBusinessLogic {
    func loadInitialData(request: Detail.LoadInitialData.Request)
    func loadVideosInfo(request: Detail.LoadVideosInfo.Request)
}

class DetailInteractor: DetailBusinessLogic {
    var presenter: DetailPresentationLogic?
    var worker: DetailWorker = DetailWorker()

    func loadInitialData(request: Detail.LoadInitialData.Request) {
        let response = Detail.LoadInitialData.Response(movie: request.movie)
        presenter?.presentInitialData(response: response)
    }

    func loadVideosInfo(request: Detail.LoadVideosInfo.Request) {
        let id = "\(request.movieId)"
        let baseVideoUrl = worker.getBaseVideoUrl()
        worker.fetch(movieId: id) { result in
            switch result {
            case .success(let videosInfo):
                guard let movieVideos = videosInfo.results else {
                    return
                }
                let response = Detail.LoadVideosInfo.Response(
                    baseVideoUrl: baseVideoUrl,
                    videosInfo: movieVideos)
                self.presenter?.presentVideosInfo(response: response)
            case .failure:
                return
            }
        }
    }
}
