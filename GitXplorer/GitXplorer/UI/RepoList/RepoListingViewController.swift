//
//  ViewController.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import UIKit
import NicoProgress

class RepoListingViewController: UIViewController {
    
    @IBOutlet weak var apiProgressIndicator: NicoProgressBar!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var pageCounterView: UIView!
    @IBOutlet weak var emptyViewDescriptionLabel: UILabel!
    @IBOutlet weak var emptyViewTitleLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var orderButton: UIBarButtonItem!
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    @IBOutlet weak var gitRepoListingTableView: UITableView!
    @IBOutlet weak var repoSearchBar: UISearchBar!

    lazy var viewModel: RepoListingViewModel = RepoListingViewModel(apiCallStateDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        setupTableView()
        setupViewModel()
    }

    private func setupViewModel() {
        self.viewModel.delegate = self
        
    }
    
    private func setUpUI() {
        apiProgressIndicator.transition(to: .indeterminate)
        repoSearchBar.delegate = self
        self.onOrderChanged()
    }
    
    private func setupTableView() {
        updateEmptyView()
        self.gitRepoListingTableView.dataSource = self
        self.gitRepoListingTableView.delegate = self
        self.gitRepoListingTableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
    }
    
    private func updateEmptyView() {
        if self.viewModel.repositories.count == 0 && !viewModel.isLoading {
            self.emptyView.isHidden = false
            self.gitRepoListingTableView.isHidden = true
            if self.viewModel.queryString == "" {
                self.emptyViewTitleLabel.text = "Let's start Browsing"
                self.emptyViewDescriptionLabel.text = "Browse for a git repository by typing into the search bar."
            } else {
                self.emptyViewTitleLabel.text = "No Result Found!!"
                self.emptyViewDescriptionLabel.text = "Something went wrong. Please try again later."
            }
        } else {
            self.emptyView.isHidden = true
            self.gitRepoListingTableView.isHidden = false
        }
    }
    
    private func updatePageCounterView() {
        if self.viewModel.repositories.count == 0 && !viewModel.isLoading {
            self.pageCounterView.isHidden = true
        } else {
            self.pageCounterView.isHidden = false
            self.pageCountLabel.text = "\(viewModel.currentDisplayedPage) / \(viewModel.totalPages)"
        }
    }
    
    @IBAction func onOrderButtonClicked(_ sender: Any) {
        self.viewModel.switchOrder()
    }
    
    @IBAction func onSortButtonClicked(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Sort by", message: "Select Sorting Option", preferredStyle: .actionSheet)
        for sortOption in SearchSortOption.allCases {
            let action: UIAlertAction = UIAlertAction(title: sortOption.displayName, style: .default) { action -> Void in
                self.viewModel.sort = sortOption
            }
            actionSheetController.addAction(action)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true)
    }
}
extension RepoListingViewController: APICallStatusDelegate {
    func onAPICallStateChanged(isLoading: Bool) {
        self.apiProgressIndicator.isHidden = !isLoading
    }
}
extension RepoListingViewController: RepoListingDelegate {
    func onOrderChanged() {
        self.orderButton.image = UIImage(named: self.viewModel.order.imageName)
    }
    
    func onDataUpdated() {
        self.gitRepoListingTableView.reloadData()
    }
    
    func shouldUpdateEmptyView() {
        updateEmptyView()
    }
    
    func shouldUpdatePageCounter() {
        updatePageCounterView()
    }
}
extension RepoListingViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.viewModel.cancelSearch()
        self.updateEmptyView()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.queryString = searchText
        if searchText == "" {
            self.updateEmptyView()
        }
    }
}
extension RepoListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        let repository = self.viewModel.repositories[indexPath.row]
        cell.repository = repository
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = self.viewModel.repositories[indexPath.row]
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "RepoDetailViewController") as? RepoDetailViewController {
            detailViewController.repository = repository
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.shouldPrefetch(index: indexPath.row)
    }
    
}
