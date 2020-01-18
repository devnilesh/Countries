//
//  CountryViewModel.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit

class CountryViewModel  {
    
    var flagImage : UIImage? {
        get {
            return  UIImage(named: "india")
        }
    }
    
    var name : String  {
        get {
            return "India"
        }
    }
}
