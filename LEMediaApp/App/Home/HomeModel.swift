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
        struct ViewModel {}
    }

    enum LoadPopular {
        struct Request {}
        struct Response {
            var populars: [MovieResponse]
        }
        struct ViewModel {
            var populars: [MovieResponse]
        }
    }
}
