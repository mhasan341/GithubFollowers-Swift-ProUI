//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-07.
//

import Foundation

extension Date{
    func convertToGFDateFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM YYYY"
        
        return dateFormatter.string(from: self)
    }
}
