//
//  MockDetailWorker.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import Foundation
@testable import LEMediaApp

class MockDetailWorker: DetailWorker {
    var isSuccess: Bool
    var emptyData: Bool
    
    init(isSuccess: Bool, emptyData: Bool = false) {
        self.isSuccess = isSuccess
        self.emptyData = emptyData
    }
    
    override func fetch(movieId: String, completionHandler: @escaping (Result<VideosResponse>) -> Void) {
        if isSuccess {
            let detailVideo = emptyData ? [] : [VideoInfoCodable(key: "abc", site: "YouTube", type: "Trailer"),
                                           VideoInfoCodable(key: "abcd", site: "YouTube", type: "Treaser"),
                                           VideoInfoCodable(key: "abcde", site: "YouTube", type: "Movie")]
            let response = VideosResponse(id: 1, results: detailVideo)
            completionHandler(Result<VideosResponse>.success(response))
        } else {
            completionHandler(Result<VideosResponse>.failure(nil))
        }
    }
}
