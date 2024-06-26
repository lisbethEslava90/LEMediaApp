//
//  MockHomeInteractor.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import Foundation
@testable import LEMediaApp

class MockHomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var loadInitialDataCalled = false
    var loadPopularMoviesDataCalled = false
    var loadTopRatedMoviesDataCalled = false
    var loadUpcomingMoviesDataCalled = false
    var loadLocalMoviesDataCalled = true
    
    func loadInitialData(request: Home.LoadInitialData.Request) {
        loadInitialDataCalled = true
    }
    
    func loadPopularMovies(request: Home.LoadMovies.Request) {
        loadPopularMoviesDataCalled = true
    }
    
    func loadTopRatedMovies(request: Home.LoadMovies.Request) {
        loadTopRatedMoviesDataCalled = true
    }
    
    func loadUpcomingMovies(request: Home.LoadMovies.Request) {
        loadUpcomingMoviesDataCalled = true
    }
    
    func loadLocalMovies(request: Home.LoadLocalMovies.Request) {
        loadLocalMoviesDataCalled = true
    }
}
