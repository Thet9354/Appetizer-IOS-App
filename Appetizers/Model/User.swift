//
//  User.swift
//  Appetizers
//
//  Created by Phoon Thet Pine on 17/4/24.
//

import Foundation

struct User: Codable {
    
    var firstName           = ""
    var lastName            = ""
    var email               = ""
    var birthdate           = Date()
    var frequentRefills     = false
    var extraNapkins        = false
}
