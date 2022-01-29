//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 26.12.2021.
//

import UIKit
import SnapKit

class FollowerCell: UICollectionViewCell {
    
    static let cellId = "cellId"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    private func configure() {
        self.addSubviews([avatarImageView, usernameLabel])
        let padding: CGFloat = 8
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(padding)
            make.left.equalTo(contentView.snp.left).offset(padding)
            make.right.equalTo(contentView.snp.right).offset(-padding)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.left.equalTo(contentView.snp.left).offset(padding)
            make.right.equalTo(contentView.snp.right).offset(-padding)
            make.height.equalTo(20)
        }
    }
}
