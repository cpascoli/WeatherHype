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
    var weatherViewController:WeatherViewController!
    
    override func setUp() {
        super.setUp()
        apiClient = APIClient()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for:type(of:self)))
        rootViewController = storyboard.instantiateInitialViewController() as! RootViewController!
        cityViewController = storyboard.instantiateViewController(withIdentifier:"City") as! CityViewController
        
        weatherViewController = storyboard.instantiateViewController(withIdentifier: "Weather") as! WeatherViewController
        weatherViewController.model = mockWeatherData()
        weatherViewController.apiClient = apiClient
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
        let imageURL = configDict?.object(forKey: "ImageURL") as! String
        let units = configDict?.object(forKey: "Units") as! String
        let defaultCity = configDict?.object(forKey: "DefaultCity") as! String
        
        XCTAssertNotNil(appId)
        XCTAssertNotNil(baseURL)
        XCTAssertNotNil(imageURL)
        XCTAssertNotNil(units)
        XCTAssertEqual(units, "metric")
        XCTAssertNotNil(defaultCity)
        XCTAssertEqual(defaultCity, "London")
    }
    
    
    func testRootViewController() {
        
        // test that RootViewController can return a CityViewController
        let city = City(cityId: "2643743", name: "London", country: "GB")
        let cityViewController = rootViewController.cityViewController(for: city)
        
        XCTAssertNotNil(cityViewController.city!, "cityViewController has a city")
        XCTAssertEqual(cityViewController.city!.cityId, city.cityId, "cityViewController has the right city")
       
    }
    
    
    func testCityViewController() {
        
        // test date formatting for today and tomorrow's dates
        let today = Date()
        let todayString = cityViewController.text(for:today)
        XCTAssertEqual(todayString, "Today", "Today is Today")
        
        let tomorrow = Date(timeIntervalSinceNow: 24*60*60)
        let tomorrowString = cityViewController.text(for:tomorrow)
        XCTAssertEqual(tomorrowString, "Tomorrow", "Tomorrow is Tomorrow")
        
        cityViewController.loadView()
        XCTAssertNotNil(cityViewController.cityLabel, "cityViewController has cityLabel")
        XCTAssertNotNil(cityViewController.dateLabel, "cityViewController has dateLabel")
    }
    
    func testWeatherViewController() {
    
        weatherViewController.loadView()
        weatherViewController.updateView()
        
        XCTAssertNotNil(weatherViewController.imageView, "weatherViewController has imageView")
        XCTAssertNotNil(weatherViewController.maxTemperatureLabel, "weatherViewController has maxTemperatureLabel")
        XCTAssertNotNil(weatherViewController.minTemperatureLabel, "weatherViewController has minTemperatureLabel")
        XCTAssertNotNil(weatherViewController.descriptionLabel, "weatherViewController has descriptionLabel")
        XCTAssertNotNil(weatherViewController.windLabel, "weatherViewController has windLabel")
        XCTAssertNotNil(weatherViewController.humidityLabel, "weatherViewController has humidityLabel")
        XCTAssertNotNil(weatherViewController.pressureLabel, "weatherViewController has pressureLabel")
        
        XCTAssertEqual(weatherViewController.maxTemperatureLabel.text, "31°", "correct max temp")
        XCTAssertEqual(weatherViewController.minTemperatureLabel.text, "20°", "correct min temp")
        XCTAssertEqual(weatherViewController.descriptionLabel.text, "few clouds")
        XCTAssertEqual(weatherViewController.windLabel.text, "15 km/hr", "correct wind speed")
        XCTAssertEqual(weatherViewController.humidityLabel.text, "80%", "correct humidity")
        XCTAssertEqual(weatherViewController.pressureLabel.text, "1025 hPa", "correct pressure")
    }
    
  
    func testDateExtension() {
    
        let dateString = "28 Sep 2016"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.date(from:dateString)
        
        let dayOfWeek = date!.dayOfWeek()
        XCTAssertEqual(dayOfWeek, "Wednesday", "Sept the 28th 2016 is Wednesdays")
    }
    
    func mockWeatherData() -> WeatherData {
        
        let data = WeatherData()
        data.date = Date()
        data.minTemperature = 19.8
        data.maxTemperature = 31.3
        data.temperature = 25.0
        data.humidity = 80.2
        data.pressure = 1025.0
        data.wind = 4.3
        data.icon = "1d0"
        data.weatherStatus = WeatherStatus(rawValue:"Clouds")
        data.weatherDescription = "few clouds"
        return data
    }
    
}
