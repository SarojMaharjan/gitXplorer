//
//  SearchSortOption.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 16/02/2024.
//

import Foundation

enum SearchSortOption: String, CaseIterable {
    case stars, forks, helpWanted = "help-wanted-issues", updated
}
enum SearchSortOrder: String, CaseIterable {
    case desc, asc
}
