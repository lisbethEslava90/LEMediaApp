//
//  HomeModel.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

enum Home {
    enum LoadInitialData {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let popularTitle: String
            let topRatedTitle: String
            let upcomingTitle: String
        }
    }

    enum LoadMovies {
        struct Request {}
        struct Response {
            let baseImageUrl: String
            var movies: [MovieResponse]
        }
        struct ViewModel {
            var movies: [MovieResponse]
        }
    }

    enum LoadError {
        struct Request {}
        struct Response {
            let movieType: MovieType
        }
        struct ViewModel {
            let movieType: MovieType
            var movies: [MovieResponse]
        }
    }

    enum MovieType {
        case popular
        case topRated
        case upcoming
    }
}
