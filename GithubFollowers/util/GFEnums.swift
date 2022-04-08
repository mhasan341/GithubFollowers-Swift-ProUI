//
//  GFEnums.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-30.
//

import Foundation

enum GFError : String, Error{
    case invalidUsername = "The username is invalid"
    case unableToComplete = "Unable to complete your request"
    case invalidResponse = "Server returned invalid response"
    case invalidData = "The data seems to be invalid"
    case unableToFavorite = "Can't add this user to favorite"
    case alreadyExist = "Already exists in favorite!"
}

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}

enum ItemInfoType{
    case repos, gists, following, followers
}

enum Keys{
    static let favorites = "Favorites"
}
