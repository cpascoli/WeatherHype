//
//  CityViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

typealias LocationResponse = (City, NSError?) -> Void

protocol WeatherDataChangedDelegate : class {
    func didChange(to weatherData:WeatherData)
}

protocol CityHandler : class {
    func handleCity(city:String) -> Void
}


class CityViewController: UIViewController, WeatherDataChangedDelegate, NVActivityIndicatorViewable, CityHandler {


    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var city:City?  {
        didSet {
            if let city = city {
                self.cityLabel.text = city.name
            }
        }
    }
    
    var apiClient:APIClient!
    var contentViewContoller:WeatherDataPageViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.cityLabel.text = self.city?.name
        self.dateLabel.text = nil
 
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        //self.view.addGestureRecognizer(tapGestureRecognizer)
        self.cityLabel.isUserInteractionEnabled = true
        self.cityLabel.addGestureRecognizer(tapGestureRecognizer)
        
        findCity(name:self.city?.name)
    }


    func findCity(name:String?) {
        
        self.findCityToDisplay(city:name, onCompletion:{[weak self] city, error in
            self?.city = city
            self?.apiClient.forecast(byCityId: city.cityId, onCompletion: {[weak self] result, error in
                if let result = result, let data = result.data  {
                    self?.setupPagedViewController(with:data)
                   
                }
                
                 self?.stopAnimating()
            })
        })
    }


    func findCityToDisplay(city:String?, onCompletion:@escaping LocationResponse) {
        
        self.startAnimating(message:"loading ...".localized, type:.ballScaleRipple, color:UIColor.white, padding:CGFloat(5.0))

        // Defaut city
        var query =  apiClient.config?.value(forKey: "DefaultCity") as! String
        if let city = city {
            query = city
        }
        
        self.apiClient.find(query: query, onCompletion: {results, error in
            let city = results?.results.first
            if let city = city {
                onCompletion(city, nil)
            }
        })
    }


//MARK: CityHandler
    func handleCity(city name: String) {
         findCity(name:name)
    }
    
//MARK: WeatherDataChangedDelegate
    
    func didChange(to weatherData:WeatherData) {
        if let date = weatherData.date {
            self.dateLabel.text = self.text(for:date)
            self.view.backgroundColor = weatherData.weatherStatus!.color()
        } else {
            self.dateLabel.text = nil
        }
    }

//MARK: Internal
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            // handling code
            print("cityLabelTapped")
            let cityFormViewController = UIStoryboard(name: "Main", bundle: Bundle(for:type(of:self))).instantiateViewController(withIdentifier: "CityForm") as! CityFormViewController
            
            cityFormViewController.delegate = self
            self.present(cityFormViewController, animated:true)
        }
    }
    


    

    
    func setupPagedViewController(with data:[WeatherData]) {
        
        if let contentViewContoller = self.contentViewContoller  {
            contentViewContoller.model = data
           
        } else {
        
            let contentViewContoller = WeatherDataPageViewController()
            
            contentViewContoller.apiClient = apiClient
            contentViewContoller.model = data
            contentViewContoller.pageChangedDelegate = self

            contentViewContoller.view.frame = CGRect(x: 0, y: 0, width:
                contentView.bounds.width, height: contentView.bounds.height)
            
            self.addChildViewController(contentViewContoller)
            self.contentView.addSubview(contentViewContoller.view)
            contentViewContoller.didMove(toParentViewController: self)
            
            self.contentViewContoller = contentViewContoller
            
           
        }


    
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
