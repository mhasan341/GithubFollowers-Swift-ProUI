//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-27.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController{
    // present an alert to the calling VC
    func presentGFAlertOnMainThread(withTitle: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let vc = GFAlertVC(title: withTitle, message: message, buttonTitle: buttonTitle)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
    
    // shows a loading on the calling vc with alpha background
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView(){
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    // called when no follower is found on followerListVC/FavoriteListVC
    func showEmptyStateView(with message: String, in view: UIView){

            let emptyStateView = GFEmptyStateView(message: message)
            emptyStateView.frame = view.bounds
            
            view.addSubview(emptyStateView)
        
    }
    
    // opens safari the url provides inside the app
    func openSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
