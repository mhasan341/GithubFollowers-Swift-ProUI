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
        
        navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    


}
