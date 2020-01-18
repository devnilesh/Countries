//
//  SearchCountryRequest.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import Foundation
typealias SearchCountryResponse = (Result<[Country], Error>) -> Void

protocol SearchCountryRequestType {
    @discardableResult func searchCountry(apiModel: SearchCountryRequestModel, completion : @escaping SearchCountryResponse) -> URLSessionDataTask?
}

struct SearchCountryAPIRequest : SearchCountryRequestType {
    @discardableResult func searchCountry(apiModel: SearchCountryRequestModel, completion: @escaping SearchCountryResponse) -> URLSessionDataTask? {
        
        
        let requestModel = APIRequestModel(api: CountryAPI.searchCountry(apiModel))
        return APIHelper.requestAPI(apiModel: requestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType: [Country].self, completion: { (allCountries, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }
                    
                    if let countries = allCountries {
                        completion(.success(countries))
                        return
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
