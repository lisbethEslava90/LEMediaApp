//
//  HomeApi.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

protocol HomeApi {
    func fetchPopularMovies() -> URLRequest
}

struct HomeApiImpl: HomeApi {
    public func fetchPopularMovies() -> URLRequest {
        let url = HomeApiImpl.popularMovies.toURL()
        let request = URLRequest(url: url)
            .add(httpMethod: .get)
            .add(headers: defaultHeaders())
        return request
    }
}

extension HomeApiImpl {
    public static let popularMovies: String = "https://api.themoviedb.org/3/movie/popular"
}
