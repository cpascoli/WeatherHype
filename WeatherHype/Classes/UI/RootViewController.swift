//
//  RootViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class RootViewController:UIViewController {

    typealias LocationResponse = (City, NSError?) -> Void
    var apiClient: APIClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiClient = APIClient()
        setupUI()
    }
    
    func setupUI() {
        
        self.findCityToDisplay(onCompletion:{[weak self] city, error in
            let viewController = self?.cityViewController(for:city)
            DispatchQueue.main.async(execute:{
                self?.display(viewController:viewController!)
            })
        })
    }
    
    
    func findCityToDisplay(onCompletion:@escaping LocationResponse) {
        
        let query = apiClient.config?.value(forKey: "DefaultCity") as! String
        
        self.apiClient.find(query: query, onCompletion: {results, error in
            let city = results?.results.first
            if let city = city {
                onCompletion(city, nil)
            }
        })
    }
    
    func display(viewController:UIViewController) {
    
        // center view
        viewController.view.center = self.view.center
        let h = self.view.bounds.size.height
        let w = self.view.bounds.size.width
        viewController.view.bounds = CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width:w, height:h))
        
        // add child view
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }

    
    func cityViewController(for city:City) -> CityViewController {
        
        let viewController = UIStoryboard(name: "Main", bundle: Bundle(for:type(of:self))).instantiateViewController(withIdentifier: "City") as! CityViewController
        viewController.city = city
        viewController.apiClient = APIClient()
        return viewController
    }
}
