//
//  DetailViewModel.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//  
//
import Foundation

class DetailViewModel: ObservableObject {
    @Published var movie: MovieCodable = MovieCodable()
    @Published var overviewTitle: String = ""
    @Published var yearMovie: String = ""
    @Published var popularityMovie: String = ""
    @Published var languageMovie: String = ""
    @Published var otherVideosTitle: String = ""
    @Published var videos: [VideoInfoCodable] = []
    @Published var trailer: VideoInfoCodable = VideoInfoCodable(key: "", site: "", type: "")
    var interactor: DetailBusinessLogic?

    init() {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        interactor.presenter = presenter
        self.interactor = interactor
        presenter.view = self
    }

    func configureView(movie: MovieCodable) {
        self.movie = movie
        let request = Detail.LoadInitialData.Request(movie: self.movie)
        self.interactor?.loadInitialData(request: request)
        
        let movieId = self.movie.id
        DispatchQueue.global().async {
            let request = Detail.LoadVideosInfo.Request(movieId: movieId)
            self.interactor?.loadVideosInfo(request: request)
        }
    }
}
protocol DetailDisplayLogic: AnyObject {
    func displayInitialData(viewModel: Detail.LoadInitialData.ViewModel)
    func displayVideosInfo(viewModel: Detail.LoadVideosInfo.ViewModel)
}

extension DetailViewModel: DetailDisplayLogic {
    func displayInitialData(viewModel: Detail.LoadInitialData.ViewModel) {
        self.overviewTitle = viewModel.overviewTile
        self.yearMovie = viewModel.yearMovie
        self.popularityMovie = viewModel.popularityMovie
        self.languageMovie = viewModel.languageMovie
        self.otherVideosTitle = viewModel.otherVideosTitle
    }

    func displayVideosInfo(viewModel: Detail.LoadVideosInfo.ViewModel) {
        self.trailer = viewModel.trailer
        self.videos = viewModel.videosInfo
    }
}
