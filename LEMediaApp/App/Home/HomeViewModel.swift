//
//  HomeViewModel.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//  
//
import Foundation

class HomeViewModel: ObservableObject, Hashable {
    @Published var popularTitle: String = ""
    @Published var topRatedTitle: String = ""
    @Published var upcomingTitle: String = ""
    @Published var popularMovies: [MovieCodable] = []
    @Published var topRatedMovies: [MovieCodable] = []
    @Published var upcomingMovies: [MovieCodable] = []
    @Published var searchText: String = ""
    @Published var searchPlaceholder: String = ""
    @Published var emptyMsg: String = ""
    @Published var presentType: Home.PresentType = .myView
    @Published var isNavigationActive: Bool = false
    @Published var selectedMovie: MovieCodable = MovieCodable()

    var filteredPopularMovies: [MovieCodable] {
        guard !searchText.isEmpty else { return popularMovies }
        return popularMovies.filter { item in
            item.title.lowercased().contains(searchText.lowercased())
        }
    }

    var filteredTopRatedMovies: [MovieCodable] {
        guard !searchText.isEmpty else { return topRatedMovies }
        return topRatedMovies.filter { item in
            item.title.lowercased().contains(searchText.lowercased())
        }
    }

    var filteredUpcomingdMovies: [MovieCodable] {
        guard !searchText.isEmpty else { return upcomingMovies }
        return upcomingMovies.filter { item in
            item.title.lowercased().contains(searchText.lowercased())
        }
    }

    var interactor: HomeBusinessLogic?

    init() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        interactor.presenter = presenter
        self.interactor = interactor
        presenter.view = self
    }

    func configureView() {
        let request = Home.LoadInitialData.Request()
        self.interactor?.loadInitialData(request: request)
    }
}
protocol HomeDisplayLogic: AnyObject {
    func displayInitialData(viewModel: Home.LoadInitialData.ViewModel)
    func displayPopularMovies(viewModel: Home.LoadMovies.ViewModel)
    func displayTopRatedMovies(viewModel: Home.LoadMovies.ViewModel)
    func displayUpcomingMovies(viewModel: Home.LoadMovies.ViewModel)
    func displayLocalMovies(viewModel: Home.LoadLocalMovies.ViewModel)
    func displayErrorMovies(viewModel: Home.LoadError.ViewModel)
}

extension HomeViewModel: HomeDisplayLogic {
    func displayInitialData(viewModel: Home.LoadInitialData.ViewModel) {
        self.popularTitle = viewModel.popularTitle
        self.topRatedTitle = viewModel.topRatedTitle
        self.upcomingTitle = viewModel.upcomingTitle
        self.searchPlaceholder = viewModel.searchPlaceholder
        self.emptyMsg = viewModel.emptyMsg

        let request = Home.LoadLocalMovies.Request()
        self.interactor?.loadLocalMovies(request: request)
    }

    func displayLocalMovies(viewModel: Home.LoadLocalMovies.ViewModel) {
        let popularMovies = viewModel.popularMovies
        let topRatedMovies = viewModel.topRatedMovies
        let upcomingMovies = viewModel.upcomingMovies

        if !popularMovies.isEmpty {
            self.popularMovies = popularMovies
        } else {
            DispatchQueue.global().async { [weak self] in
                let request = Home.LoadMovies.Request()
                self?.interactor?.loadPopularMovies(request: request)
            }
        }

        if !topRatedMovies.isEmpty {
            self.topRatedMovies = topRatedMovies
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { [weak self] in
                let request = Home.LoadMovies.Request()
                self?.interactor?.loadTopRatedMovies(request: request)
            }
        }

        if !upcomingMovies.isEmpty {
            self.upcomingMovies = upcomingMovies
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) { [weak self] in
                let request = Home.LoadMovies.Request()
                self?.interactor?.loadUpcomingMovies(request: request)
            }
        }
    }

    func displayPopularMovies(viewModel: Home.LoadMovies.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.popularMovies = viewModel.movies
        }
    }

    func displayTopRatedMovies(viewModel: Home.LoadMovies.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.topRatedMovies = viewModel.movies
        }
    }

    func displayUpcomingMovies(viewModel: Home.LoadMovies.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.upcomingMovies = viewModel.movies
        }
    }

    func displayErrorMovies(viewModel: Home.LoadError.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            switch viewModel.movieType {
            case .popular:
                self?.popularMovies = viewModel.movies
            case .topRated:
                self?.topRatedMovies = viewModel.movies
            case .upcoming:
                self?.upcomingMovies = viewModel.movies
            }
        }
    }
}

extension HomeViewModel {
    func loadDetailMovement(movie: MovieCodable) {
        selectedMovie = movie
        presentType = .detailMovie
        isNavigationActive.toggle()
    }

    static func == (lhs: HomeViewModel, rhs: HomeViewModel) -> Bool {
        lhs === rhs
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
