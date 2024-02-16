//
//  ViewController.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import UIKit

class RepoListingViewController: UIViewController {
    
    @IBOutlet weak var gitRepoListingTableView: UITableView!
    @IBOutlet weak var repoSearchBar: UISearchBar!

    lazy var viewModel: RepoListingViewModel = RepoListingViewModel(apiCallStateDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }

    private func setupTableView() {
        self.gitRepoListingTableView.dataSource = self
        self.gitRepoListingTableView.delegate = self
    }
}
extension RepoListingViewController: APICallStatusDelegate {
    func onAPICallStateChanged(isLoading: Bool) {
        
    }
}
extension RepoListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
