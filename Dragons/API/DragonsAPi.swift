//
//  DragonsAPi.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

class DragonsApi {
    var session: URLSession
    static let shared = DragonsApi()
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    convenience init() {
        self.init(configuration: .default)
    }
}

extension DragonsApi: ApiClient {
    
    var printsDebug: Bool {
       
        return true
    }
    
     func getAvailableFlights(request: URLRequest,
                              completion: @escaping (Result<AvailableFlightsResponse?, ApiError>) -> Void) {
        
        fetch(with: request, decode: { json -> AvailableFlightsResponse? in
              guard let result = json as? AvailableFlightsResponse else { return  nil }
                      return result
        }, completion: completion)
    }
    
    
    func getCurrency(request: URLRequest, completion: @escaping (Result<CurrencyResponse?, ApiError>) -> Void) {
               fetch(with: request, decode: { json -> CurrencyResponse? in
                     guard let result = json as? CurrencyResponse else { return  nil }
                             return result
               }, completion: completion)
    }

}
