//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by Dastan Zhapay on 06.01.2022.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    fileprivate var containerView: UIView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerY.equalTo(containerView.snp.centerY)
            make.centerX.equalTo(containerView.snp.centerX)
        }  
        activityIndicator.startAnimating()
    }
    
    func dissmissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showMessageLabel(message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
