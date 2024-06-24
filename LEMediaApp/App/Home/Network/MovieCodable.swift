//
//  MovieCodable.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation
import RealmSwift

class MovieCodable: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var original_language: String = ""
    @Persisted var title: String = ""
    @Persisted var overview: String = ""
    @Persisted var popularity: Double = 0.0
    @Persisted var release_date: String = ""
    @Persisted var poster_path: String = ""
    @Persisted var posterUrl: String? = ""

    override init() {
        id = 0
        original_language = ""
        title = ""
        overview = ""
        popularity = 0.0
        release_date = ""
        poster_path = ""
    }

    static func == (lhs: MovieCodable, rhs: MovieCodable) -> Bool {
        lhs === rhs
    }
}

class Category: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name = ""
    @Persisted var movies = List<MovieCodable>()
}
