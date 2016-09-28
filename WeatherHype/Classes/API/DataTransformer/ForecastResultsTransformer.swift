//
//  ForecastResultsTransformer.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit
import SwiftyJSON

class ForecastResultsTransformer: NSObject {

    func parse(json:JSON) -> ForecastResults {
        
        let forecastsReults = ForecastResults()
        forecastsReults.city = parseCity(json: json["city"])
        var data = [WeatherData]()
        
        for (index, item) in json["list"].arrayValue.enumerated() {
            
            // The service provides data items every 3h.
            // but we are going to use only one per day.
            if index % 8 == 0 {
                let weatherData = parseWeatherData(json:item)
                let weatherArray = item["weather"].arrayValue
                if weatherArray.count > 0 {
                    let firstWeather = weatherArray[0]
                    decorate(item:weatherData, json:firstWeather)
                }
                data.append(weatherData)
            }            
        }
        forecastsReults.data = data
        return forecastsReults
    }
    
    func parseCity(json:JSON) -> City {
        
        let cityId = json["id"].stringValue
        let name = json["name"].stringValue
        let country = json["country"].stringValue
        let city = City(cityId:cityId, name:name, country:country)
        return city
    }
    
    func parseWeatherData(json:JSON) -> WeatherData {
        
        let timestamp = json["dt"].numberValue
        let main = json["main"]
        let temperature = main["temp"].numberValue
        let minTemp = main["temp_min"].numberValue
        let maxTemp = main["temp_max"].numberValue
        let humidity = main["humidity"].numberValue        
        let pressure = main["pressure"].numberValue
        let wind = json["wind"]["speed"].numberValue
        
        let item = WeatherData()
        item.humidity = humidity
        item.temperature = temperature
        item.minTemperature = minTemp;
        item.maxTemperature = maxTemp
        item.humidity = humidity
        item.pressure = pressure
        item.wind = wind
        item.date = Date(timeIntervalSince1970:timestamp.doubleValue)
        return item
    }
    
    func decorate(item:WeatherData, json:JSON) {
    
        let main = json["main"].stringValue
        let description = json["description"].stringValue
        let icon = json["icon"].stringValue
        item.weatherMain = main
        item.weatherDescription = description
        item.icon = icon
    }
    
}
