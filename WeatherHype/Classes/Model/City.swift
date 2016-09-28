//
//  City.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class City: NSObject {

    var cityId:String
    var name:String
    var country:String
    
    init(cityId:String, name:String, country:String) {
        self.cityId = cityId
        self.name = name
        self.country = country
    }
}
