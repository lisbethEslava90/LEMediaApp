//
//  DetailIntegrationTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 26/06/24.
//

import XCTest
@testable import LEMediaApp

final class DetailIntegrationTests: XCTestCase {
    
    var viewModel: DetailViewModel!
    var interactor: DetailInteractor!
    var presenter: DetailPresenter!
    var worker: MockDetailWorker!

    override func setUpWithError() throws {
        viewModel = DetailViewModel()
        interactor = DetailInteractor()
        presenter = DetailPresenter()
        interactor.presenter = presenter
        presenter.view = viewModel
        viewModel.interactor = interactor
        interactor.worker = MockDetailWorker(isSuccess: true)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        interactor = nil
        presenter = nil
        worker = nil
    }

    func testConfigureView() throws {
        let expectation = self.expectation(description: "Async load videos movies data")
        interactor.worker = MockDetailWorker(isSuccess: true)
        let movie = MovieCodable(id: 1022789, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview inside out 2", popularity: 8340.0, date: "2024-06-01", path: "")
        viewModel.configureView(movie: movie)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertEqual(viewModel.movie.title, "Inside Out 2")
        XCTAssertEqual(viewModel.overviewTitle, "Overview")
        XCTAssertEqual(viewModel.yearMovie, "2024")
        XCTAssertEqual(viewModel.popularityMovie, "83% popularity")
        XCTAssertEqual(viewModel.languageMovie, "EN")
        XCTAssertEqual(viewModel.otherVideosTitle, "Other Videos")
        XCTAssertEqual(viewModel.videos.count, 2)
        XCTAssertFalse(viewModel.trailer.key.isEmpty)
        
    }
}
