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
        var data = [WeatherItem]()
        
        for item in json["list"].arrayValue {
            let weatherItem = parseWeatherItem(json:item)
            let weatherArray = item["weather"].arrayValue
            if weatherArray.count > 0 {
                let firstWeather = weatherArray[0]
                decorate(item: weatherItem, json:firstWeather)
            }
            data.append(weatherItem)
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
    
    func  parseWeatherItem(json:JSON) -> WeatherItem {
        
        let timestamp = json["dt"].numberValue
        let main = json["main"]
        let temperature = main["temp"].numberValue
        let pressure = main["pressure"].numberValue
        let humidity = main["humidity"].numberValue
        
        let item = WeatherItem()
        item.humidity = humidity
        item.temperature = temperature
        item.humidity = humidity
        item.pressure = pressure
        item.time = Date(timeIntervalSinceReferenceDate: TimeInterval(timestamp))
        return item
    }
    
    func decorate(item:WeatherItem, json:JSON) {
    
        let main = json["main"].stringValue
        let description = json["description"].stringValue
        //let icon = firstWeather["icon"]
        item.weatherMain = main
        item.weatherDescription = description
    }
    
}
