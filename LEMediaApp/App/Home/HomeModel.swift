//
//  HomeModel.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

enum Home {
    enum PresentType {
        case myView
        case detailMovie
    }

    enum LoadInitialData {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let popularTitle: String
            let topRatedTitle: String
            let upcomingTitle: String
            let searchPlaceholder: String
            let emptyMsg: String
        }
    }

    enum LoadLocalMovies {
        struct Request {}
        struct Response {
            var popularMovies: [MovieCodable]
            var topRatedMovies: [MovieCodable]
            var upcomingMovies: [MovieCodable]
        }
        struct ViewModel {
            var popularMovies: [MovieCodable]
            var topRatedMovies: [MovieCodable]
            var upcomingMovies: [MovieCodable]
        }
    }

    enum LoadMovies {
        struct Request {}
        struct Response {
            let baseImageUrl: String
            var movies: [MovieCodable]
            let category: Category
        }
        struct ViewModel {
            var movies: [MovieCodable]
        }
    }

    enum LoadError {
        struct Request {}
        struct Response {
            let movieType: MovieType
        }
        struct ViewModel {
            let movieType: MovieType
            var movies: [MovieCodable]
        }
    }

    enum MovieType {
        case popular
        case topRated
        case upcoming
    }
}
