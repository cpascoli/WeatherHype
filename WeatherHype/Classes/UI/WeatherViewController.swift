//
//  WeatherViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    var model:WeatherData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView() {
    
        if let value =  model.maxTemperature {
            maxTemperatureLabel.text = String(describing:value)
        }
        if let value =  model.minTemperature {
            minTemperatureLabel.text = String(describing:value)
        }
        if let value =  model.humidity {
            humidityLabel.text = String(describing:value)
        }
        if let value =  model.pressure {
            pressureLabel.text = String(describing:value)
        }
        if let value =  model.wind {
            windLabel.text = String(describing:value)
        }
        if let value =  model.weatherDescription {
            descriptionLabel.text = String(describing:value)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}




