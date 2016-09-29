//
//  APIClient.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 27/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias SearchResultsResponse = (SearchResults?, NSError?) -> Void
typealias ForecastResultsResponse = (ForecastResults?, NSError?) -> Void
typealias ImageResponse = (UIImage?, NSError?) -> Void
typealias ServiceResponse = (JSON, NSError?) -> Void


class APIClient: NSObject {

    var session = URLSession(configuration:URLSessionConfiguration.default)
    var config:NSDictionary?
    
    override init() {
        super.init()
        config = configDict()
    }
    
    
//MARK: API Services
    
    /*
     * Find cities
     * api.openweathermap.org/data/2.5/find?q={query}&type=like
     */
    func find(query:String, onCompletion:@escaping SearchResultsResponse) {
       
        let queryEscaped = query.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        let path = "find?q="+queryEscaped!+"&type=like"
        let request = fetchRequest(for:path)
        
        executeJSON(request: request, handler: { json, error -> Void in
            let transformer = SearchResultsTransformer()
            let searchResults = transformer.parse(json: json)
            DispatchQueue.main.async(execute:{
                onCompletion(searchResults, error)
            })
        })
    }
    
    
    /* Forecast - 5 days weather forecast
       api.openweathermap.org/data/2.5/forecast?id={city ID}
     */
    func forecast(byCityId cityId:String, onCompletion:@escaping ForecastResultsResponse) {
        
        let path = "forecast?id="+cityId
        let request = fetchRequest(for:path)
        
        executeJSON(request: request, handler: { json, error -> Void in
            let transformer = ForecastResultsTransformer()
            let searchResults = transformer.parse(json: json)
            DispatchQueue.main.async(execute:{
               onCompletion(searchResults, error)
            })
        })
    }
    
    /*
     * Get the weather thumbnail from api.openweathermap.org
    */
    func downloadImage(name:String, onCompletion:@escaping ImageResponse) {
    
        var request:URLRequest?
        let urlstring:String = imageUrlString(with:name, configDict:self.config!)
        
        let url = URL(string:urlstring)
        if let url = url {
            request = URLRequest(url:url)
            request?.httpMethod = "GET"
            request?.setValue("Content-type: image/png", forHTTPHeaderField: "Accept")
        }
        executeImage(request: request, handler: { image, error -> Void in
            DispatchQueue.main.async(execute:{
                onCompletion(image, error)
            })
        })
    }
    

//MARK: private

    func configDict() -> NSDictionary? {
        var configDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            configDict = NSDictionary(contentsOfFile: path)
        }
        return configDict
    }

    func fetchRequest(for path:String) -> URLRequest? {
        
        var request:URLRequest?
        let urlstring:String = urlString(with:path, configDict:self.config!)
        let url = URL(string:urlstring)
        if let url = url {
            request = URLRequest(url:url)
            request?.httpMethod = "GET"
            request?.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        return request
    }
    
    func urlString(with path:String, configDict:NSDictionary) -> String {
    
        let appId = configDict.object(forKey: "AppID") as! String
        let baseURL = configDict.object(forKey: "BaseURL") as! String
        let units = configDict.object(forKey: "Units") as! String
        let urlString = baseURL + "/" + path + "&appid=" + appId + "&units=" + units
        return urlString
    }
    
    func imageUrlString(with name:String, configDict:NSDictionary) -> String {
        
        let baseURL = configDict.object(forKey: "ImageURL") as! String
        let urlString = baseURL + "/img/w/"+name+".png"
        return urlString
    }
    
    func executeJSON(request:URLRequest?, handler:@escaping ServiceResponse) {
        
        if let request = request {
            print("execute - url:", request.url)
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
                guard let data = data, error == nil else {
                    handler(nil, error as NSError?)
                    return
                }
                let json = JSON(data:data)
                handler(json, error as NSError?)
            })
            task.resume()
        }
    }
    
    func executeImage(request:URLRequest?, handler:@escaping ImageResponse) {
        
        if let request = request {
            print("execute - url:", request.url)
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                guard let data = data, error == nil else {
                    handler(nil, error as NSError?)
                    return
                }
                let image = UIImage(data: data)
                handler(image, nil)
            })
            task.resume()
        }
    }
    
}
