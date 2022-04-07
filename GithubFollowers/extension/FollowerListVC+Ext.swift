//
//  UICollectionView+Ext.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-03.
//

import UIKit

extension FollowerListVC: UICollectionViewDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        
        if offsetY > (contentHeight - height){
            
            guard hasMoreFollowers else{return}
            
            page += 1
            print("Getting more for page \(page)")
        
            getFollowers()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController){
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            updateData(with: followers)
            return
        }
        
        isSearching = true
        filteredFollower = followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        
        updateData(with: filteredFollower)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(with: followers)
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
