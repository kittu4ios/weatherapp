//
//  DataCache.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation

class CacheManager {
    static let sharedInstance = CacheManager()
    var cache = NSCache<NSString, NSArray>()
    private init() {
        
    }
}

class City {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class CityCacheData {
    let cacheKey = "cities" as NSString
    ///maxCacheCount value to store max number of cities in cache
    let maxCacheCount = 10
    
    /// Method to hget all cached cities
    /// - Returns: all cities as [String] format
    func getCities() -> [City] {
        if let cachedData = CacheManager.sharedInstance.cache.object(forKey: cacheKey) {
            return cachedData as? [City] ?? []
        } else {
            return []
        }
    }
    /// Method to Store city name into cache
    /// - Parameter name: cityname as String
    func storeCity(name:String) {
        var cities = getCities()
        //Check if stored cities count is given max limit. if max limit reaches return it
        if cities.count == maxCacheCount {
            return
        }
        ///Check if city name is already stored in cache
        let checkCityAvailable = cities.filter { (city) -> Bool in
            return city.name.lowercased() == name.lowercased()
        }.count > 0
        ///If city name not stored then store cityname into cache
        if !checkCityAvailable {
             cities.append(City.init(name: name))
             CacheManager.sharedInstance.cache.setObject(cities as NSArray, forKey: cacheKey)
        }
    }
    ///Clear the cache
    func clearCache() {
         CacheManager.sharedInstance.cache.setObject([], forKey: cacheKey)
    }
}
