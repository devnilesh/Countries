//
//  CountriesRepository.swift
//  Countries
//
//  Created by Nilesh Mahajan on 19/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit
import CoreData

class CountriesRepository: NSObject {
    private var objectContext : NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.objectContext = context
    }
    
    override init() {
        self.objectContext = LocalStorage.managedObjectContext()
    }
    
    func createCountry(from: Country) throws -> CountryDetails{
        if let name = from.name {
            var country = try self.getCountryBy(name: name)
            if  country == nil {
                country = NSEntityDescription.insertNewObject(forEntityName: "CountryDetails", into: objectContext) as? CountryDetails
                country?.name = name
            }
            return country!
        }
        else {
            throw NSError(domain: "Countries", code: 100, userInfo: [NSLocalizedDescriptionKey: "Country without name can not be saved"])
        }
    }
    
    func createCountryLanguage(from: Language) throws -> CountryLanguage{
        if let name = from.name {
            var langugage = try self.getCountryLanguageBy(name: name)
            if  langugage == nil {
                langugage = NSEntityDescription.insertNewObject(forEntityName: "CountryLanguage", into: objectContext) as? CountryLanguage
                langugage?.name = name
            }
            return langugage!
        }
        else {
            throw NSError(domain: "Countries", code: 100, userInfo: [NSLocalizedDescriptionKey: "Langugage without name can not be saved"])
        }
    }
    
    func createCountryCurrency(from: Currency) throws -> CountryCurrency{
        if let name = from.name {
            var currency = try self.getCountryCurrency(name: name)
            if  currency == nil {
                currency = NSEntityDescription.insertNewObject(forEntityName: "CountryCurrency", into: objectContext) as? CountryCurrency
                currency?.name = name
            }
            return currency!
        }
        else {
            throw NSError(domain: "Countries", code: 100, userInfo: [NSLocalizedDescriptionKey: "Currency without name can not be saved"])
        }
    }
    
    public func getAllCountries() throws -> [CountryDetails]{
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        return try self.getCountry(predicate: nil, sortDescripters: [sortDescripter], limit: nil)
    }
    
    public func searchCountry(_ name: String) throws -> [CountryDetails]{
        let sortDescripter = NSSortDescriptor(key: "name", ascending: false)
        return try self.getCountry(predicate: nil, sortDescripters: [sortDescripter], limit: nil)
    }
    
    public func getCountryBy(name: String) throws -> CountryDetails? {
        let predicate = NSPredicate.init(format: "name == %@", name)
        return try self.getCountry(predicate: predicate, sortDescripters: [], limit: 1).first
    }
    
    public func getCountryLanguageBy(name: String) throws -> CountryLanguage? {
        let predicate = NSPredicate.init(format: "name == %@", name)
        return try self.getCountryLanguage(predicate: predicate, sortDescripters: [], limit: 1).first
    }
    
    public func getCountryCurrency(name: String) throws -> CountryCurrency? {
        let predicate = NSPredicate.init(format: "name == %@", name)
        return try self.getCountryCurrency(predicate: predicate, sortDescripters: [], limit: 1).first
    }
    
    private func getCountry(predicate: NSPredicate?, sortDescripters: [NSSortDescriptor], limit: Int?) throws -> Array<CountryDetails> {
        
        let defaultPredicate = predicate
        
        let fetchRequest: NSFetchRequest = CountryDetails.fetchRequest()
        
        fetchRequest.predicate = defaultPredicate
        fetchRequest.sortDescriptors = sortDescripters
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        let result = try objectContext.fetch(fetchRequest)
        
        return result
    }
    
    private func getCountryLanguage(predicate: NSPredicate?, sortDescripters: [NSSortDescriptor], limit: Int?) throws -> Array<CountryLanguage> {
        
        let defaultPredicate = predicate
        
        let fetchRequest: NSFetchRequest = CountryLanguage.fetchRequest()
        
        fetchRequest.predicate = defaultPredicate
        fetchRequest.sortDescriptors = sortDescripters
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        let result = try objectContext.fetch(fetchRequest)
        
        return result
    }
    
    private func getCountryCurrency(predicate: NSPredicate?, sortDescripters: [NSSortDescriptor], limit: Int?) throws -> Array<CountryCurrency> {
           
           let defaultPredicate = predicate
           
           let fetchRequest: NSFetchRequest = CountryCurrency.fetchRequest()
           
           fetchRequest.predicate = defaultPredicate
           fetchRequest.sortDescriptors = sortDescripters
           if let limit = limit {
               fetchRequest.fetchLimit = limit
           }
           let result = try objectContext.fetch(fetchRequest)
           
           return result
       }
    
}
