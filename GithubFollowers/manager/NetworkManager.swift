//
//  NetworkManage.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-29.
//  Manages all network calls for the project

import UIKit



class NetworkManager{
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init(){
        
    }
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>)->Void ){
        let endpoint = baseURL + "users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        
        
        task.resume()
        
    }
    
    // get user profile data
    func getUserData(for username: String, completed: @escaping (Result<User, GFError>)->Void ){
        let endpoint = baseURL + "users/\(username)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        
        
        task.resume()
        
    }
    
    // download an image if not present in cache
    func downloadImage(urlString: String, completed: @escaping (UIImage?)-> Void){
        // check cache
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        // not found? let's move
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                  error == nil,
                  let data = data,
                  let image = UIImage(data: data) else{
                
                completed(nil)
                return
            }
            
            
            self.cache.setObject(image, forKey: cacheKey)
        
            completed(image)
            
        }
        
        task.resume()
        
    }
    
}
