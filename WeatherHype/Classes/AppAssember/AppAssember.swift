//
//  AppAssember.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class AppAssember: NSObject {

    var apiClient:APIClient
    
    override init() {
       
        apiClient = APIClient()
    }
    
    func cityViewController(for city:City) -> CityViewController {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "City") as! CityViewController
        viewController.city = city
        viewController.apiClient = apiClient
        

        
        return viewController
    }
    
}
