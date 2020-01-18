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
    private var countryLookupService: CountryLookupService = CountryLookupService()

    private func loadCountriesViewModels(from: [Country]) {
        self.countries = from.map { country in
            return CountryViewModel.init(country: country)
        }
    }
    
    func searchCountryBy(_ name: String, _ completion: @escaping (String?)-> Void) {
        guard Utility.isNetworkReachable() else {
            return completion("Please check internet connection")
        }
        self.countryLookupService.search(term: name) { [weak self](success, error) in
            if let this = self {
                let countries = this.countryLookupService.getResult()
                this.loadCountriesViewModels(from: countries)
                completion(nil)
            }
            else {
                completion("Something went wrong, failed to search")
            }
        }
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
