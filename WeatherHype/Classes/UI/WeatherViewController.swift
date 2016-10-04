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
    var apiClient:APIClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = nil;
        updateView()
    }

    //MARK: internal
    
    func updateView() {
    
        if let weatherStatus = model.weatherStatus {
            self.view.backgroundColor = weatherStatus.color()
        }
        if let value = model.maxTemperature {
            maxTemperatureLabel.text = formatTemp(value)
        }
        if let minalue = model.minTemperature, let maxvalue = model.maxTemperature {
            if minalue !=  maxvalue {
                minTemperatureLabel.text = formatTemp(minalue)
            } else {
                 minTemperatureLabel.text = nil
            }
        }
        if let value = model.humidity {
            humidityLabel.text = formatHumidity(value)
        }
        if let value = model.pressure {
            pressureLabel.text = formatPressure(value)
        }
        if let value = model.wind {
            windLabel.text = formatWind(value)
        }
        if let value = model.weatherDescription {
            descriptionLabel.text = String(describing:value)
        }
        if let value = model.icon {
            self.downloadImage(name:value)
        }
    }
    
    func downloadImage(name:String) {
        self.apiClient.downloadImage(name: name, onCompletion: { image, error in
            self.imageView.image = image
        })
    }
    
    
    //MARK: Data formatting
    
    func formatTemp(_ value:NSNumber) -> String {
        let rounded = Int(round(Double(value)))
        let formetted = "\(rounded)°"
        return formetted
    }
    
    func formatHumidity(_ value:NSNumber) -> String {
        let rounded = Int(round(Double(value)))
        let formetted = "\(rounded)%"
        return formetted
    }
    
    func formatWind(_ value:NSNumber) -> String {
        let rounded = Int(round(toKmH(Double(value))))
        let formetted = "\(rounded) km/hr"
        return formetted
    }
    
    func formatPressure(_ value:NSNumber) -> String {
        let rounded = Int(round(Double(value)))
        let formetted = "\(rounded) hPa"
        return formetted
    }
    
    func toKmH(_ ms:Double) -> Double {
        let kmh = ms * 3600.0 / 1000.0
        return kmh
    }
}



