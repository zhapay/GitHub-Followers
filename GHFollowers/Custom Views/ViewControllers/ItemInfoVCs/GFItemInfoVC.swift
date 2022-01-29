//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 01.01.2022.
//

import UIKit
import SnapKit

protocol ItemInfoVCDelegate: class {
    func didTapGithubProfile(with user: User)
    func didTapGetFollowers(with user: User)
}

class GFItemInfoVC: UIViewController {
    
    var user: User!
    weak var delegate: ItemInfoVCDelegate!
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    @objc func didTapActionButton() {}
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubviews([stackView, actionButton])
        
        let padding: CGFloat = 20
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(padding)
            make.left.equalTo(view.snp.left).offset(padding)
            make.right.equalTo(view.snp.right).offset(-padding)
            make.height.equalTo(50)
        }
        actionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-padding)
            make.left.equalTo(view.snp.left).offset(padding)
            make.right.equalTo(view.snp.right).offset(-padding)
            make.height.equalTo(44)
        }
    }
}
