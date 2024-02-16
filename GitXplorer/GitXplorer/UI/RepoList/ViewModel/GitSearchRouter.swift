//
//  GitSearchRouter.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import Foundation

enum GitSearchRouter: Router {
    static let baseURL = "\(Constants.API.baseURL)search/"
    
    case repository(query: String, dataPerPage: Int, page: Int, sort: SearchSortOption?, order: SearchSortOrder?)
    
    var url: URL {
        switch self {
        case let .repository(query, dataPerPage, page, sorting, order):
            var searchURL = "\(GitSearchRouter.baseURL)repositories?q=\(query)&per_page=\(dataPerPage)&page=\(page)"
            if let sortingOption = sorting {
                searchURL += "&sort=\(sortingOption.rawValue)"
            }
            if let orderOption = order {
                searchURL += "&order=\(orderOption.rawValue)"
            }
            return URL(string: searchURL)!
        }
    }
    
    var method: Method {
        switch self {
        case .repository:
            return .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .repository:
            return [:]
        }
    }
    
    var headers: [String : String] {
        switch self {
        default:
            var headers = [
                "Accept": "application/vnd.github+json",
                "X-GitHub-Api-Version": Constants.API.apiVersion,
            ]
            return headers
        }
    }
    
    
}
