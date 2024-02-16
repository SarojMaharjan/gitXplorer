//
//  RepoListingViewModel.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import Foundation

protocol RepoListingDelegate {
    func onOrderChanged()
}
class RepoListingViewModel: BaseViewModel {
    let dataPerPage = 10
    var repositories: [GitRepository] = []
    
    var delegate: RepoListingDelegate? = nil
    var sort: SearchSortOption? = nil
    
    var queryString: String = "" {
        didSet {
            
        }
    }
    var currentPage: Int = 0 {
        didSet {
            
        }
    }
    var order: SearchSortOrder = .asc {
        didSet {
            self.delegate?.onOrderChanged()
        }
    }
    
    private func fetchGitRepositories(queryString: String) {
        self.apiRequest(
            route: GitSearchRouter.repository(query: queryString, dataPerPage: dataPerPage, page: currentPage, sort: sort, order: order)) { [weak self] (response: GitRepoSearchResponse?, error) in
            guard error == nil, let data = response else {
                return
            }
            self?.repositories.append(contentsOf: data.items)
        }
    }
    
    func fetchNextPage() {
        currentPage += 1
    }
    
    func switchOrder() {
        self.order = self.order == .asc ? .desc : .asc
    }
}
