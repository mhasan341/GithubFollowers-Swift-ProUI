//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-02.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "followerCell"
    
    let avatarImageVIew = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        usernameLabel.text = follower.login
        avatarImageVIew.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure(){
        addSubview(avatarImageVIew)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageVIew.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageVIew.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageVIew.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageVIew.heightAnchor.constraint(equalTo: avatarImageVIew.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageVIew.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
