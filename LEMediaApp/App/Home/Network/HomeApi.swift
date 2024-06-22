//
//  HomeApi.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

protocol HomeApi {
    func fetchPopularMovies() -> URLRequest
    func fetchTopRatedMovies() -> URLRequest
    func fetchUpcomingMovies() -> URLRequest
    func getPosterBaseUrl() -> String
}

struct HomeApiImpl: HomeApi {
    public func fetchPopularMovies() -> URLRequest {
        let url = HomeApiImpl.popularMovies.toURL()
        let request = URLRequest(url: url)
            .add(httpMethod: .get)
            .add(headers: defaultHeaders())
        return request
    }

    public func fetchTopRatedMovies() -> URLRequest {
        let url = HomeApiImpl.topRatedMovies.toURL()
        let request = URLRequest(url: url)
            .add(httpMethod: .get)
            .add(headers: defaultHeaders())
        return request
    }

    public func fetchUpcomingMovies() -> URLRequest {
        let url = HomeApiImpl.upcomingMovies.toURL()
        let request = URLRequest(url: url)
            .add(httpMethod: .get)
            .add(headers: defaultHeaders())
        return request
    }

    func getPosterBaseUrl() -> String {
        return HomeApiImpl.poster
    }
}

extension HomeApiImpl {
    public static let popularMovies: String = "https://api.themoviedb.org/3/movie/popular"
    public static let poster: String = "https://image.tmdb.org/t/p/w500"
    public static let topRatedMovies: String = "https://api.themoviedb.org/3/movie/top_rated"
    public static let upcomingMovies: String = "https://api.themoviedb.org/3/movie/upcoming"
}
