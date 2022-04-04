//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-27.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }

    var usernmae: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var followers: [Follower] = []
    var filteredFollower: [Follower] = []
    
    var page = 1
    
    var hasMoreFollowers = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        getFollowers()
        configureDataSource()
        configureSearchController()
        
        // Do any additional setup after loading the view.
        
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    
    
    func getFollowers(){
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: usernmae, page: page) {[weak self] result in
            
            guard let self = self else {return}
            
            self.hideLoadingView()
            
            switch result{
            case .success(let followers):
                
                if followers.isEmpty{
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "No follower found for this user 😥", in: self.view)
                    return
                    }
                }
                
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                self.updateData(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(withTitle: "Hold on!", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
    }
    
    
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        collectionView.delegate = self
        
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            cell.set(follower: follower)

            return cell
            
        })
    }
    
    func updateData(with filteredFollowers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        
        snapshot.appendItems(filteredFollowers)
        
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        
        
    }
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search a username"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}
