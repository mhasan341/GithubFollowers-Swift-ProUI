//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-08.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewControllers = [createSearchNavigationController(),createFavoriteListNavigationController()]
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .systemBackground
    }
    
    func createSearchNavigationController () -> UINavigationController{
        
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
        
    }
    
    func createFavoriteListNavigationController () -> UINavigationController{
        
        let favVC = FavoriteListVC()
        favVC.title = "Favorites"
        favVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favVC)
        
    }
 
}
