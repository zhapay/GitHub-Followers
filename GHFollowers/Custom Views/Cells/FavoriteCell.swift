//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 06.01.2022.
//

import UIKit
import SnapKit

class FavoriteCell: UITableViewCell {
    
    static let cellId = "favoriteId"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    private func configure() {
        addSubviews([avatarImageView, usernameLabel])
        
        let padding: CGFloat = 12
        
        avatarImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(padding)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        usernameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(avatarImageView.snp.right).offset(24)
            make.right.equalTo(self.snp.right).offset(-padding)
            make.height.equalTo(40)
        }
    }
}
