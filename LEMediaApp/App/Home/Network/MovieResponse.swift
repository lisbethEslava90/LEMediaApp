//
//  MovieResponse.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

struct MovieResponse: Decodable {
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let release_date: String
    let video: Bool
}
