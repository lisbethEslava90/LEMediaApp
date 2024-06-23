//
//  VideosResponse.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//

import Foundation

struct VideosResponse: Decodable {
    let id: Int
    let results: [VideoInfoCodable]?
}
