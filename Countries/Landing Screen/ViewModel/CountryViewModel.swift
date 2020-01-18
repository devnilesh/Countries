//
//  CountryViewModel.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit

class CountryViewModel  {
    var country : Country
    
    init(country: Country) {
        self.country = country
    }
    
    var flagImage : UIImage? {
        get {
            return  UIImage(named: "india")
        }
    }
    
    var flagImageURL : URL? {
        get {
            if let url = country.flag {
                return URL(string: url)
            }
            return nil
        }
    }
    
    var name : String?  {
        get {
            return self.country.name
        }
    }
    
    var capital : String {
        get {
            return "Capital : \(country.capital ?? "")"
        }
    }
    
    var region : String {
        get {
            var reg = "Region : "
            if let region = country.region, region.count > 0 {
                reg.append(region)
            }
            if let subregion = country.subregion, subregion.count > 0 {
                reg.append("(\(subregion))")
            }
            return reg
        }
    }
    
    var languages : String {
        get {
            if let languages = country.languages {
                let strLang =  languages.compactMap { language in
                    return language.name
                }
                return strLang.joined(separator: ", ")
            }
            return "Capital : \(country.capital ?? "")"
        }
    }
    
    var callingCode : String {
        get {
            if let callingCodes = country.callingCodes {
                return callingCodes.joined(separator: ", ")
            }
            return ""
        }
    }
    
    
    var population : String {
        get {
            if let population = country.population {
                return "\(population)"
            }
            return ""
        }
    }
    
    var timeZone  : String{
        get {
            if let timezones = country.timezones {
                return timezones.joined(separator: ", ")
            }
            return ""
        }
    }
    
    var currencies  : String {
        get {
            if let currencies = country.currencies {
                
                let strCurrency =  currencies.compactMap { currency in
                    return "\(currency.name ?? "") (\(currency.symbol ?? ""))"
                }
                return strCurrency.joined(separator: ", ")
            }
            return ""
        }
    }
    
    var totalArea : String {
        get {
            if let area = country.area {
                return "\(area) sq km"
            }
            return ""
        }
    }
    
    func save() throws{
        let context = LocalStorage.managedObjectContext()
        let repository = CountriesRepository(context: context)
        let countryDetails = try repository.createCountry(from: self.country)
        CountriesModelsMapper.map(from: self.country, to: countryDetails)
        
        if let currencies = self.country.currencies {
            var tmpCurrencies : [CountryCurrency] = []
            for cur in currencies {
                let currency = try repository.createCountryCurrency(from: cur)
                currency.code = cur.code
                currency.symbol = cur.symbol
                tmpCurrencies.append(currency)
            }
            countryDetails.currencies = NSSet(array: tmpCurrencies)
        }
        
        if let languages = self.country.languages {
            var tmpLanguages : [CountryLanguage] = []
            for lng in languages {
                let language = try repository.createCountryLanguage(from: lng)
                language.nativeName = lng.nativeName
                language.iso639_1 = lng.iso639_1
                language.iso639_2 = lng.iso639_2
                tmpLanguages.append(language)
            }
            countryDetails.languages = NSSet(array: tmpLanguages)
        }
        try LocalStorage.saveContext(context: context, saveParent: true)
    }
   
}
