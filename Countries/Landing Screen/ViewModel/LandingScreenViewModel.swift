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
    private var countriesList : [Country] = []
    
    func loadTestModels() {
        self.countries = [
            CountryViewModel.init(),
            CountryViewModel.init(),
            CountryViewModel.init(),
            CountryViewModel.init(),CountryViewModel.init()
        ]
    }
    
    func searchCountryBy(_ name: String) {
        let queryModel = SearchCountryRequestModel(countryName: name)
        SearchCountryAPIRequest().searchCountry(apiModel: queryModel) { [weak self]  apiResult in
            DispatchQueue.main.async {
                switch apiResult {
                case .success(let countriesList):
                    self?.countriesList = countriesList
                    print("Found countries : \(countriesList.count)")
                case .failure(let error):
                    print("\(error)")
                }
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
