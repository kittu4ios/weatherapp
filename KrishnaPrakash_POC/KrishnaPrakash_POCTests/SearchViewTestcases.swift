//
//  SearchViewTestcases.swift
//  KrishnaPrakash_POCTests
//
//  Created by Krishna Prakash on 7/4/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import XCTest
@testable import KP_POC

class SearchViewTestcases: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadCacheData() {
        let homeViewModel = HomeViewModel()
        homeViewModel.storeInCache(cityName: "London")
        homeViewModel.storeInCache(cityName: "Pune")
        homeViewModel.storeInCache(cityName: "Hyderabad")
        homeViewModel.storeInCache(cityName: "Bangalore")

        let searchViewModel = SearchViewModel()
        searchViewModel.prepareCacheData()
        XCTAssertTrue(searchViewModel.cacheCities.count == 4)
        searchViewModel.clearCacheData()

    }

    func testSearchCacheData() {
        let homeViewModel = HomeViewModel()
        homeViewModel.storeInCache(cityName: "London")
        homeViewModel.storeInCache(cityName: "Pune")
        homeViewModel.storeInCache(cityName: "Hyderabad")
        homeViewModel.storeInCache(cityName: "Patna")

        let searchViewModel = SearchViewModel()
        searchViewModel.prepareCacheData()
        searchViewModel.searchCities(string: "p")
        XCTAssertTrue(searchViewModel.dataSource?.count == 2)
        searchViewModel.clearCacheData()

    }
}
