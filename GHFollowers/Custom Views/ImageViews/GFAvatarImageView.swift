//
//  AvatarImageView.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 26.12.2021.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let cache = NetworkManager.shared.cache
    //let placeholderImage = #imageLiteral(resourceName: "githubLogo")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = Images.placeholder
    }
}
