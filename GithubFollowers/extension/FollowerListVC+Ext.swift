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
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        
        filteredFollower = followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        
        updateData(with: filteredFollower)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(with: followers)
    }
    
    
}
