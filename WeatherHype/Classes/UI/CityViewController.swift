//
//  CityViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

protocol WeatherDataChangedDelegate : class {
    func didChange(to weatherData:WeatherData)
}

class CityViewController:UIViewController, WeatherDataChangedDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var city:City?
    var apiClient:APIClient!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.fetchData()
        self.cityLabel.text = self.city?.name
        self.dateLabel.text = nil
        self.fetchData()
    }
   
//MARK: WeatherDataChangedDelegate
    
    func didChange(to weatherData:WeatherData) {
        if let date = weatherData.date {
            self.dateLabel.text = self.text(for:date)
        } else {
            self.dateLabel.text = nil
        }
    }

//MARK: Internal
    
    func fetchData() {
        
        guard let city = city else {
            return
        }
        
        apiClient.forecast(byCityId: city.cityId, onCompletion: {[weak self] result, error in
            if let result = result, let data = result.data  {
                self?.setupPagedViewController(with:data)
            }
        })
    }
    
    func setupPagedViewController(with data:[WeatherData]) {
        
        let viewController = WeatherDataPageViewController()
        viewController.model = data
        viewController.apiClient = apiClient
        viewController.pageChangedDelegate = self
        
        let offset = CGFloat(120.0)
        viewController.view.center = CGPoint(x:self.view.center.x, y:self.view.center.y + offset)
        let h = self.view.bounds.size.height - offset
        let w = self.view.bounds.size.width
        viewController.view.bounds = CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width:w, height:h))
        
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func text(for date:Date) -> String {
        
        let response:String
        if Calendar.current.isDateInToday(date) {
            response = "Today"
        } else if Calendar.current.isDateInTomorrow(date) {
            response = "Tomorrow"
        } else {
            response = date.dayOfWeek()
        }
        return response
    }
 
}
