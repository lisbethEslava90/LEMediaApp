//
//  VideoInfoCodable.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//

import Foundation

struct VideoInfoCodable: Decodable, Hashable {
    let key: String
    let site: String
    let type: String
    var videoUrl: URL?
}
