//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-07.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemCyan, buttonTitle: "Github Followers")
    }
    
    
    override func actionButtonDidTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
