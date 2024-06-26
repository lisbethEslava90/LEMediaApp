//
//  MockHomeViewModel.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import Foundation
@testable import LEMediaApp

class MockHomeViewModel: HomeDisplayLogic {
    var displayInitialDataCalled: Bool = false
    var displayPopularMoviesCalled: Bool = false
    var displayTopRatedMoviesCalled: Bool = false
    var displayUpcomingMoviesCalled: Bool = false
    var displayLocalMoviesCalled: Bool = false
    var displayErrorMoviesCalled: Bool = false
    
    func displayInitialData(viewModel: Home.LoadInitialData.ViewModel) {
        displayInitialDataCalled = true
    }
    
    func displayPopularMovies(viewModel: Home.LoadMovies.ViewModel) {
        displayPopularMoviesCalled = true
    }
    
    func displayTopRatedMovies(viewModel: Home.LoadMovies.ViewModel) {
        displayTopRatedMoviesCalled = true
    }
    
    func displayUpcomingMovies(viewModel: Home.LoadMovies.ViewModel) {
        displayUpcomingMoviesCalled = true
    }
    
    func displayLocalMovies(viewModel: Home.LoadLocalMovies.ViewModel) {
        displayLocalMoviesCalled = true
    }
    
    func displayErrorMovies(viewModel: Home.LoadError.ViewModel) {
        displayErrorMoviesCalled = true
    }
}
