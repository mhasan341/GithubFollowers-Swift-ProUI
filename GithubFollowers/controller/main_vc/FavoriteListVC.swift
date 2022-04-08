//
//  FavouriteVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-25.
//

import UIKit

class FavoriteListVC: UIViewController {

    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorites(){
        
        PersistenceManager.retriveFavorites { [weak self] result in
            
            guard let self = self else{return}
            
            
            switch result{
                
            case .success(let favorites):
                
                if favorites.isEmpty{
                    self.showEmptyStateView(with: "No favorites found", in: self.view)
                }else{
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
                
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(withTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    


}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let vc = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favorite = favorites[indexPath.row]
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { error in
            if let error = error {
                self.presentGFAlertOnMainThread(withTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                return
            }
            
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
