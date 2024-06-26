//
//  MockDetailInteractor.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 24/06/24.
//

import Foundation
@testable import LEMediaApp

class MockDetailInteractor: DetailBusinessLogic {
    var presenter: DetailPresentationLogic?
    var loadInitialDataCalled = false
    var loadVideosInfoCalled = false
    
    func loadInitialData(request: Detail.LoadInitialData.Request) {
        loadInitialDataCalled = true
    }
    
    func loadVideosInfo(request: Detail.LoadVideosInfo.Request) {
        loadVideosInfoCalled = true
    }
}
