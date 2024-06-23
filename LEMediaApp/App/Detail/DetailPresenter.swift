//
//  DetailPresenter.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//  
//
import Foundation

protocol DetailPresentationLogic {
    func presentInitialData(response: Detail.LoadInitialData.Response)
    func presentVideosInfo(response: Detail.LoadVideosInfo.Response)
}

class DetailPresenter: DetailPresentationLogic {
    weak var view: DetailDisplayLogic?

    func presentInitialData(response: Detail.LoadInitialData.Response) {
        let myMovie = response.movie
        let viewModel = Detail.LoadInitialData.ViewModel(
            overviewTile: "Overview",
            yearMovie: getYear(from: myMovie.release_date),
            popularityMovie: getPopularity(from: myMovie.popularity),
            languageMovie: myMovie.original_language.uppercased(),
            otherVideosTitle: "Other Videos")
        view?.displayInitialData(viewModel: viewModel)
    }

    func presentVideosInfo(response: Detail.LoadVideosInfo.Response) {
        let baseVideoUrl = response.baseVideoUrl
        let allVideos = response.videosInfo.filter { $0.site.caseInsensitiveCompare("youtube") == .orderedSame }
        var trailer = allVideos.first { $0.type.caseInsensitiveCompare("trailer") == .orderedSame } ?? VideoInfoCodable(key: "", site: "", type: "")
        trailer.videoUrl = "\(baseVideoUrl)\(trailer.key)".toURL()
        var otherVideos = allVideos.filter { $0.key != trailer.key }

        otherVideos.indices.forEach {
            let path = "\(baseVideoUrl)\(otherVideos[$0].key)".toURL()
            otherVideos[$0].videoUrl = path
        }

        let viewModel = Detail.LoadVideosInfo.ViewModel(
            videosInfo: Array(otherVideos.prefix(4)),
            trailer: trailer)
        view?.displayVideosInfo(viewModel: viewModel)
    }
}
extension DetailPresenter {
    private func getYear(from: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: from) else {
            return ""
        }

        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return String(year)
    }

    private func getPopularity(from: Double) -> String {
        let percent = from / 100
        let popularity = String(format: "%.f", percent)
        return "\(popularity)% popularity"
    }
}
