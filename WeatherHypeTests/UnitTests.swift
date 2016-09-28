//
//  UnitTests.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import XCTest

class UnitTests: XCTestCase {
    
    var apiClient:APIClient!
    var rootViewController:RootViewController!
    var cityViewController:CityViewController!
    
    override func setUp() {
        super.setUp()
        apiClient = APIClient()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for:type(of:self)))
        rootViewController = storyboard.instantiateInitialViewController() as! RootViewController!
        cityViewController = storyboard.instantiateViewController(withIdentifier:"City") as! CityViewController
    }
    
    override func tearDown() {
        self.apiClient = nil
        self.rootViewController = nil
        self.cityViewController = nil
        super.tearDown()
    }
    
    
    func testAppConfig() {
        
        let configDict = apiClient.configDict()
        XCTAssertNotNil(configDict)
        
        let appId = configDict?.object(forKey: "AppID") as! String
        let baseURL = configDict?.object(forKey: "BaseURL") as! String
        let units = configDict?.object(forKey: "Units") as! String
        let defaultCity = configDict?.object(forKey: "DefaultCity") as! String
        
        XCTAssertNotNil(appId)
        XCTAssertNotNil(baseURL)
        XCTAssertNotNil(units)
        XCTAssertEqual(units, "metric")
        XCTAssertNotNil(defaultCity)
        XCTAssertEqual(units, "London")
    }
    
    
    func testRootViewController() {
        
        // test that RootViewController can return a CityViewController
        let city = City(cityId: "2643743", name: "London", country: "GB")
        let cityViewController = rootViewController.cityViewController(for: city)
        
        XCTAssertNotNil(cityViewController.city!, "cityViewController should have a city")
        XCTAssertEqual(cityViewController.city!.cityId, city.cityId, "cityViewController should have the right city")
    }
    
    
    func testCityViewController() {
        
        // test date formatting for today and tomorrow's dates
        let today = Date()
        let todayString = cityViewController.text(for:today)
        XCTAssertEqual(todayString, "Today", "Today is Today")
        
        let tomorrow = Date(timeIntervalSinceNow: 24*60*60)
        let tomorrowString = cityViewController.text(for:tomorrow)
        XCTAssertEqual(tomorrowString, "Tomorrow", "Tomorrow is Tomorrow")
    }
    
  
    func testDateExtension() {
    
        let dateString = "28 Sep 2016"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.date(from:dateString)
        
        let dayOfWeek = date!.dayOfWeek()
        XCTAssertEqual(dayOfWeek, "Wednesday", "Sept the 28th 2016 is Wednesdays")
    }
    
}
