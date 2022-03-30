//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-27.
//

import UIKit

class FollowerListVC: UIViewController {

    var usernmae: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        
        NetworkManager.shared.getFollowers(for: usernmae, page: 1) { result in
            
            switch result{
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(withTitle: "Hold on!", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
