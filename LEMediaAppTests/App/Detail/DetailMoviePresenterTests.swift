//
//  DetailMoviePresenterTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import XCTest
@testable import LEMediaApp

final class DetailMoviePresenterTests: XCTestCase {
    
    var presenter: DetailPresenter!
    var mockViewModel: MockDetailViewModel!

    override func setUpWithError() throws {
        presenter = DetailPresenter()
        mockViewModel = MockDetailViewModel()
        presenter.view = mockViewModel
    }

    override func tearDownWithError() throws {
        presenter = nil
        mockViewModel = nil
    }

    func testPresentInitialData() throws {
        let movie = MovieCodable(id: 1, lenguaje: "en", title: "Test Movie", overview: "Test Overview", popularity: 99.9, date: "2024-06-24", path: "")
        let response = Detail.LoadInitialData.Response(movie: movie)
        
        presenter.presentInitialData(response: response)
        
        XCTAssertTrue(mockViewModel.displayInitialDataCalled)
    }

    func testPresentVideosInfo() {
        let movieInfo = [VideoInfoCodable(key: "abc", site: "YouTube", type: "Trailer")]
        let response = Detail.LoadVideosInfo.Response(baseVideoUrl: "https://www.youtube.com/embed/abc", videosInfo: movieInfo)
        
        presenter.presentVideosInfo(response: response)
        
        XCTAssertTrue(mockViewModel.displayVideosCalled)
    }
}
