//
//  GFUserInfoVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 01.01.2022.
//

import UIKit
import  SnapKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews([avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel])
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        downloadImage()
        usernameLabel.text = user.login
        nameLabel.text = user.name
        locationLabel.text = user.location
        bioLabel.text = user.bio
        bioLabel.numberOfLines = 2
        bioLabel.lineBreakMode = .byTruncatingTail
        
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    func downloadImage() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(padding)
            make.left.equalTo(view.snp.left)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.top)
            make.left.equalTo(avatarImageView.snp.right).offset(textImagePadding)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(38)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarImageView.snp.centerY).offset(8)
            make.left.equalTo(avatarImageView.snp.right).offset(textImagePadding)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(20)
        }
        locationImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatarImageView.snp.bottom)
            make.left.equalTo(avatarImageView.snp.right).offset(textImagePadding)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        locationLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(locationImageView.snp.centerY)
            make.left.equalTo(locationImageView.snp.right).offset(5)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(20)
        }
        bioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(textImagePadding)
            make.left.equalTo(avatarImageView.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(90)
        }
    }
}
