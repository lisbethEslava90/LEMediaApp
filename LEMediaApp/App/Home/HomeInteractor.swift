//
//  HomeInteractor.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

protocol HomeBusinessLogic {
    func loadInitialData(request: Home.LoadInitialData.Request)
    func loadPopularMovies(request: Home.LoadMovies.Request)
    func loadTopRatedMovies(request: Home.LoadMovies.Request)
    func loadUpcomingMovies(request: Home.LoadMovies.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker = HomeWorker()

    func loadInitialData(request: Home.LoadInitialData.Request) {
        let response = Home.LoadInitialData.Response()
        presenter?.presentInitialData(response: response)
    }

    func loadPopularMovies(request: Home.LoadMovies.Request) {
        let baseUrl = worker.getBaseUrl()
        worker.fetchPopular { result in
            switch result {
            case .success(let populars):
                guard let results = populars.results else {
                    let response = Home.LoadError.Response(movieType: .popular)
                    self.presenter?.presentErrorMovies(response: response)
                    return
                }
                let response = Home.LoadMovies.Response(
                    baseImageUrl: baseUrl,
                    movies: results)
                self.presenter?.presentPopularMovies(response: response)
            case .failure:
                let response = Home.LoadError.Response(movieType: .popular)
                self.presenter?.presentErrorMovies(response: response)
            }
        }
    }

    func loadTopRatedMovies(request: Home.LoadMovies.Request) {
        let baseUrl = worker.getBaseUrl()
        worker.fetchTopRated { result in
            switch result {
            case .success(let topRated):
                guard let results = topRated.results else {
                    let response = Home.LoadError.Response(movieType: .topRated)
                    self.presenter?.presentErrorMovies(response: response)
                    return
                }
                let response = Home.LoadMovies.Response(
                    baseImageUrl: baseUrl,
                    movies: results)
                self.presenter?.presentTopRatedMovies(response: response)
            case .failure:
                let response = Home.LoadError.Response(movieType: .topRated)
                self.presenter?.presentErrorMovies(response: response)
            }
        }
    }

    func loadUpcomingMovies(request: Home.LoadMovies.Request) {
        let baseUrl = worker.getBaseUrl()
        worker.fetchUpcoming { result in
            switch result {
            case .success(let upcoming):
                guard let results = upcoming.results else {
                    let response = Home.LoadError.Response(movieType: .upcoming)
                    self.presenter?.presentErrorMovies(response: response)
                    return
                }
                let response = Home.LoadMovies.Response(
                    baseImageUrl: baseUrl,
                    movies: results)
                self.presenter?.presentUpcomingMovies(response: response)
            case .failure:
                let response = Home.LoadError.Response(movieType: .upcoming)
                self.presenter?.presentErrorMovies(response: response)
            }
        }
    }
}
