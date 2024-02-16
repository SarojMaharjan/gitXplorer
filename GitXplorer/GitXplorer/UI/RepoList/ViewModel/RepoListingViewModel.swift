//
//  RepoListingViewModel.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import Foundation

class RepoListingViewModel: BaseViewModel {
    let dataPerPage = 10
    var currentPage: Int = 0
    var repositories: [GitRepository] = []
    
    func fetchGitRepositories(queryString: String) {
        self.apiRequest(route: GitSearchRouter.repository(query: queryString, dataPerPage: dataPerPage, page: currentPage)) { [weak self] (response: GitRepoSearchResponse?, error) in
            guard error == nil, let data = response else {
                return
            }
            self?.repositories.append(contentsOf: data.items)
        }
    }
}
