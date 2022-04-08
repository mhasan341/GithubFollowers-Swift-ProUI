//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-25.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTF = GFTextField()
    let searchButton = GFButton(title: "See Followers", withBackgroundColor: .systemGreen)
    var logoImageViewTopContraints: NSLayoutConstraint!
    
    var isUsernameEntered: Bool {
        !usernameTF.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        usernameTF.delegate = self

        // Do any additional setup after loading the view.
        configureLogoImageView()
        configureTextField()
        configureSearchButton()
        
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTF.text?.removeAll()
    }
    
    func createDismissKeyboardTapGesture(){
        let tg = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tg)
    }
    
    func configureLogoImageView(){
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topContraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20: 80
        logoImageViewTopContraints = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topContraintConstant)
            logoImageViewTopContraints.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(usernameTF)
        
        NSLayoutConstraint.activate([
            usernameTF.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            usernameTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            usernameTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureSearchButton(){
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowerVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func pushFollowerVC(){
        
        guard isUsernameEntered else{
            presentGFAlertOnMainThread(withTitle: "Empty Username", message: "This field can't be empty", buttonTitle: "Got it!")
            return
        }
        
        let vc = FollowerListVC(username: usernameTF.text!)
        
        usernameTF.resignFirstResponder()
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTF.resignFirstResponder()
        pushFollowerVC()
        return true
    }
}
