//
//  CityFormViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 07/10/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class CityFormViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cityTextField: UITextField!
    
    weak var delegate:CityHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func dismiss(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let delegate = self.delegate,
           let city = textField.text{
            delegate.handleCity(city:city)
        }
        textField.resignFirstResponder()
        self.dismiss(textField)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        print("textFieldDidEndEditing:", textField.text)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:", textField.text)
        
        return true
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
