//
//  ResponseInterceptor.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 21/06/24.
//

import Foundation

protocol ResponseInterceptor {
    func intercept(data: Data, response: HTTPURLResponse) throws -> Data
}

struct ResponseInterceptorImpl: ResponseInterceptor {
    func intercept(data: Data, response: HTTPURLResponse) throws -> Data {
        if response.statusCode >= 200 && response.statusCode < 300 {
            let result = try processBodyResponse(data: data)
            printResponse(data: result, response: response)
            return result
        } else {
            printResponse(data: data, response: response)
            throw try processErrorCode(data: data)
        }
    }

    private func processBodyResponse(data: Data) throws -> Data {
        var resultData = data
        if try JSONSerialization.jsonObject(with: data, options: []) is [String: Any] {
            resultData = data
        }
        return resultData
    }

    private func processErrorCode(data: Data) throws -> NSError {
        let error = NSError(domain: "8000", code: 8000, userInfo: ["message": "Ha ocurrido un error"])
        let result = try processBodyResponse(data: data)
        do {
            if try JSONSerialization.jsonObject(with: result, options: []) is [String: Any] {

//OJO
            }
        } catch {
            print("Error parsing error JSON: \(error)")
        }
        return error
    }

    private func printResponse(data: Data, response: URLResponse) {
        PrintCustom.printDebug(toPrint: "----------RESPONSE----------")
        PrintCustom.printDebug(toPrint: "URL: \(response)")
        PrintCustom.printDebug(toPrint: "Body: \(String(data: data, encoding: .utf8)!)")
        PrintCustom.printDebug(toPrint: "----------END RESPONSE----------")
    }
}
