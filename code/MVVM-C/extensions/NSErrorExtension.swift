//
//  NSErrorExtension.swift
//  CityEntry
//
//  Created by Khaled Annajar on 11/03/2021.
//

import Foundation

extension NSError {
    class func error(domain: String = "Debugging", code: Int = 1, message: String) -> NSError {
        
        let userInfo: [String : Any] =
                    [
                        NSLocalizedDescriptionKey :  message
                ]
        let error = NSError(domain: domain, code: code, userInfo: userInfo)
        return error
    }
}
