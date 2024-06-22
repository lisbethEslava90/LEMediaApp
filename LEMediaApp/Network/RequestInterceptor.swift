//
//  RequestInterceptor.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

protocol RequestInterceptor {
    func intercept(request: URLRequest) -> URLRequest
}

struct RequestInterceptorImpl: RequestInterceptor {
    func intercept(request: URLRequest) -> URLRequest {
        print(request: request)
        return request
    }

    private func print(request: URLRequest) {
        PrintCustom.printDebug(toPrint: "----------REQUEST----------")
        PrintCustom.printDebug(toPrint: "URL: \(request)")
        PrintCustom.printDebug(toPrint: "Headers: \(String(describing: request.allHTTPHeaderFields))")
        let stringPrintData = String(
            NSString(
                data: request.httpBody ?? Data(),
                encoding: String.Encoding.utf8.rawValue
            ) ?? ""
        )
        PrintCustom.printDebug(toPrint: "Body: \(stringPrintData)")
        PrintCustom.printDebug(toPrint: "----------END REQUEST----------")
    }
}

struct PrintCustom {
    static func printDebug(toPrint: Any) {
        print(toPrint)
    }
}
