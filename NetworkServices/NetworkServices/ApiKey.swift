//
//  ApiKey.swift
//  NetworkServices
//
//  Created by Phincon on 22/09/21.
//

import Foundation
import UIKit

class ApiKey {
    
    static let share = ApiKey()
    
    private var apiKeys: String {
      get {
        
        let bundle = Bundle(identifier: "asd.NetworkServices")
        
        // 1
        guard let filePath = bundle?.path(forResource: "Api_Key", ofType: "plist") else {
          fatalError("Couldn't find file 'TMDB-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
        }
        // 3
        if (value.starts(with: "_")) {
          fatalError("Register for a TMDB developer account and get an API key at https://developers.themoviedb.org/3/getting-started/introduction.")
        }
        return value
      }
    }
    
    func getApiKey() -> String {
        return apiKeys
    }
}
