//
//  HTTPUrl.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

extension String {
    func toURL() -> URL {
        guard let url = URL(string: self) else {
            fatalError("\(self) is not a valid URL, verified")
        }
        return url
    }
}
