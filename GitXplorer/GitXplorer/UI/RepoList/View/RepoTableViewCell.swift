//
//  RepoTableViewCell.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 16/02/2024.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var watcherCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    var repository: GitRepository? {
        didSet {
            guard repository != nil else { return }
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        if let repo = self.repository {
            self.nameLabel.text = repo.name
            self.repoDescriptionLabel.text = repo.description
            self.starCountLabel.text = repo.starGazersCountDisplayString
            self.watcherCountLabel.text = repo.watchersCountDisplayString
            self.forkCountLabel.text = repo.forkCountDisplayString
            self.authorNameLabel.text = "Author: \(repo.owner.login)"
            self.lastUpdateLabel.text = repo.lastUpdateDisplayString
        }
    }
    
}
