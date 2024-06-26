//
//  HomeApiTests.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 26/06/24.
//

import XCTest
@testable import LEMediaApp

final class HomeApiTests: XCTestCase {
    
    var api: HomeApiImpl!

    override func setUpWithError() throws {
        api = HomeApiImpl()
    }

    override func tearDownWithError() throws {
        api = nil
    }

    func testFetchPopularMovies() throws {
        let request = api.fetchPopularMovies()
        let headers = request.allHTTPHeaderFields
        let expectedUrlString = "https://api.themoviedb.org/3/movie/popular"
        
        XCTAssertEqual(request.url?.absoluteString, expectedUrlString)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(headers?["Accept"], "application/json")
        XCTAssertNotNil(headers?["Authorization"])
    }
    
    func testFetchTopRatedMovies() throws {
        let request = api.fetchTopRatedMovies()
        let headers = request.allHTTPHeaderFields
        let expectedUrlString = "https://api.themoviedb.org/3/movie/top_rated"
        
        XCTAssertEqual(request.url?.absoluteString, expectedUrlString)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(headers?["Accept"], "application/json")
        XCTAssertNotNil(headers?["Authorization"])
    }
    
    func testFetchUpcomingMovies() throws {
        let request = api.fetchUpcomingMovies()
        let headers = request.allHTTPHeaderFields
        let expectedUrlString = "https://api.themoviedb.org/3/movie/upcoming"
        
        XCTAssertEqual(request.url?.absoluteString, expectedUrlString)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(headers?["Accept"], "application/json")
        XCTAssertNotNil(headers?["Authorization"])
    }
    
    func testGetPosterBaseUrl() throws {
        let posterUrl = api.getPosterBaseUrl()
        let expectedUrl = "https://image.tmdb.org/t/p/w500"
        XCTAssertEqual(posterUrl, expectedUrl)
    }
}
