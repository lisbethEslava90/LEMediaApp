//
//  HomePresenter.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

protocol HomePresentationLogic {
    func presentInitialData(response: Home.LoadInitialData.Response)
    func presentPopularMovies(response: Home.LoadMovies.Response)
    func presentTopRatedMovies(response: Home.LoadMovies.Response)
    func presentUpcomingMovies(response: Home.LoadMovies.Response)
    func presentErrorMovies(response: Home.LoadError.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var view: HomeDisplayLogic?

    func presentInitialData(response: Home.LoadInitialData.Response) {
        let viewModel = Home.LoadInitialData.ViewModel(
            popularTitle: "Popular",
            topRatedTitle: "Top Rated",
            upcomingTitle: "Upcoming",
            searchPlaceholder: "Search...",
            emptyMsg: "No results in this category")
        self.view?.displayInitialData(viewModel: viewModel)
    }

    func presentPopularMovies(response: Home.LoadMovies.Response) {
        let posterbaseUrl = response.baseImageUrl
        var popularMovies = response.movies

        popularMovies.indices.forEach {
            let shortPath = popularMovies[$0].poster_path.toURL()
            let path = "\(posterbaseUrl)\(shortPath)"
            popularMovies[$0].posterUrl = path.toURL()
        }

        let viewModel = Home.LoadMovies.ViewModel(movies: popularMovies)
        self.view?.displayPopularMovies(viewModel: viewModel)
    }

    func presentTopRatedMovies(response: Home.LoadMovies.Response) {
        let posterbaseUrl = response.baseImageUrl
        var topRated = response.movies

        topRated.indices.forEach {
            let shortPath = topRated[$0].poster_path.toURL()
            let path = "\(posterbaseUrl)\(shortPath)"
            topRated[$0].posterUrl = path.toURL()
        }

        let viewModel = Home.LoadMovies.ViewModel(movies: topRated)
        self.view?.displayTopRatedMovies(viewModel: viewModel)
    }

    func presentUpcomingMovies(response: Home.LoadMovies.Response) {
        let posterbaseUrl = response.baseImageUrl
        var upcoming = response.movies

        upcoming.indices.forEach {
            let shortPath = upcoming[$0].poster_path.toURL()
            let path = "\(posterbaseUrl)\(shortPath)"
            upcoming[$0].posterUrl = path.toURL()
        }

        let viewModel = Home.LoadMovies.ViewModel(movies: upcoming)
        self.view?.displayUpcomingovies(viewModel: viewModel)
    }

    func presentErrorMovies(response: Home.LoadError.Response) {
        let movies = [
            MovieResponse(),
            MovieResponse(),
            MovieResponse()
        ]
        let viewModel = Home.LoadError.ViewModel(movieType: response.movieType, movies: movies)
        self.view?.displayErrorMovies(viewModel: viewModel)
    }
}
