//
//  MovieResponse.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

struct MovieResponse: Decodable, Hashable {
    let id: Int
    let original_language: String
    let original_title: String
    let title: String
    let overview: String
    let popularity: Double
    let release_date: String
    let poster_path: String
    var posterUrl: URL?

    init() {
        id = 0
        original_language = ""
        original_title = ""
        title = ""
        overview = ""
        popularity = 0.0
        release_date = ""
        poster_path = ""
    }
}
