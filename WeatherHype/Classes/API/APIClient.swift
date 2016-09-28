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


typealias SimpleServiceResponse = (String?, NSError?) -> Void
typealias ServiceResponse = (JSON, NSError?) -> Void

class APIClient: NSObject {

    var session = URLSession(configuration:URLSessionConfiguration.default)
    var config:NSDictionary?
    
    override init() {
        super.init()
        config = configDict()
    }
    
    
//MARK: API Services
    
    /* Current Weather
     api.openweathermap.org/data/2.5/weather?id={city ID}
     */
//    func weather(byCityId cityId:String, onCompletion:@escaping ServiceResponse) {
//        
//        let path = "weather?id="+cityId
//        let request = fetchRequest(for:path)
//        execute(request: request, onCompletion:onCompletion)
//    }
    
    /* Forecast - 5 days weather forecast
       api.openweathermap.org/data/2.5/forecast?id={city ID}
     */
    func forecast(byCityId cityId:String, onCompletion:@escaping ForecastResultsResponse) {
        
        let path = "forecast?id="+cityId
        let request = fetchRequest(for:path)
        
        execute(request: request, handler: { json, error -> Void in
            let transformer = ForecastResultsTransformer()
            let searchResults = transformer.parse(json: json)
            DispatchQueue.main.async(execute:{
               onCompletion(searchResults, error)
            })
        })
        
    }
    

    /* 
     * Find cities
     * api.openweathermap.org/data/2.5/find?q={query}&type=like
     */
    func search(query:String, onCompletion:@escaping SearchResultsResponse) {
        
        let path = "find?q="+query+"&type=like"
        let request = fetchRequest(for:path)
       
        execute(request: request, handler: { json, error -> Void in
            let transformer = SearchResultsTransformer()
            let searchResults = transformer.parse(json: json)
            onCompletion(searchResults, error)
        })
    }
    
    
//    func testSearchRequest() {
//
//        apiClient?.search(query: "Lond", onCompletion: {json, error -> Void in
//            print(json)
//            theExpectation.fulfill()
//        })
//        
//        // 2s timeout
//        waitForExpectations(timeout: 2000, handler: { error in
//            XCTAssertNil(error, "Oh, weather request timeout")
//        })
//    }
    
    
    
//MARK: private

    //TODO test
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
    
    func execute(request:URLRequest?, handler:@escaping ServiceResponse) {
        
        if let request = request {
            print("execute - url:", request.url)
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                let json = JSON(data:data!)
                handler(json, error as NSError?)
            })
            task.resume()
        }
    }
    
}
