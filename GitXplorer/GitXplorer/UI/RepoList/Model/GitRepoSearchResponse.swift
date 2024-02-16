//
//  GitRepoSearchResponse.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import Foundation

struct GitRepoSearchResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GitRepository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
