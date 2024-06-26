//
//  MockHomePresenter.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import Foundation
@testable import LEMediaApp

class MockHomePresenter: HomePresentationLogic {
    var view: HomeDisplayLogic?
    var presentInitialDataCalled = false
    var presentPopularMoviesDataCalled = false
    var presentTopRatedMoviesDataCalled = false
    var presentUpcomingMoviesDataCalled = false
    var presentLocalMoviesDataCalled = false
    var presentErrorMoviesDataCalled = false
    
    var initialDataViewModel: Home.LoadInitialData.ViewModel?
    var localMoviesViewModel: Home.LoadLocalMovies.ViewModel?
    var moviesViewModel: Home.LoadMovies.ViewModel?
    
    func presentInitialData(response: Home.LoadInitialData.Response) {
        presentInitialDataCalled = true
    }
    
    func presentPopularMovies(response: Home.LoadMovies.Response) {
        presentPopularMoviesDataCalled = true
    }
    
    func presentTopRatedMovies(response: Home.LoadMovies.Response) {
        presentTopRatedMoviesDataCalled = true
    }
    
    func presentUpcomingMovies(response: Home.LoadMovies.Response) {
        presentUpcomingMoviesDataCalled = true
    }
    
    func presentLocalMovies(response: Home.LoadLocalMovies.Response) {
        presentLocalMoviesDataCalled = true
    }
    
    func presentErrorMovies(response: Home.LoadError.Response) {
        presentErrorMoviesDataCalled = true
    }
}
