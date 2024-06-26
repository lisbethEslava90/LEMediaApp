//
//  DetailApiTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import XCTest
@testable import LEMediaApp

final class DetailApiTests: XCTestCase {
    
    var api: DetailApiImpl!

    override func setUpWithError() throws {
        api = DetailApiImpl()
    }

    override func tearDownWithError() throws {
        api = nil
    }

    func testFetchVideosInfo() throws {
        let movieId = "123"
        let request = api.fetchVideosInfo(id: movieId)
        let headers = request.allHTTPHeaderFields
        let expectedUrlString = "https://api.themoviedb.org/3/movie/123/videos?language=en-US"
        
        XCTAssertEqual(request.url?.absoluteString, expectedUrlString)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(headers?["Accept"], "application/json")
        XCTAssertNotNil(headers?["Authorization"])
    }

    func testGetVideoUrl() throws {
        let videoUrl = api.getVideoUrl()
        let expectedUrl = "https://www.youtube.com/embed/"
        XCTAssertEqual(videoUrl, expectedUrl)
    }
}
