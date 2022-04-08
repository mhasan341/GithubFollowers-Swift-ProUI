//
//  FavoriteCell.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-08.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "favoriteCell"
    
    let avatarImageVIew = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower){
        usernameLabel.text = favorite.login
        // download and return the image of avatar to be set
        NetworkManager.shared.downloadImage(urlString: favorite.avatarUrl) { [weak self] image in
            guard let self = self else{return}
            
            DispatchQueue.main.async {
                self.avatarImageVIew.image = image
            }
        }
    }

    private func configure(){
        addSubview(avatarImageVIew)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageVIew.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageVIew.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageVIew.heightAnchor.constraint(equalToConstant: 60),
            avatarImageVIew.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageVIew.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
