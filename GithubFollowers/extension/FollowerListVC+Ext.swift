//
//  UICollectionView+Ext.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-03.
//

import UIKit

extension FollowerListVC: UICollectionViewDelegate, UISearchResultsUpdating {
    
    // detects if user reached to the bottom
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // how far I scrolled?
        let offsetY = scrollView.contentOffset.y
        // the entire size of the scrollView
        let contentHeight = scrollView.contentSize.height
        // height of screen
        let height = scrollView.frame.size.height
        
        
        
        if offsetY > (contentHeight - height){
            
            guard hasMoreFollowers, !isLoadingFollowers else{return}
            
                page += 1
                getFollowers()
            
            
        }
    }
    
    // updates the collection view
    func updateSearchResults(for searchController: UISearchController){
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            filteredFollower.removeAll()
            updateData(with: followers)
            return
        }
        
        isSearching = true
        filteredFollower = followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        
        updateData(with: filteredFollower)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let follower = isSearching ? filteredFollower[indexPath.item] : followers[indexPath.item]
        
        let vc = UserInfoVC()
        vc.username = follower.login
        vc.delegate = self
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true)
        
    }
    
}
