//
// MockDetailViewModel.swift
//  LEMediaAppTests
//
//  Created by Lisbeth Eslava on 25/06/24.
//

import Foundation
@testable import LEMediaApp

class MockDetailViewModel: DetailDisplayLogic {
    var displayInitialDataCalled: Bool = false
    var displayVideosCalled: Bool = false
    
    func displayInitialData(viewModel: Detail.LoadInitialData.ViewModel) {
        displayInitialDataCalled  = true
    }
    
    func displayVideosInfo(viewModel: Detail.LoadVideosInfo.ViewModel) {
        displayVideosCalled = true
    }
}
