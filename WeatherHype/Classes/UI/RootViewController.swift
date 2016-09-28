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
    
    let appAssember = AppAssember()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func findCityToDisplay(onCompletion:LocationResponse) {
    
        let city = City(cityId: "2643743", name: "London", country: "GB")
        onCompletion(city, nil)
    }
    
    
    func setupUI() {
    
        findCityToDisplay(onCompletion:{[weak self] city, error in
            
            let viewController = self?.appAssember.cityViewController(for:city)
            DispatchQueue.main.async(execute:{
                self?.display(viewController:viewController!)
            })
            
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

}
