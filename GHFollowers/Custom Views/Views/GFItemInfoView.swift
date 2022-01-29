//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 01.01.2022.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubviews([symbolImageView, titleLabel, countLabel])
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        symbolImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(symbolImageView.snp.centerY)
            make.left.equalTo(symbolImageView.snp.right).offset(12)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(18)
        }
        countLabel.snp.makeConstraints { (make) in
            make.top.equalTo(symbolImageView.snp.bottom).offset(4)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(18)
        }
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}
