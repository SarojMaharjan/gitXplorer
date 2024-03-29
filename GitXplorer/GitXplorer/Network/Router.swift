//
//  Router.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import Foundation

protocol Router {
    var url: URL { get }
    var method: Method { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var uploadParameters: Data? { get }
}
extension Router {
    var method: Method { return Method.get }
    var headers: [String: String] { return [:] }
    var parameters: [String: Any] { return [:] }
    var uploadParameters: Data? { return nil }
}
enum Method: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}
