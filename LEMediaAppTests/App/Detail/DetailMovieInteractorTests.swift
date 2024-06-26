//
//  DetailMovieInteractorTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import XCTest
@testable import LEMediaApp

final class DetailMovieInteractorTests: XCTestCase {

    var interactor: DetailInteractor!
    var mockPresenter: MockDetailPresenter!

    override func setUpWithError() throws {
        interactor = DetailInteractor()
        mockPresenter = MockDetailPresenter()
        interactor.presenter = mockPresenter
    }

    override func tearDownWithError() throws {
        interactor = nil
        mockPresenter = nil
    }

    func testLoadInitialData() throws {
        let movie = MovieCodable(id: 1, lenguaje: "en", title: "Test Movie", overview: "Test Overview", popularity: 99.9, date: "2024-06-24", path: "")
        let request = Detail.LoadInitialData.Request(movie: movie)
        interactor.loadInitialData(request: request)

        XCTAssertTrue(mockPresenter.presentInitialDataCalled)
    }

    func testLoadVideosInfo() throws {
        interactor.worker = MockDetailWorker(isSuccess: true)
        let request = Detail.LoadVideosInfo.Request(movieId: 1)

        interactor.loadVideosInfo(request: request)
        
        XCTAssertTrue(mockPresenter.presentVideosInfoCalled)
    }
}
