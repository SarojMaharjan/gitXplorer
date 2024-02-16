//
//  RepoListingViewModel.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import Foundation

protocol RepoListingDelegate {
    func onOrderChanged()
    func onDataUpdated()
    func shouldUpdateEmptyView()
    func shouldUpdatePageCounter()
}
class RepoListingViewModel: BaseViewModel {
    let dataPerPage = 10
    var repositories: [GitRepository] = [] {
        didSet {
            self.delegate?.onDataUpdated()
        }
    }
    
    var delegate: RepoListingDelegate? = nil
    var sort: SearchSortOption? = nil {
        didSet {
            guard sort != nil else { return }
            initialFetch()
        }
    }
    
    var queryString: String = "" {
        didSet {
            initialFetch()
        }
    }
    var currentPage: Int = 0 {
        didSet {
            self.delegate?.shouldUpdatePageCounter()
        }
    }
    var totalPages: Int = 0 {
        didSet {
            self.delegate?.shouldUpdatePageCounter()
        }
    }
    var order: SearchSortOrder = .asc {
        didSet {
            initialFetch()
            self.delegate?.onOrderChanged()
        }
    }
    var currentDisplayedIndex: Int = 0 {
        didSet {
            self.delegate?.shouldUpdatePageCounter()
        }
    }
    var currentDisplayedPage: Int {
        return Int(ceil(Double(currentDisplayedIndex / 10)))
    }
    
    private func fetchGitRepositories(queryString: String) {
        self.apiRequest(
            route: GitSearchRouter.repository(query: queryString, dataPerPage: dataPerPage, page: currentPage, sort: sort, order: order)) { [weak self] (response: GitRepoSearchResponse?, error) in
                guard error == nil, let data = response else {
                    return
                }
                self?.totalPages = Int(ceil(Double(data.totalCount / 10)))
                self?.repositories.append(contentsOf: data.items)
                self?.delegate?.shouldUpdateEmptyView()
            }
    }
    
    func initialFetch() {
        guard queryString != "" else { return }
        currentPage = 0
        repositories.removeAll()
        fetchGitRepositories(queryString: queryString)
    }
    
    func fetchNextPage() {
        currentPage += 1
        fetchGitRepositories(queryString: self.queryString)
    }
    
    func switchOrder() {
        self.order = self.order == .asc ? .desc : .asc
    }
    
    func cancelSearch() {
        self.repositories.removeAll()
        self.currentPage = 0
        self.queryString = ""
    }
    
    func shouldPrefetch(index: Int) {
        self.currentDisplayedIndex = index
        if !isLoading{
            if  index >= self.repositories.count - 5 {
                fetchNextPage()
            }
        }
    }
}
