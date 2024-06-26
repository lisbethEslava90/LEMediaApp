//
//  MockDetailPresenter.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 24/06/24.
//

import Foundation
@testable import LEMediaApp

class MockDetailPresenter: DetailPresentationLogic {
    var view: DetailDisplayLogic?
    var presentInitialDataCalled = false
    var presentVideosInfoCalled = false
    
    var initialDataViewModel: Detail.LoadInitialData.ViewModel?
    var videosInfoViewModel: Detail.LoadVideosInfo.ViewModel?
    
    func presentInitialData(response: Detail.LoadInitialData.Response) {
        presentInitialDataCalled = true
    }

    func presentVideosInfo(response: Detail.LoadVideosInfo.Response) {
       presentVideosInfoCalled = true
    }
}
