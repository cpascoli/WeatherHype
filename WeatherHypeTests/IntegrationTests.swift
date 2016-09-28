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
    
    var apiClient:APIClient!
    var city:City?
    
    override func setUp() {
        super.setUp()
        self.apiClient = APIClient()
    }
    
    override func tearDown() {
        self.apiClient = nil
        super.tearDown()
    }
    

    func testSearchRequest() {
       
        // This test uses the "find" API to search London and ensure the top result is indeed London
        
        let theExpectation = expectation(description: "search for London should return data")
        apiClient.find(query: "London", onCompletion: {searchResults, error -> Void in
           
            XCTAssertNotNil(searchResults, "search results not nil")
            XCTAssertTrue(searchResults!.results.count > 0, "search for London have results")
            
            let city = searchResults?.results[0]
            XCTAssertEqual(city!.name, "London", "Found London")

            theExpectation.fulfill()
        })
        
        // set timeout
        waitForExpectations(timeout: 5000, handler: { error in
            XCTAssertNil(error, "Oh, request timeout")
        })
    }
    
 
    func testForecastForCityRequest() {
    
        // Here we search for a city (London) before fetching its weather forecasts.
        // Hardcoding a city id in a test is not a good idea as they seem to change (!)
        
        let theExpectation = expectation(description: "weather request returns data")

        apiClient.find(query: "London", onCompletion: {searchResults, error -> Void in
            let city = searchResults?.results[0]
            self.apiClient.forecast(byCityId:city!.cityId, onCompletion: {forecastResults, error -> Void in
                XCTAssertNotNil(forecastResults?.city, "forecast resuts include city")
                XCTAssertEqual(forecastResults?.city?.name, "London", "resuts for the expected city")
                XCTAssertNotNil(forecastResults?.data, "forecast resuts have data")
                XCTAssertEqual(forecastResults?.data?.count, 5, "forecast resuts should have 5 data items")
                theExpectation.fulfill()
            })
        })
        
        // set timeout
        waitForExpectations(timeout: 5000, handler: { error in
            XCTAssertNil(error, "Oh, request timeout")
        })
    }
    
    
    func testImageDownload() {
        
        // Downlod a thumbnail image
        let theExpectation = expectation(description: "can download thumbnail images")
        
        self.apiClient.downloadImage(name: "01d", onCompletion: { image, error in
             XCTAssertNotNil(image, "thumbnail image downloaded")
             theExpectation.fulfill()
        })
        
        // set timeout
        waitForExpectations(timeout: 5000, handler: { error in
            XCTAssertNil(error, "Oh, request timeout")
        })
    }

}
