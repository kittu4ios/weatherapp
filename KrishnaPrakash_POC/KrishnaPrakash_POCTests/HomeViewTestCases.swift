//
//  HomeViewTestCases.swift
//  KrishnaPrakash_POCTests
//
//  Created by Krishna Prakash on 7/4/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import XCTest
@testable import KP_POC

class HomeViewTestCases: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testStoreCache() {
        let viewModel = HomeViewModel()
        viewModel.storeInCache(cityName: "London")
        let cacheData = CityCacheData()
        XCTAssertTrue(cacheData.getCities().count == 1)
        cacheData.clearCache()
    }
    func testClearCache() {
        let viewModel = HomeViewModel()
        viewModel.storeInCache(cityName: "London")
        let cacheData = CityCacheData()
        cacheData.clearCache()
        XCTAssertTrue(cacheData.getCities().count == 0)

    }
    
    func testTemparatureWithCelsius() {
        let viewModel = HomeViewModel()
        viewModel.temparature = 280.7
        viewModel.temparatureType = TempType.Celsius
        let resultTemp = viewModel.getCurrentTemparature()
        XCTAssertTrue(resultTemp == "7.6°C" )
    }
    func testTemparatureWithFahrenheit() {
        let viewModel = HomeViewModel()
        viewModel.temparature = 280.7
        viewModel.temparatureType = TempType.Farenheat
        let resultTemp = viewModel.getCurrentTemparature()
        XCTAssertTrue(resultTemp == "45.6°F" )
    }
    
    func testWeatherAPIValidData() {
        let expectation = XCTestExpectation(description: "Weather API with valid data")
        let viewModel = HomeViewModel()
        viewModel.storeInCache(cityName: "Hyderabad")
        viewModel.callWeatherAPI { (error) in
            XCTAssertNil(error)
            CityCacheData().clearCache()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    func testWeatherAPIInValidData() {
        let expectation = XCTestExpectation(description: "Weather API with invalid data")
        let viewModel = HomeViewModel()
        viewModel.storeInCache(cityName: "invalidtest")
        viewModel.callWeatherAPI { (error) in
            XCTAssertNotNil(error)
            CityCacheData().clearCache()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
