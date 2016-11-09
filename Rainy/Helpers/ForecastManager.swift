//
//  RequestManager.swift
//  Rainy
//
//  Created by Alexander Nelzin on 08/11/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON


enum OpenWeatherMapGetRouter: URLRequestConvertible {
    static let path = "http://api.openweathermap.org/data/2.5/weather"
    
    case GetWithCoordinates(Double, Double)
    case GetWithLocation(String)
    
    var params: Parameters {
        switch self {
        case .GetWithCoordinates(let lat, let lon):
            return ["lat": lat, "lon": lon, "appid": Constants.apiKey, "units": "metric"]
        case .GetWithLocation(let location):
            return ["q": location, "appid": Constants.apiKey, "units": "metric"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: OpenWeatherMapGetRouter.path)!
        let urlRequest = URLRequest(url: url)
        
        return try URLEncoding.queryString.encode(urlRequest, with: params)
    }
}


protocol OpenWeatherMapForecastDelegate: class {
    func didUpdateForecast(_ manager: OpenWeatherMapForecastManager, forecast: WeatherForecast?)
}


class OpenWeatherMapForecastManager {
    weak var delegate: OpenWeatherMapForecastDelegate?
    
    func getCurrentLocationForecast(latitude: Double, longitude: Double) {
        makeRequest(requestType: .GetWithCoordinates(latitude, longitude)) { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("Error calling API method!")
                print(response.result.error!)
                return
            }
            
            let responseJSON = JSON(response.result.value)
            print(responseJSON)
            
            let temp = responseJSON["main"]["temp"].double!
            
            var rainProbability: Double?
            if let rainDict = responseJSON["rain"].dictionary {
                rainProbability = rainDict["3h"]?.double
            } else {
                rainProbability = -1
            }
            let location = responseJSON["name"].string!
            let wind = responseJSON["wind"]["speed"].double!
            let weatherForecast = WeatherForecast(temperature: temp, rainProbability: rainProbability!, location: location, wind: wind)
            self.delegate?.didUpdateForecast(self, forecast: weatherForecast)
        }
    }
    
    func getHomeForecast(from: String) {
        makeRequest(requestType: .GetWithLocation(from)) { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("Error calling API method!")
                print(response.result.error!)
                return
            }
            
            let responseJSON = JSON(response.result.value)
            print(responseJSON)
            
            let temp = responseJSON["main"]["temp"].double!
            
            var rainProbability: Double?
            if let rainDict = responseJSON["rain"].dictionary {
                rainProbability = rainDict["3h"]?.double
            } else {
                rainProbability = -1
            }
            let location = responseJSON["name"].string!
            let wind = responseJSON["wind"]["speed"].double!
            let weatherForecast = WeatherForecast(temperature: temp, rainProbability: rainProbability!, location: location, wind: wind)
            self.delegate?.didUpdateForecast(self, forecast: weatherForecast)
        }
    }
    
    private func makeRequest(requestType: OpenWeatherMapGetRouter, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire
            .request(requestType)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: completionHandler)
    }
}
