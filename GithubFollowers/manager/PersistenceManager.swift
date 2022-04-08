//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-08.
//  Manages the favorite items via UserDefault

import Foundation

enum PersistenceActionType{
    case add, remove
}

enum PersistenceManager{
    
    static private let defaults = UserDefaults.standard
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping(GFError?)->Void){
        
        retriveFavorites { result in
            switch result{
                
            case .success(var favorites):
                 switch actionType {
                case .add:
                    
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyExist)
                        return
                    }
                    
                     favorites.append(favorite)
                    
                case .remove:
                     favorites.removeAll { $0.login == favorite.login }
                }
                
                 completed(saveFavorites(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retriveFavorites(completed: @escaping(Result<[Follower],GFError>)->Void){
        
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
                
    }
    
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
            
        } catch {
            return .unableToFavorite
        }
        
    }
    
}


