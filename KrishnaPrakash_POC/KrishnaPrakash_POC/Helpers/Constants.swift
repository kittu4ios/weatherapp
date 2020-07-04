//
//  Constants.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/4/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation

struct Constants {
    
    struct BaseURLs {
        
        static let baseUrl = "https://api.openweathermap.org/"
    }
    
    struct WeatherAPI {
        static let weather = "data/2.5/weather"
    }
    
    struct AppKeys {
        
        static let ApiKey = "XXXXXXXXXXXXXXXXXX"
    }
}
///Temparate types to display as Celsius, Fahrenheit
enum TempType:Int {
    case Celsius
    case Farenheat
    
    func getType() -> UnitTemperature {
        switch self {
        case .Celsius:
            return .celsius
        case .Farenheat:
            return .fahrenheit
        }
    }
}
