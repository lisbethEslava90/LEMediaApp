//
//  HomeViewModel.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

class HomeViewModel: ObservableObject {
    // @Published var value: [String] = []
    var interactor: HomeBusinessLogic?

    func configureView() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        interactor.presenter = presenter
        self.interactor = interactor
        presenter.view = self

        let request = Home.LoadPopular.Request()
        self.interactor?.loadPopularMovies(request: request)
//        let request = Home.LoadInitialData.Request()
//        self.interactor?.loadInitialData(request: request)
    }
}
protocol HomeDisplayLogic: AnyObject {
    func displayInitialData(viewModel: Home.LoadInitialData.ViewModel)
    func displayPopularMovies(viewModel: Home.LoadPopular.ViewModel)
}

extension HomeViewModel: HomeDisplayLogic {
    func displayInitialData(viewModel: Home.LoadInitialData.ViewModel) {
        let request = Home.LoadPopular.Request()
        self.interactor?.loadPopularMovies(request: request)
    }

    func displayPopularMovies(viewModel: Home.LoadPopular.ViewModel) {}
}

extension HomeViewModel {
}
