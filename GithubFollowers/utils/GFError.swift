//
//  Error.swift
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
}
