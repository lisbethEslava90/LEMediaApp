//
//  MockHomeWorker.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import Foundation
@testable import LEMediaApp

class MockHomeWorker: HomeWorker {
    var isSuccess: Bool
    var emptyData: Bool
    
    init(isSuccess: Bool, emptyData: Bool = false) {
        self.isSuccess = isSuccess
        self.emptyData = emptyData
    }

    override func fetchPopular(completionHandler: @escaping (Result<ResultsResponse>) -> Void) {
        if isSuccess {
            let popularMovies = emptyData ? [] : [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview                                         inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                                                  MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: "")]
            let response = ResultsResponse(results: popularMovies)
            completionHandler(Result<ResultsResponse>.success(response))
        } else {
            completionHandler(Result<ResultsResponse>.failure(nil))
        }
    }

    override func fetchTopRated(completionHandler: @escaping (Result<ResultsResponse>) -> Void) {
        if isSuccess {
            let topRatedMovies = emptyData ? [] : [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview                                         inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                                                  MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: "")]
            let response = ResultsResponse(results: topRatedMovies)
            completionHandler(Result<ResultsResponse>.success(response))
        } else {
            completionHandler(Result<ResultsResponse>.failure(nil))
        }
    }
    
    override func fetchUpcoming(completionHandler: @escaping (Result<ResultsResponse>) -> Void) {
        if isSuccess {
            let upcomingMovies = emptyData ? [] : [MovieCodable(id: 1, lenguaje: "en", title: "Inside Out 2", overview: "Test Overview                                         inside out 2", popularity: 80.0, date: "2024-06-01", path: ""),
                                                  MovieCodable(id: 2, lenguaje: "en", title: "Inside Out", overview: "Test Overview inside out", popularity: 60.5, date: "2019-06-24", path: "")]
            let response = ResultsResponse(results: upcomingMovies)
            completionHandler(Result<ResultsResponse>.success(response))
        } else {
            completionHandler(Result<ResultsResponse>.failure(nil))
        }
    }
}
