//
//  HomeInteractorTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 26/06/24.
//

import XCTest
@testable import LEMediaApp

final class HomeInteractorTests: XCTestCase {
    
    var interactor: HomeInteractor!
    var mockPresenter: MockHomePresenter!

    override func setUpWithError() throws {
        interactor = HomeInteractor()
        mockPresenter = MockHomePresenter()
        interactor.presenter = mockPresenter
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockPresenter = nil
    }

    func testLoadInitialData() throws {
        let request = Home.LoadInitialData.Request()
        interactor.loadInitialData(request: request)
        
        XCTAssertTrue(mockPresenter.presentInitialDataCalled)
    }
    
    func testLoadLocalMovies() throws {
        let request = Home.LoadLocalMovies.Request()
        interactor.loadLocalMovies(request: request)
        
        XCTAssertTrue(mockPresenter.presentLocalMoviesDataCalled)
    }
    
    func testLoadPopularMovies() throws {
        interactor.worker = MockHomeWorker(isSuccess: true)
        let request = Home.LoadMovies.Request()
        
        interactor.loadPopularMovies(request: request)
        
        XCTAssertTrue(mockPresenter.presentPopularMoviesDataCalled)
        XCTAssertFalse(mockPresenter.presentErrorMoviesDataCalled)
    }
    
    func testLoadFailPopularMovies() throws {
        interactor.worker = MockHomeWorker(isSuccess: false, emptyData: true)
        let request = Home.LoadMovies.Request()
        
        interactor.loadPopularMovies(request: request)
        
        XCTAssertFalse(mockPresenter.presentPopularMoviesDataCalled)
        XCTAssertTrue(mockPresenter.presentErrorMoviesDataCalled)
    }
    
    func testLoadTopRatedMovies() throws {
        interactor.worker = MockHomeWorker(isSuccess: true)
        let request = Home.LoadMovies.Request()
        
        interactor.loadTopRatedMovies(request: request)
        
        XCTAssertTrue(mockPresenter.presentTopRatedMoviesDataCalled)
        XCTAssertFalse(mockPresenter.presentErrorMoviesDataCalled)
    }
    
    func testLoadFailTopRatedMovies() throws {
        interactor.worker = MockHomeWorker(isSuccess: false, emptyData: true)
        let request = Home.LoadMovies.Request()
        
        interactor.loadTopRatedMovies(request: request)
        
        XCTAssertFalse(mockPresenter.presentTopRatedMoviesDataCalled)
        XCTAssertTrue(mockPresenter.presentErrorMoviesDataCalled)
    }
    
    func testLoadUpcomingMovies() throws {
        interactor.worker = MockHomeWorker(isSuccess: true)
        let request = Home.LoadMovies.Request()
        
        interactor.loadUpcomingMovies(request: request)
        
        XCTAssertTrue(mockPresenter.presentUpcomingMoviesDataCalled)
        XCTAssertFalse(mockPresenter.presentErrorMoviesDataCalled)
    }
    
    func testLoadFailUpcomingMovies() throws {
        interactor.worker = MockHomeWorker(isSuccess: false, emptyData: true)
        let request = Home.LoadMovies.Request()
        
        interactor.loadUpcomingMovies(request: request)
        
        XCTAssertFalse(mockPresenter.presentUpcomingMoviesDataCalled)
        XCTAssertTrue(mockPresenter.presentErrorMoviesDataCalled)
    }
}
