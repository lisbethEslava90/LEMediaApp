//
//  HomePresenter.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

protocol HomePresentationLogic {
    func presentInitialData(response: Home.LoadInitialData.Response)
    func presentPopularMovies(response: Home.LoadPopular.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var view: HomeDisplayLogic?

    func presentInitialData(response: Home.LoadInitialData.Response) {
    }

    func presentPopularMovies(response: Home.LoadPopular.Response) {}
}
