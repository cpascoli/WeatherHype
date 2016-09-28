//
//  WeatherHypeTests.swift
//  WeatherHypeTests
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import XCTest
@testable import WeatherHype

class WeatherHypeTests: XCTestCase {
    
    var apiClient:APIClient?
    
    override func setUp() {
        super.setUp()
        self.apiClient = APIClient()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAppConfig() {
        
        let configDict = apiClient!.configDict()
        XCTAssertNotNil(configDict)
        
        let appId = configDict?.object(forKey: "AppID") as! String
        let baseURL = configDict?.object(forKey: "BaseURL") as! String
        let units = configDict?.object(forKey: "Units") as! String
        XCTAssertNotNil(appId)
        XCTAssertNotNil(baseURL)
        XCTAssertNotNil(units)
        XCTAssertEqual(units, "metric")
        
    }
    
    func testSearchRequest() {
        let theExpectation = expectation(description: "weather request returns data")
        apiClient?.search(query: "Lond", onCompletion: {searchResults, error -> Void in
            print(searchResults)
            theExpectation.fulfill()
        })
        
        // 2s timeout
        waitForExpectations(timeout: 2000, handler: { error in
            XCTAssertNil(error, "Oh, weather request timeout")
        })
    }
    
    func testForecastForCityRequest() {
        
        let theExpectation = expectation(description: "weather request returns data")
        apiClient?.forecast(byCityId: "2172797", onCompletion: {forecastResults, error -> Void in
            print(forecastResults)
            
            XCTAssertNotNil(forecastResults?.city, "forecast resuts should have city")
            XCTAssertNotNil(forecastResults?.data, "forecast resuts should have data")
            XCTAssertEqual(forecastResults?.data?.count, 40, "forecast resuts should have 40 data items")
            
            theExpectation.fulfill()
        })
        
        // 2s timeout
        waitForExpectations(timeout: 2000, handler: { error in
            XCTAssertNil(error, "Oh, weather request timeout")
        })
    }
    
    
//    func testWatherForCityRequest() {
//        let theExpectation = expectation(description: "weather request returns data")
//        apiClient?.weather(byCityId: "2172797", onCompletion: {json, error -> Void in
//            print(json)
//            theExpectation.fulfill()
//        })
//
//        // 2s timeout
//        waitForExpectations(timeout: 2000, handler: { error in
//            XCTAssertNil(error, "Oh, weather request timeout")
//        })
//    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
