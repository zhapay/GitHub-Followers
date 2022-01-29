//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 31.12.2021.
//

import UIKit
import SnapKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    func configure() {
        //let multiplierWidth: CGFloat = (frame.width) * 1.3
        //let multiplierHeight: CGFloat = (frame.height) * 1.3
        addSubviews([messageLabel, logoImageView])
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = #imageLiteral(resourceName: "githubLogo").withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = UIColor.secondaryLabel
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(-150)
            make.left.equalTo(self.snp.left).offset(40)
            make.right.equalTo(self.snp.right).offset(-40)
            make.height.equalTo(200)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            //make.width.equalTo(self.snp.width).offset(multiplierWidth)
            //make.height.equalTo(self.snp.height).offset(multiplierHeight)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(170)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(40)
        }
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3)
        ])
    }
    
}
