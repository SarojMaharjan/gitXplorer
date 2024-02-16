//
//  ViewController.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//

import UIKit

class RepoListingViewController: UIViewController {
    
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
        repoSearchBar.delegate = self
        self.onOrderChanged()
    }
    
    private func setupTableView() {
        self.gitRepoListingTableView.dataSource = self
        self.gitRepoListingTableView.delegate = self
        self.gitRepoListingTableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
    }
    
    @IBAction func onOrderButtonClicked(_ sender: Any) {
        self.viewModel.switchOrder()
    }
    
    @IBAction func onSortButtonClicked(_ sender: Any) {
        print("sortbutton clicked")
    }
}
extension RepoListingViewController: APICallStatusDelegate {
    func onAPICallStateChanged(isLoading: Bool) {
        
    }
}
extension RepoListingViewController: RepoListingDelegate {
    func onOrderChanged() {
        self.orderButton.image = UIImage(named: self.viewModel.order.imageName)
    }
    
    func onDataUpdated() {
        self.gitRepoListingTableView.reloadData()
    }
}
extension RepoListingViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.viewModel.cancelSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.queryString = searchText
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
