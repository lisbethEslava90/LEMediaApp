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
    @Published var popularMovies: [MovieResponse] = []
    @Published var topRatedMovies: [MovieResponse] = []
    @Published var upcomingMovies: [MovieResponse] = []
    @Published var searchText: String = ""
    @Published var searchPlaceholder: String = ""
    @Published var emptyMsg: String = ""
    @Published var presentType: Home.PresentType = .myView
    @Published var isNavigationActive: Bool = false
    @Published var selectedMovie: MovieResponse = MovieResponse()

    var filteredPopularMovies: [MovieResponse] {
        guard !searchText.isEmpty else { return popularMovies }
        return popularMovies.filter { item in
            item.title.lowercased().contains(searchText.lowercased())
        }
    }

    var filteredTopRatedMovies: [MovieResponse] {
        guard !searchText.isEmpty else { return topRatedMovies }
        return topRatedMovies.filter { item in
            item.title.lowercased().contains(searchText.lowercased())
        }
    }

    var filteredUpcomingdMovies: [MovieResponse] {
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
    func displayUpcomingovies(viewModel: Home.LoadMovies.ViewModel)
    func displayErrorMovies(viewModel: Home.LoadError.ViewModel)
}

extension HomeViewModel: HomeDisplayLogic {
    func displayInitialData(viewModel: Home.LoadInitialData.ViewModel) {
        self.popularTitle = viewModel.popularTitle
        self.topRatedTitle = viewModel.topRatedTitle
        self.upcomingTitle = viewModel.upcomingTitle
        self.searchPlaceholder = viewModel.searchPlaceholder
        self.emptyMsg = viewModel.emptyMsg

        DispatchQueue.global().async { [weak self] in
            let request = Home.LoadMovies.Request()
            self?.interactor?.loadPopularMovies(request: request)
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { [weak self] in
            let request = Home.LoadMovies.Request()
            self?.interactor?.loadTopRatedMovies(request: request)
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let request = Home.LoadMovies.Request()
            self?.interactor?.loadUpcomingMovies(request: request)
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

    func displayUpcomingovies(viewModel: Home.LoadMovies.ViewModel) {
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
    func loadDetailMovement(movie: MovieResponse) {
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
