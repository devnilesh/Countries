//
//  LandingScreenViewModel.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit

class LandingScreenViewModel {
    
    private var countries : [CountryViewModel] = []
    
    
    func loadTestModels() {
        self.countries = [
            CountryViewModel.init(),
            CountryViewModel.init(),
            CountryViewModel.init(),
            CountryViewModel.init(),CountryViewModel.init()
        ]
    }
    
    
    func numberOfRows() -> Int{
        return countries.count
    }
    
    func countryFor(row: Int) -> CountryViewModel? {
        if row < countries.count {
            return countries[row]
        }
        return nil
    }
}
