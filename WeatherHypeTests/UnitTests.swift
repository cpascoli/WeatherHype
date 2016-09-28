//
//  UnitTests.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import XCTest

class UnitTests: XCTestCase {
    
    var appAssembler:AppAssember!
    
    override func setUp() {
        super.setUp()
        self.appAssembler = AppAssember()
    }
    
    override func tearDown() {
        super.tearDown()
        self.appAssembler = nil
    }
    
    func testAppConfig() {
        
        let configDict = appAssembler.apiClient.configDict()
        XCTAssertNotNil(configDict)
        
        let appId = configDict?.object(forKey: "AppID") as! String
        let baseURL = configDict?.object(forKey: "BaseURL") as! String
        let units = configDict?.object(forKey: "Units") as! String
        XCTAssertNotNil(appId)
        XCTAssertNotNil(baseURL)
        XCTAssertNotNil(units)
        XCTAssertEqual(units, "metric")
        
    }
    
    func testCityViewController() {
        
        let city = City(cityId: "2643743", name: "London", country: "GB")
        let viewController = appAssembler.cityViewController(city: city)
        
        XCTAssertNotNil(viewController, "cityViewController should not be nil")
        XCTAssertNotNil(viewController.wetherViewContoller, "cityViewController should have a wetherViewContoller")
        XCTAssertNotNil(viewController.city, "cityViewController should have a city")
        XCTAssertEqual(viewController.city.cityId, city.cityId, "cityViewController should have the right city")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
