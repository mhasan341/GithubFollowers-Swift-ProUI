//
//  User.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-03-28.
//

import Foundation

struct User: Codable{
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var followers: Int
    var following: Int
    var createdAt: Date
}
