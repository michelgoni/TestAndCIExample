//
//  Encodable+Extensions.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

extension Encodable {
    func data() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Decodable {
        
    static func decodeElement<T: Decodable>(jsonData: Data, using modelType: T.Type) -> T? {
        do {
            let element = try JSONDecoder().decode(modelType, from: jsonData)
            return element
        } catch let parsingError {
            debugPrint("Error", parsingError)
        }
        return nil
    }
}
