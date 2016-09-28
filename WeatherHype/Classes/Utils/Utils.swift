//
//  Utils.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

extension Date {
    
    func dayOfWeek() -> String {
        
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Satudrday"
        ]
        
        let comp:DateComponents = Calendar.current.dateComponents([.weekday], from: self)
        return weekdays[comp.weekday!-1]        
    }
}

