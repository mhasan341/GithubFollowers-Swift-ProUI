//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-25.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, withBackgroundColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = withBackgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    func set(backgroundColor: UIColor, buttonTitle: String){
        self.backgroundColor = backgroundColor
        setTitle(buttonTitle, for: .normal)
    }
}
