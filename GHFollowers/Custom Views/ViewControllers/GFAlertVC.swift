//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 15.11.2021.
//

import UIKit
import SnapKit

class GFAlertVC: UIViewController {
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 280, height: 220))
        }
    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(padding)
            make.left.equalTo(containerView.snp.left).offset(padding)
            make.right.equalTo(containerView.snp.right).offset(-padding)
            make.height.equalTo(28)
        }
    }
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        actionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView.snp.bottom).offset(-padding)
            make.left.equalTo(containerView.snp.left).offset(padding)
            make.right.equalTo(containerView.snp.right).offset(-padding)
            make.height.equalTo(44)
        }
    }
    
    func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(containerView.snp.left).offset(padding)
            make.right.equalTo(containerView.snp.right).offset(-padding)
            make.bottom.equalTo(actionButton.snp.top).offset(-12)
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
