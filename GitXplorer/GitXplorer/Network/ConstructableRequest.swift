//
//  ConstructableRequest.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import Foundation

protocol ConstructableRequest: Router {
    func buildRequest() -> URLRequest?
}
extension ConstructableRequest {
    func buildRequest() -> URLRequest? {
        var request = URLRequest(url: url)
        if method != Method.get {
            // For Upload
            if let uploadParam = uploadParameters {
                request.httpBody = uploadParam
            } else {
                // For Normal
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            }
        }

        // MARK: Configure for other Methods (DELETE, PUT etc....)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        return request
    }
}
