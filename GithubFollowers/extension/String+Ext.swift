//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Mahmudul Hasan on 2022-04-07.
//

import Foundation

extension String{
    func convertToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        
        return dateFormatter.date(from: self)
    }
    
    func convertToGFDisplayFormat()-> String{
        guard let date = self.convertToDate() else {return "N/A"}
        return date.convertToGFDateFormat()
    }
}
