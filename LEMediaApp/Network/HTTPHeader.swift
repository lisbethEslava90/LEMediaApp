//
//  HTTPHeader.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

enum HTTPHeader: String {
    case authorization = "Authorization"
    case accept = "accept"
}

public func defaultHeaders() -> [String: String] {
    return [
        HTTPHeader.accept.rawValue: "application/json",
        HTTPHeader.authorization.rawValue: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDlhM2U3ZWNkMjAyYWU5ZmIyZDI3MDRhYjM1NmQ2NCIsIm5iZiI6MTcxOTAxNDg5MS4yODQyOSwic3ViIjoiNWMzN2YyZDIwZTBhMjY2MWNlYzhmOTFiIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.nXIK_ppFiTu-9RoPhF64f0YnO95OpWTz5AwRhLgRdSw"
    ]
}
