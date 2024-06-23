//
//  DetailApi.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//

import Foundation

protocol DetailApi {
    func fetchVideosInfo(id: String) -> URLRequest
    func getVideoUrl() -> String
}

struct DetailApiImpl: DetailApi {
    public func fetchVideosInfo(id: String) -> URLRequest {
        let path = DetailApiImpl.videosInfo.replacingOccurrences(of: "$movie_id$", with: id)
        let url = path.toURL()
        let request = URLRequest(url: url)
            .add(httpMethod: .get)
            .add(headers: defaultHeaders())
        return request
    }

    func getVideoUrl() -> String {
        return DetailApiImpl.videoPreview
    }
}

extension DetailApiImpl {
    public static let videosInfo: String = "https://api.themoviedb.org/3/movie/$movie_id$/videos?language=en-US"
    public static let videoPreview: String = "https://www.youtube.com/embed/"
}
