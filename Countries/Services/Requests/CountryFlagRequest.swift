//
//  CountryFlagRequest.swift
//  Countries
//
//  Created by Nilesh Mahajan on 19/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import Foundation
import UIKit
import SVGKit

typealias CountryFlagResponse = (Result<UIImage, Error>) -> Void

struct GetFlagAPIRequest  {
    @discardableResult func getFlagImage(url: URL, completion : @escaping CountryFlagResponse)  -> URLSessionDataTask?{
        let request = URLRequest(url: url)
        return APIHelper.requestAPI(request) { response in
            switch response {
            case .success(let serverData):
                if let image = SVGKImage.init(data: serverData).uiImage {
                    completion(.success(image))
                    return
                }
                else {
                    completion(.failure(NSError(domain: "Country", code: 100, userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
