//
//  WeatherData.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class WeatherData: NSObject {

    var time:Date?
    var minTemperature:NSNumber?
    var maxTemperature:NSNumber?
    var temperature:NSNumber?
    var humidity:NSNumber?
    var pressure:NSNumber?
    var wind:NSNumber?
    
    var weatherMain:String?
    var weatherDescription:String?
    
}
