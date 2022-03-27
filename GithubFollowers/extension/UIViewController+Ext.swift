//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-27.
//

import UIKit

extension UIViewController{
    
    func presentGFAlertOnMainThread(withTitle: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let vc = GFAlertVC(title: withTitle, message: message, buttonTitle: buttonTitle)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
}
