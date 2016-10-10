//
//  RootViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class RootViewController:UIViewController {

    
    var apiClient: APIClient!
    var city:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiClient = APIClient()
        setupUI()
    }
    
    func setupUI() {
        
        let viewController = self.cityViewController(for:nil)
        self.display(viewController:viewController)

    }
    
    //MARK: CityHandler
    func handleCity(city:String) -> Void {
        self.city = city
       
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

    
    func cityViewController(for city:City?) -> CityViewController {
        
        let viewController = UIStoryboard(name: "Main", bundle: Bundle(for:type(of:self))).instantiateViewController(withIdentifier: "City") as! CityViewController
        
        viewController.city = city
        viewController.apiClient = apiClient
        return viewController
    }
}
