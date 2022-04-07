//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-06.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: AnyObject{
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton

        // Do any additional setup after loading the view.
        layoutUI()
        getUserData()
        
        
    }
    
    func getUserData(){
        NetworkManager.shared.getUserData(for: username) {[weak self] result in
            
            guard let self = self else {return}
            
            switch result{
                
            case .success(let user):
        
                self.configureVCs(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(withTitle: "Something went wrong", message: error.localizedDescription, buttonTitle: "Dismiss")
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    private func configureVCs(user: User){
        DispatchQueue.main.async {
            
            let repoVC = GFRepoItemVC(user: user)
            
            repoVC.delegate = self
            self.add(childVC: repoVC, to: self.itemViewOne)
           
            
            let followerVC = GFFollowerItemVC(user: user)
            followerVC.delegate = self
            
            self.add(childVC: followerVC, to: self.itemViewTwo)
            self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
            
            self.dateLabel.text = "Github since \(user.createdAt.convertToGFDisplayFormat())"
        }
    }
    


    func layoutUI(){
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let padding: CGFloat = 20
        let itemViewHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
}

extension UserInfoVC: UserInfoVCDelegate{
    
    func didTapGithubProfile(for user: User) {
        print("Profile tapped")
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(withTitle: "Invalid URL", message: "Github profile not found for this user", buttonTitle: "Ok")
            return
        }
        
        openSafariVC(with: url)
        
        
    }
    
    func didTapGetFollowers(for user: User) {
        print("Get follower tapped")
        guard user.followers != 0 else{
            presentGFAlertOnMainThread(withTitle: "No Followers", message: "This user has no followers", buttonTitle: "Got it!")
            
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}
