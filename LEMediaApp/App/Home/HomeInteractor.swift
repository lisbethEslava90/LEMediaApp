//
//  HomeInteractor.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

protocol HomeBusinessLogic {
    func loadInitialData(request: Home.LoadInitialData.Request)
    func loadPopularMovies(request: Home.LoadPopular.Request)
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker = HomeWorker()

    func loadInitialData(request: Home.LoadInitialData.Request) {
    }

    func loadPopularMovies(request: Home.LoadPopular.Request) {
        worker.fetch { result in
            switch result {
            case .success(let populars):
                print("tengo las populares :\(populars)")
            case .failure(let error):
                print("pailas :\(error)")
            }
        }
    }
}
