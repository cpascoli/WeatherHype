//
//  SearchResults.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class SearchResults: NSObject {

    var results:[City]
    
    init(results:[City]) {
        self.results = results
    }
}
