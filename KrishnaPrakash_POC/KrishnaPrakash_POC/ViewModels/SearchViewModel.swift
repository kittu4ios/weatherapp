//
//  SearchViewModel.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation

class SearchViewModel {
    var cacheCities = [String]()
    fileprivate(set) var searchString: String = ""
    var dataSource: [String]? {
        get {
            if searchString.isEmpty {
                return cacheCities
            }
            return self.cacheCities.filter { (city) -> Bool in
                return city.lowercased().contains(searchString.lowercased())
            }
        }
    }
    func searchCities(string: String) {
        searchString = string
    }
    /// Method to get all cached cities
    func prepareCacheData() {
        cacheCities = CityCacheData().getCities().map {$0.name}
    }
    /// Clear stored cache data
    func clearCacheData() {
        CityCacheData().clearCache()
        prepareCacheData()
    }
}
