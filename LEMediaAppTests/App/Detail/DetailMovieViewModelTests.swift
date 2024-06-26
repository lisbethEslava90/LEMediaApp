//
//  DetailMovieViewModelTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 24/06/24.
//

import XCTest
@testable import LEMediaApp

final class DetailMovieViewModelTests: XCTestCase {

    var viewModel: DetailViewModel!
    var mockInteractor: MockDetailInteractor!
    
    override func setUpWithError() throws {
        mockInteractor = MockDetailInteractor()
        viewModel = DetailViewModel()
        viewModel.interactor = mockInteractor
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockInteractor = nil
    }

    func testConfigureView() throws {
        let movie = MovieCodable(id: 1, lenguaje: "en", title: "Test Movie", overview: "Test Overview", popularity: 99.9, date: "2024-06-24", path: "")

        viewModel.configureView(movie: movie)
        let interactor = viewModel.interactor
        
        XCTAssertNotNil(interactor)
        XCTAssertTrue(mockInteractor.loadInitialDataCalled)
        XCTAssertTrue(mockInteractor.loadVideosInfoCalled)
    }
    
    func testDisplayInitialData() throws {
        let initialDataViewModel = Detail.LoadInitialData.ViewModel(
            overviewTile: "Overview",
            yearMovie: "2024",
            popularityMovie: "95% Popularity",
            languageMovie: "EN",
            otherVideosTitle: "Other Videos")
        viewModel.displayInitialData(viewModel: initialDataViewModel)

        XCTAssertEqual(viewModel.overviewTitle, "Overview")
        XCTAssertEqual(viewModel.yearMovie, "2024")
        XCTAssertEqual(viewModel.popularityMovie, "95% Popularity")
        XCTAssertEqual(viewModel.languageMovie, "EN")
        XCTAssertEqual(viewModel.otherVideosTitle, "Other Videos")
    
    }

    func testDisplayVideosInfo() throws {
        let videosInfo = [VideoInfoCodable(key: "abc", site: "YouTube", type: "Trailer"),
                          VideoInfoCodable(key: "abcd", site: "YouTube", type: "Treaser"),
                          VideoInfoCodable(key: "abcde", site: "YouTube", type: "Movie")]
        let trailer = VideoInfoCodable(key: "abc", site: "YouTube", type: "Trailer")

        let videosInfoViewModel = Detail.LoadVideosInfo.ViewModel(
            videosInfo: videosInfo, trailer: trailer)
        viewModel.displayVideosInfo(viewModel: videosInfoViewModel)
        
        XCTAssertEqual(viewModel.trailer, trailer)
        XCTAssertEqual(viewModel.videos, videosInfo)
    }
}
