//
//  Country.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import Foundation

class Country : Codable {
    var name : String?
    var flag : String?
    var capital : String?
    var callingCodes : [String]?
    var region : String?
    var subregion : String?
    var timezones : [String]?
    var population : Int64?
    var nativeName : String?
    var area : Double?
    var currencies : [Currency]?
    var languages : [Language]?
}

class Currency : Codable {
    var code : String?
    var name : String?
    var symbol : String?
}

class Language : Codable {
    var iso639_1 : String?
    var iso639_2  : String?
    var name : String?
    var nativeName : String?
}
