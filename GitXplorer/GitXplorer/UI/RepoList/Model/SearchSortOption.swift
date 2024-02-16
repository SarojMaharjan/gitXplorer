//
//  SearchSortOption.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 16/02/2024.
//

import Foundation

enum SearchSortOption: String, CaseIterable {
    case stars, forks, helpWanted = "help-wanted-issues", updated
    
    var displayName: String {
        switch self {
        case .stars:
            "No of stars"
        case .forks:
            "No of Forks"
        case .helpWanted:
            "Help Wanted"
        case .updated:
            "Update date."
        }
    }
}
enum SearchSortOrder: String, CaseIterable {
    case desc, asc
    
    var imageName: String {
        switch self {
        case .desc:
            return "order_descending"
        case .asc:
            return "order_ascending"
        }
    }
}
