//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 02.01.2022.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func didTapActionButton() {
        delegate.didTapGithubProfile(with: user)
    }
}
