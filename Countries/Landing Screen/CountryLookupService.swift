//
//  CountryLookupService.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

class LookupResult  {
    var searchTerm : String?
    var searchResult : [Country] = []
    var error : Error?
}


import Foundation

class CountryLookupService {
    
    private var searchTimer : Timer?
    private var searchResult : LookupResult = LookupResult()
    private var isLoading = false
    private var delayInterval : TimeInterval = 0.5 // in seconds
    private var minSearchTermCharCount = 2
    
    public func getResult() -> [Country] {
        return self.searchResult.searchResult
    }
    
    
    public func search(term: String, completion: @escaping (Bool, NSError?) -> Void){

        if searchResult.searchTerm == term, term.count > minSearchTermCharCount {
            return
        }
        searchResult.searchTerm = term
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: delayInterval, repeats: false, block: { [weak self](timer) in
            if let this = self {
                this.beginSearch(term: term, completion: completion)
            }
            else {
                completion(false, NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "Something went wrong, try again"]))
            }
        })
    }
    
    private func beginSearch(term: String, completion: @escaping (Bool, NSError?) -> Void) {
        if isLoading == true {
            return
        }
        if term.count == 0 {
            self.clearSearchResult()
            completion(true, nil)
            return
        }
        self.onStartSearch(term: term)
        let queryModel = SearchCountryRequestModel(countryName: term)
        SearchCountryAPIRequest().searchCountry(apiModel: queryModel) { [weak self]  apiResult in
            DispatchQueue.main.async {
                switch apiResult {
                case .success(let countriesList):
                    self?.searchResult.searchResult = countriesList
                    completion(true, nil)
                    
                case .failure(let error):
                    self?.searchResult.error = error
                    completion(false, error as NSError)
                }
                self?.onFinish()
            }
        }
    }
    
    private func onStartSearch(term: String) {
        isLoading = true
        searchResult.error = nil
        searchResult.searchResult = []
    }
       
    private func onFinish() {
        isLoading = false
    }
    
    private func clearSearchResult() {
        self.searchResult.searchResult = []
        self.searchResult.error = nil
        self.onFinish()
    }
    
}
