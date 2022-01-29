//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 01.01.2022.
//

import UIKit
import SnapKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!

    let headerView = UIView()
    let itemOneView = UIView()
    let itemTwoView = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        configureGetInfo()

    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(configureDoneButton))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI() {
        view.addSubviews([headerView, itemOneView, itemTwoView, dateLabel])
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left).offset(padding)
            make.right.equalTo(view.snp.right).offset(-padding)
            make.height.equalTo(180)
        }
        itemOneView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(padding)
            make.left.equalTo(headerView.snp.left)
            make.right.equalTo(headerView.snp.right)
            make.height.equalTo(itemHeight)
        }
        itemTwoView.snp.makeConstraints { (make) in
            make.top.equalTo(itemOneView.snp.bottom).offset(padding)
            make.left.equalTo(headerView.snp.left)
            make.right.equalTo(headerView.snp.right)
            make.height.equalTo(itemHeight)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(itemTwoView.snp.left)
            make.right.equalTo(itemTwoView.snp.right)
            make.top.equalTo(itemTwoView.snp.bottom).offset(padding)
            make.height.equalTo(18)
        }
    }
    
    func configureGetInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        let repos = GFRepoItemVC(user: user)
        repos.delegate = self
        
        let followers = GFFollowerItemVC(user: user)
        followers.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repos, to: self.itemOneView)
        self.add(childVC: followers, to: self.itemTwoView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func configureDoneButton() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: ItemInfoVCDelegate {
    
    func didTapGithubProfile(with user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this useris invalid", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(with user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame 🥲", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollowers(for:  user.login)
        dismiss(animated: true) 
    }
}
