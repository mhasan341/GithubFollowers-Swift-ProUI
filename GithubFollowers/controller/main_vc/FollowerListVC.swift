//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-27.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject{
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }

    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var followers: [Follower] = []
    var filteredFollower: [Follower] = []
    
    var page = 1
    
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingFollowers = false
    
    init(username: String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = plusButton
        
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

    @objc func addButtonTapped(){
        
        showLoadingView()
        NetworkManager.shared.getUserData(for: username) { [weak self] result in
            
            
            guard let self = self else {return}
            
            self.hideLoadingView()
            
            switch result{
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
                    
                    guard let self = self else {return}
                    
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(withTitle: "Success!", message: "Successfully added to favorites", buttonTitle: "Awesome!")
                        return
                    }

                    self.presentGFAlertOnMainThread(withTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(withTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func getFollowers(){
        
        showLoadingView()
        isLoadingFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] result in
            
            guard let self = self else {return}
            
            self.hideLoadingView()
            self.isLoadingFollowers = false
            
            switch result{
            case .success(let newFollowers):
                
                if newFollowers.isEmpty{
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "No follower found for this user 😥", in: self.view)
                    return
                    }
                }
                
                if newFollowers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: newFollowers)
                self.updateData(with: self.followers)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showEmptyStateView(with: "", in: self.view)
                return
                }
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
    
    func updateData(with followerList: [Follower]){
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        
        snapshot.appendItems(followerList)
        
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        
        
    }
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search a username"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

extension FollowerListVC: FollowerListVCDelegate{
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollower.removeAll()
        collectionView.scrollsToTop = true
        getFollowers()
    }
    
    
}
