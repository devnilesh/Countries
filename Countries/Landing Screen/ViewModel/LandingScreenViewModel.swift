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
    private var offlineCountries :  [CountryViewModel] = []
    private var countryLookupService: CountryLookupService = CountryLookupService()
    private let repository : CountriesRepository = CountriesRepository()

    private func loadCountriesViewModels(from: [Country]) {
        self.countries = from.map { country in
            return CountryViewModel.init(country: country)
        }
    }
    
    func loadfflineCountries() throws{
        var tmpCountries : [Country] = []
        let offlineCountries = try repository.getAllCountries()
        for con in offlineCountries {
            let country = Country()
            CountriesModelsMapper.map(from: con, to: country)
            tmpCountries.append(country)
        }
        loadCountriesViewModels(from: tmpCountries)
        self.offlineCountries = self.countries
    }
    
    private func filterLocally(_ name: String) {
        let filtered = self.offlineCountries.filter({
            $0.name?.range(of: name, options: .caseInsensitive) != nil
        })
        self.countries = (filtered.count == 0) ? self.offlineCountries : filtered
    }
    
    func searchCountryBy(_ name: String, _ completion: @escaping (String?)-> Void) {
        guard Utility.isNetworkReachable() else {
            self.filterLocally(name)
            return completion("You are offline")
        }
        guard name.count > 0 else {
            self.filterLocally(name)
            return completion(nil)
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
