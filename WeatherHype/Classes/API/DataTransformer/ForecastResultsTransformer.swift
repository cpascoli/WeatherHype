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
        
        for item in json["list"].arrayValue {
            let WeatherData = parseWeatherData(json:item)
            let weatherArray = item["weather"].arrayValue
            if weatherArray.count > 0 {
                let firstWeather = weatherArray[0]
                decorate(item: WeatherData, json:firstWeather)
            }
            data.append(WeatherData)
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
    
    func  parseWeatherData(json:JSON) -> WeatherData {
        
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
        item.time = Date(timeIntervalSinceReferenceDate: TimeInterval(timestamp))
        return item
    }
    
    func decorate(item:WeatherData, json:JSON) {
    
        let main = json["main"].stringValue
        let description = json["description"].stringValue
        //let icon = firstWeather["icon"]
        item.weatherMain = main
        item.weatherDescription = description
    }
    
}
