//
//  WeatherData.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

enum WeatherStatus: String {
    
    case clear = "Clear",
        clouds = "Clouds",
        rain = "Rain",
        thunderstorm = "Thunderstorm",
        snow = "Snow",
        mist = "Mist",
        unknown = "Unknown"
    
    init(rawValue: String) {
        switch rawValue {
            case "Clear": self = .clear; break
            case "Clouds": self = .clouds; break
            case "Rain": self = .rain; break
            case "Thunderstorm": self = .thunderstorm; break
            case "Snow": self = .snow; break
            case "Mist": self = .mist; break
            default: self = .unknown; break
        }
    }
    
    func color() -> UIColor {
        switch self {
            case .clear: return UIColor(hex:0x62B3FC)
            case .clouds: return UIColor(hex:0xBDC7D1)
            case .rain: return UIColor(hex:0x789497)
            case .thunderstorm: return UIColor(hex:0x617A7D)
            case .snow: return UIColor(hex:0xE1E6E7)
            case .mist: return UIColor(hex:0xE1E1E1)
            default: return UIColor(hex:0xB6A156)
        }
    }
}

class WeatherData: NSObject {

    var date:Date?
    var minTemperature:NSNumber?
    var maxTemperature:NSNumber?
    var temperature:NSNumber?
    var humidity:NSNumber?
    var pressure:NSNumber?
    var wind:NSNumber?
    var icon:String?
    var weatherStatus:WeatherStatus?
    var weatherDescription:String?
    
}

