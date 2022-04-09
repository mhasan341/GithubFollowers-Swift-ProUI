//
//  GFEmptyStateView.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-04.
//  We'll show it when there is no follower/favorite follower

import UIKit


class GFEmptyStateView: UIView {

    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String){
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 2
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = Images.emptyState
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        configureCustomConstraints()
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 100),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }

    
    // this func ensures that the view looks great on small screen like SE
    private func configureCustomConstraints(){
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80: -150
        
        
        let messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        
        
        messageLabelCenterYConstraint.isActive = true
    }
}
