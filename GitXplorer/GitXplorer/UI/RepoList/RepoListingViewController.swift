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
        self.onOrderChanged()
    }
    
    private func setupTableView() {
        self.gitRepoListingTableView.dataSource = self
        self.gitRepoListingTableView.delegate = self
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
}
extension RepoListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.largeContentTitle = "Text for index: \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
