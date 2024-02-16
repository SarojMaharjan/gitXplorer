//
//  RepoDetailViewController.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 16/02/2024.
//

import UIKit
import WebKit

class RepoDetailViewController: UIViewController {

    @IBOutlet weak var defaultBranchLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var ownerNameButton: UIButton!
    @IBOutlet weak var repositoryNameButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    var repository: GitRepository? = nil {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let repository = self.repository else { return }
        repositoryNameButton?.setTitle(repository.fullName, for: .normal)
        ownerNameButton?.setTitle(repository.ownerNameDisplayString, for: .normal)
        openIssuesLabel?.text = repository.openIssuesDisplayString
        defaultBranchLabel?.text = repository.defaultBranchDisplayString

        loadWebViewForReadMe()
    }
    
    private func loadWebViewForReadMe() {
        if let owner = self.repository?.owner.login, let repo = self.repository?.name, let branch = self.repository?.defaultBranch {
            let url = "https://github.com/\(owner)/\(repo)/blob/\(branch)/README.md"
            if let readMeURL = URL(string: url) {
                webView?.load(URLRequest(url: readMeURL))
            }
        }
    }

    @IBAction func onRepositoryNameClicked(_ sender: Any) {
        if let repositoryURL = self.repository?.htmlURL, let url = URL(string: repositoryURL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func onOwnerNameClicked(_ sender: Any) {
        if let ownerURL = self.repository?.owner.htmlURL, let url = URL(string: ownerURL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
