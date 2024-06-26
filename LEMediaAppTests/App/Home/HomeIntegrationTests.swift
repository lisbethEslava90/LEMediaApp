//
//  HomeIntegrationTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 26/06/24.
//

import XCTest
@testable import LEMediaApp

final class HomeIntegrationTests: XCTestCase {

    var viewModel: HomeViewModel!
    var interactor: HomeInteractor!
    var presenter: HomePresenter!
    var worker: MockHomeWorker!
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel()
        interactor = HomeInteractor()
        presenter = HomePresenter()
        interactor.presenter = presenter
        presenter.view = viewModel
        viewModel.interactor = interactor
        interactor.worker = MockHomeWorker(isSuccess: true)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        interactor = nil
        presenter = nil
        worker = nil
    }

    func testConfigureView() throws {
        interactor.worker = MockHomeWorker(isSuccess: true)
        viewModel.configureView()
        
        XCTAssertEqual(viewModel.popularTitle, "Popular")
        XCTAssertEqual(viewModel.topRatedTitle, "Top Rated")
        XCTAssertEqual(viewModel.upcomingTitle, "Upcoming")
        XCTAssertEqual(viewModel.popularMovies.count, 20)
        XCTAssertEqual(viewModel.topRatedMovies.count, 20)
        XCTAssertEqual(viewModel.upcomingMovies.count, 20)
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.searchPlaceholder, "Search...")
        XCTAssertFalse(viewModel.filteredPopularMovies.isEmpty)
    }
}
