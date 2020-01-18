//
//  CountriesModelsMapper.swift
//  Countries
//
//  Created by Nilesh Mahajan on 19/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import Foundation
struct CountriesModelsMapper {
    static func map(from: Country?, to: CountryDetails?) {
        to?.area = from?.area ?? 0
        to?.callingCodes = from?.callingCodes?.joined(separator: ", ")
        to?.capital = from?.capital
        to?.flagURL = from?.flag
        to?.name = from?.name
        to?.population = from?.population ?? 0
        to?.region = from?.region
        to?.subregion = from?.subregion
        to?.timezone  = from?.timezones?.joined(separator: ", ")
    }
    
    static func map(from: CountryDetails?, to: Country?) {
        to?.area = from?.area
        to?.area = from?.area ?? 0.0
        if let callingCodes = from?.callingCodes {
            to?.callingCodes = callingCodes.split(separator: " ").map({ str in
                return "\(str)"
            })
        }
        
        to?.capital = from?.capital
        to?.flag = from?.flagURL
        to?.name = from?.name
        to?.population = from?.population ?? 0
        to?.region = from?.region
        to?.subregion = from?.subregion
        if let timezone = from?.timezone {
            to?.timezones = timezone.split(separator: " ").map({ str in
                return "\(str)"
            })
        }
        
        if let languages = from?.languages?.allObjects as? [CountryLanguage] {
            var tmpLanguages: [Language] = []
            for lng in languages {
                let language = Language()
                language.name = lng.name
                language.nativeName = lng.nativeName
                language.iso639_1 = lng.iso639_1
                language.iso639_2 = lng.iso639_2
                tmpLanguages.append(language)
            }
            to?.languages = tmpLanguages
        }
        
        if let currencies = from?.currencies?.allObjects as? [CountryCurrency] {
            var tmpCurrencies: [Currency] = []
            for cur in currencies {
                let currency = Currency()
                currency.name = cur.name
                currency.code = cur.code
                currency.symbol = cur.symbol
                tmpCurrencies.append(currency)
            }
            to?.currencies = tmpCurrencies
        }
    }
    
}
