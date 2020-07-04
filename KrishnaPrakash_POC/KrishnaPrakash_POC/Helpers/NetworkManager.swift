//
//  NetworkManager.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation

class NetworkManager {
 
    static let sharedInstance = NetworkManager()

    private init() {
        
    }

    
    //Get weather report API
    func getWeatherAPI(paramsString: String, completion: @escaping ((WeatherResponse?, Error?) -> Void)) {
        let urlString = Constants.BaseURLs.baseUrl + Constants.WeatherAPI.weather + paramsString
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [kCFErrorLocalizedDescriptionKey as String : NSLocalizedString("Error while creating weather API URL.", comment:"Error while creating weather API URL.")]))
            return
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        
         let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let response = data {
                Utilites.dataToObject(type: WeatherResponse.self, from: response, completion: completion)
            }
        })
        task.resume()
        
    }
    
}
