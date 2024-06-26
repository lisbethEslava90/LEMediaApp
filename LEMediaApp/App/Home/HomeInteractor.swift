//
//  HomeInteractor.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation
import RealmSwift

protocol HomeBusinessLogic {
    func loadInitialData(request: Home.LoadInitialData.Request)
    func loadPopularMovies(request: Home.LoadMovies.Request)
    func loadTopRatedMovies(request: Home.LoadMovies.Request)
    func loadUpcomingMovies(request: Home.LoadMovies.Request)
    func loadLocalMovies(request: Home.LoadLocalMovies.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker = HomeWorker()

    func loadInitialData(request: Home.LoadInitialData.Request) {
        let response = Home.LoadInitialData.Response()
        presenter?.presentInitialData(response: response)
    }

    func loadLocalMovies(request: Home.LoadLocalMovies.Request) {
        var popularMovies: [MovieCodable] = []
        var topRatedMovies: [MovieCodable] = []
        var upcomingMovies: [MovieCodable] = []
        let realm = try! Realm()

        if let popularCategory = realm.object(ofType: Category.self, forPrimaryKey: "1") {
            popularMovies = Array(popularCategory.movies)
        }

        if let topRatedCategory = realm.object(ofType: Category.self, forPrimaryKey: "2") {
            topRatedMovies = Array(topRatedCategory.movies)
        }

        if let upcomingCategory = realm.object(ofType: Category.self, forPrimaryKey: "3") {
            upcomingMovies = Array(upcomingCategory.movies)
        }

        let response = Home.LoadLocalMovies.Response(
            popularMovies: popularMovies,
            topRatedMovies: topRatedMovies,
            upcomingMovies: upcomingMovies)
        presenter?.presentLocalMovies(response: response)
    }

    func loadPopularMovies(request: Home.LoadMovies.Request) {
        let baseUrl = worker.getBaseUrl()
        let category = Category()
        category.id = "1"
        category.name = "Popular"

        worker.fetchPopular { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let populars):
                guard let results = populars.results else {
                    let response = Home.LoadError.Response(movieType: .popular)
                    self.presenter?.presentErrorMovies(response: response)
                    return
                }
                let response = Home.LoadMovies.Response(
                    baseImageUrl: baseUrl,
                    movies: results,
                    category: category)
                self.presenter?.presentPopularMovies(response: response)
            case .failure:
                let response = Home.LoadError.Response(movieType: .popular)
                self.presenter?.presentErrorMovies(response: response)
            }
        }
    }

    func loadTopRatedMovies(request: Home.LoadMovies.Request) {
        let baseUrl = worker.getBaseUrl()
        let category = Category()
        category.id = "2"
        category.name = "TopRated"

        worker.fetchTopRated { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let topRated):
                guard let results = topRated.results else {
                    let response = Home.LoadError.Response(movieType: .topRated)
                    self.presenter?.presentErrorMovies(response: response)
                    return
                }
                let response = Home.LoadMovies.Response(
                    baseImageUrl: baseUrl,
                    movies: results,
                    category: category)
                self.presenter?.presentTopRatedMovies(response: response)
            case .failure:
                let response = Home.LoadError.Response(movieType: .topRated)
                self.presenter?.presentErrorMovies(response: response)
            }
        }
    }

    func loadUpcomingMovies(request: Home.LoadMovies.Request) {
        let baseUrl = worker.getBaseUrl()
        let category = Category()
        category.id = "3"
        category.name = "Upcoming"

        worker.fetchUpcoming { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let upcoming):
                guard let results = upcoming.results else {
                    let response = Home.LoadError.Response(movieType: .upcoming)
                    self.presenter?.presentErrorMovies(response: response)
                    return
                }
                let response = Home.LoadMovies.Response(
                    baseImageUrl: baseUrl,
                    movies: results,
                    category: category)
                self.presenter?.presentUpcomingMovies(response: response)
            case .failure:
                let response = Home.LoadError.Response(movieType: .upcoming)
                self.presenter?.presentErrorMovies(response: response)
            }
        }
    }
}
