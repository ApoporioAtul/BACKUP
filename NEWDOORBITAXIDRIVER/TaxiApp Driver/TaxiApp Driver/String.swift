//
//  String.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 23/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import Foundation

extension String {
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
    
    func substring(from: Int) -> String {
        return self.substringFromIndex(self.startIndex.advancedBy(from))
    }
    
    var length: Int {
        return self.characters.count
    }
}