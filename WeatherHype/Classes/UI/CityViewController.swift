//
//  CityViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class CityViewController:UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var city:City!
    var apiClient:APIClient!
    var dataPageViewController:UIPageViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.fetchData()
        self.cityLabel.text = self.city.name
        
        self.fetchData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func fetchData() {
    
        apiClient.forecast(byCityId: city.cityId, onCompletion: {result, error in
        
            if let result = result, let data = result.data  {
                self.setupPagedViewController(with:data)
            }
        })
    }
    
    func setupPagedViewController(with data:[WeatherData]) {
    
        let viewController = WeatherDataPageViewController()
        viewController.model = data
        
        let offset = CGFloat(100.0)
        viewController.view.center = CGPoint(x:self.view.center.x, y:self.view.center.y + offset)
        let h = self.view.bounds.size.height - offset
        let w = self.view.bounds.size.width
        viewController.view.bounds = CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width:w, height:h))
        
        // add child view
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        
    }
    
}
