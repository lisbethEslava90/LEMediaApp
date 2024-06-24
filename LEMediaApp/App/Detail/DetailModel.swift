//
//  DetailModel.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//  
//
import Foundation

enum Detail {
    enum LoadInitialData {
        struct Request {
            let movie: MovieCodable
        }
        struct Response {
            let movie: MovieCodable
        }
        struct ViewModel {
            let overviewTile: String
            let yearMovie: String
            let popularityMovie: String
            let languageMovie: String
            let otherVideosTitle: String
        }
    }

    enum LoadVideosInfo {
        struct Request {
            let movieId: Int
        }
        struct Response {
            let baseVideoUrl: String
            let videosInfo: [VideoInfoCodable]
        }
        struct ViewModel {
            let videosInfo: [VideoInfoCodable]
            let trailer: VideoInfoCodable
        }
    }
}
