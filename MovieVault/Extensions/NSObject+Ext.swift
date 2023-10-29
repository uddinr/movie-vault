//
//  NSObject+Ext.swift
//  MovieVault
//
//  Created by Rehan Uddin on 28/10/2023.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
