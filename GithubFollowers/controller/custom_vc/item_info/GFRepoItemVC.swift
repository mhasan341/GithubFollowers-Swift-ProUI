//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-07.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemBlue, buttonTitle: "Github Profile")
        
        
    }
    
    override func actionButtonDidTapped() {
        delegate.didTapGithubProfile(for: user)
    }
    
}
