//
//  CountryAPIs.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import Foundation
struct SearchCountryRequestModel {
    let countryName : String
}

enum CountryAPI {
    case searchCountry(SearchCountryRequestModel)
}

extension CountryAPI : APIProtocol {
    
    func httpMthodType() -> HTTPMethodType {
          var methodType = HTTPMethodType.get
          switch self {
          case .searchCountry(_):
              methodType = .get
          }
          return methodType
      }

      func apiEndPath() -> String {
          var apiEndPath = ""
          switch self {
          case .searchCountry(let queryModel):
            apiEndPath += APIConstants.searchCountries + "\(queryModel.countryName)"
          }
          return apiEndPath
      }

      func apiBasePath() -> String {
          switch self {
          case .searchCountry(_):
            return APIConstants.baseURL + APIConstants.apiVersion
          }
      }
}



