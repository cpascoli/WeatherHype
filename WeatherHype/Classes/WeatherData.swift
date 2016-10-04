//
//  WeatherData.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

enum WeatherStatus: String {
    
    case clear,
         clouds,
         rain,
         thunderstorm,
         snow,
         mist,
         unknown

    init(rawValue: String) {
        switch rawValue {
            case "Clear": self = .clear
            case "Clouds": self = .clouds
            case "Rain": self = .rain; break
            case "Thunderstorm": self = .thunderstorm
            case "Snow": self = .snow
            case "Mist": self = .mist
            default: self = .unknown
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
    
    func name() -> String {
        return self.rawValue.localized
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

