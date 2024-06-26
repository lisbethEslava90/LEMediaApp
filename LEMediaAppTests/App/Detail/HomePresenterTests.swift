//
//  HomePresenterTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 26/06/24.
//

import XCTest
@testable import LEMediaApp

final class HomePresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    var mockViewModel: MockHomeViewModel!

    override func setUpWithError() throws {
        presenter = HomePresenter()
        mockViewModel = MockHomeViewModel()
        presenter.view = mockViewModel
    }

    override func tearDownWithError() throws {
        presenter = nil
        mockViewModel = nil
    }

    func testPresentInitialData() throws {
        let response = Home.LoadInitialData.Response()
        presenter.presentInitialData(response: response)
        
        XCTAssertTrue(mockViewModel.displayInitialDataCalled)
    }
    
    func testPresentLocalMovies() throws {
        let movies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                      MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                      MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]
        let response = Home.LoadLocalMovies.Response(
            popularMovies: movies,
            topRatedMovies: movies,
            upcomingMovies: movies)
        presenter.presentLocalMovies(response: response)
        
        XCTAssertTrue(mockViewModel.displayLocalMoviesCalled)
    }
    
    func testPresentPopularMovies() throws {
        let popularMovies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                             MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                             MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]
        
        let category = Category()
        category.id = UUID().uuidString
        category.name = "Popular"
        
        let response = Home.LoadMovies.Response(
            baseImageUrl: "https://image.tmdb.org/t/p/w500",
            movies: popularMovies,
            category: category)
        presenter.presentPopularMovies(response: response)
        
        XCTAssertTrue(mockViewModel.displayPopularMoviesCalled)
    }

    func testPresentTopRatedMovies() throws {
        let topRatedMovies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                              MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                              MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]
        
        let category = Category()
        category.id = UUID().uuidString
        category.name = "TopRated"
        
        let response = Home.LoadMovies.Response(
            baseImageUrl: "https://image.tmdb.org/t/p/w500",
            movies: topRatedMovies,
            category: category)
        presenter.presentTopRatedMovies(response: response)
        
        XCTAssertTrue(mockViewModel.displayTopRatedMoviesCalled)
    }
    
    func testPresentUpcomingMovies() throws {
        let upcomingMovies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                              MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                              MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]
        
        let category = Category()
        category.id = UUID().uuidString
        category.name = "Upcoming"
        
        let response = Home.LoadMovies.Response(
            baseImageUrl: "https://image.tmdb.org/t/p/w500",
            movies: upcomingMovies,
            category: category)
        presenter.presentUpcomingMovies(response: response)
        
        XCTAssertTrue(mockViewModel.displayUpcomingMoviesCalled)
    }
    
    func testPresentErrorMovies() {
        var response = Home.LoadError.Response(movieType: .popular)
        presenter.presentErrorMovies(response: response)
        
        XCTAssertTrue(mockViewModel.displayErrorMoviesCalled)
        XCTAssertFalse(mockViewModel.displayPopularMoviesCalled)
        
        response.movieType = .topRated
        XCTAssertTrue(mockViewModel.displayErrorMoviesCalled)
        XCTAssertFalse(mockViewModel.displayTopRatedMoviesCalled)
        
        response.movieType = .upcoming
        XCTAssertTrue(mockViewModel.displayErrorMoviesCalled)
        XCTAssertFalse(mockViewModel.displayUpcomingMoviesCalled)
    }
}
