//
//  SearchResultsTransformer.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchResultsTransformer: NSObject {


    func parse(json:JSON) -> SearchResults {
    
        var results = [City]()
        
        let list = json["list"].arrayValue
        for item in list {
            let cityId = item["id"].stringValue
            let name = item["name"].stringValue
            let country = item["sys"]["country"].stringValue
            
            let city = City(cityId: cityId, name: name, country: country)
            results.append(city)
        }
        
        let searchReults = SearchResults(results:results)
        return searchReults
        
    }

}
