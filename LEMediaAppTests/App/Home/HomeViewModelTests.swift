//
//  HomeViewModelTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import XCTest
@testable import LEMediaApp

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockInteractor: MockHomeInteractor!

    override func setUpWithError() throws {
        mockInteractor = MockHomeInteractor()
        viewModel = HomeViewModel()
        viewModel.interactor = mockInteractor
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockInteractor = nil
    }

    func testConfigureView() throws {
        viewModel.configureView()
        let interactor = viewModel.interactor
        
        XCTAssertNotNil(interactor)
        XCTAssertTrue(mockInteractor.loadInitialDataCalled)
    }
    
    func testFilteredPopularMovies() throws {
        let movies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                      MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                      MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]

        viewModel.popularMovies = movies
        
        viewModel.searchText = ""
        XCTAssertEqual(viewModel.filteredPopularMovies.count, 3)
        
        viewModel.searchText = "Out"
        XCTAssertEqual(viewModel.filteredPopularMovies.count, 2)
        XCTAssertEqual(viewModel.filteredPopularMovies.first?.title, "Inside Out 2")
    }
    
    func testFilteredTopRatedMovies() throws {
        let movies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                      MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                      MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]

        viewModel.popularMovies = movies
        
        viewModel.searchText = "Avatar"
        XCTAssertEqual(viewModel.filteredPopularMovies.count, 0)
    }
    
    func testFilteredUpcomingMovies() throws {
        let movies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                      MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                      MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]

        viewModel.popularMovies = movies
        
        viewModel.searchText = "iNsIdE OUT"
        XCTAssertEqual(viewModel.filteredPopularMovies.count, 2)
    }
    
    func testDisplayInitialData() throws {
        let initialDataViewModel = Home.LoadInitialData.ViewModel(
            popularTitle: "Popular",
            topRatedTitle: "Top Rated", upcomingTitle: "Upcoming",
            searchPlaceholder: "Search...",
            emptyMsg: "No results in this category")
        
        viewModel.displayInitialData(viewModel: initialDataViewModel)
        
        XCTAssertEqual(viewModel.popularTitle, "Popular")
        XCTAssertEqual(viewModel.topRatedTitle, "Top Rated")
        XCTAssertEqual(viewModel.upcomingTitle, "Upcoming")
        XCTAssertEqual(viewModel.searchPlaceholder, "Search...")
        XCTAssertEqual(viewModel.emptyMsg, "No results in this category")
        XCTAssertTrue(mockInteractor.loadLocalMoviesDataCalled)
    }

    func testDisplayLocalMovies() throws {
        let expectation = self.expectation(description: "Async load movies data")
        let localMoviesViewModel = Home.LoadLocalMovies.ViewModel(
            popularMovies: [], topRatedMovies: [], upcomingMovies: [])
        
        viewModel.displayLocalMovies(viewModel: localMoviesViewModel)
        let interactor = viewModel.interactor
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)

        XCTAssertNotNil(interactor)
        XCTAssertTrue(mockInteractor.loadPopularMoviesDataCalled)
        XCTAssertTrue(mockInteractor.loadTopRatedMoviesDataCalled)
        XCTAssertTrue(mockInteractor.loadUpcomingMoviesDataCalled)
    }
    
    func testDisplayPopularMovies() throws {
        let movies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                      MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                      MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]
        let popularMoviesViewModel = Home.LoadMovies.ViewModel(movies: movies)
        
        viewModel.displayPopularMovies(viewModel: popularMoviesViewModel)
        
        XCTAssertNotNil(viewModel.popularMovies)
    }
    
    func testDisplayTopRatedMovies() throws {
        let movies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                      MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                      MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]
        let topRatedMoviesViewModel = Home.LoadMovies.ViewModel(movies: movies)
        
        viewModel.displayTopRatedMovies(viewModel: topRatedMoviesViewModel)
        
        XCTAssertNotNil(viewModel.topRatedMovies)
    }
    
    func testDisplayUpcomingMovies() throws {
        let movies = [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                      MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: ""),
                      MovieCodable(id: 3, lenguaje: "en", title: "Dune", overview: "Test Overview Dune", popularity: 40.3, date: "2018-06-24", path: "")]
        let upcomingMoviesViewModel = Home.LoadMovies.ViewModel(movies: movies)
        
        viewModel.displayUpcomingMovies(viewModel: upcomingMoviesViewModel)
        
        XCTAssertNotNil(viewModel.upcomingMovies)
    }

    func testDisplayError() throws {
        var errorViewModel = Home.LoadError.ViewModel(movieType: .popular, movies: [])
        
        viewModel.displayErrorMovies(viewModel: errorViewModel)
        XCTAssertFalse(viewModel.popularMovies.count > 0)
        
        errorViewModel.movieType = .topRated
        viewModel.displayErrorMovies(viewModel: errorViewModel)
        XCTAssertEqual(viewModel.topRatedMovies.count, 0)
        
        errorViewModel.movieType = .upcoming
        viewModel.displayErrorMovies(viewModel: errorViewModel)
        XCTAssertTrue(viewModel.upcomingMovies.isEmpty)
    }
    
    func testLoadDetailMovement() throws {
        let movie = MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 80.0, date: "2024-06-01", path: "")
        viewModel.loadDetailMovement(movie: movie)
        
        viewModel.loadDetailMovement(movie: movie)
        
        XCTAssertNotNil(viewModel.selectedMovie)
    }
}
