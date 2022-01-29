//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 14.11.2021.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true , animated: true)
        usernameTextField.text = ""
    }
    
    func createDismissTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC(){
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to look for", buttonTitle: "OK")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "githubLogo")?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = .label
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.centerX.equalTo(view.snp.centerX)
            make.height.width.equalTo(200)
        }
    }
    
    func configureTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(48)
            make.height.equalTo(50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
        }
    }
    
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        callToActionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(50)
        }
    }
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
