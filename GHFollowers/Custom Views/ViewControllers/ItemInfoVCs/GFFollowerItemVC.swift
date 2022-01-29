//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 02.01.2022.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func didTapActionButton() {
        delegate.didTapGetFollowers(with: user)
    }
}
