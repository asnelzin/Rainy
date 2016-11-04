//
//  BaseWeatherViewController.swift
//  Rainy
//
//  Created by Alexander Nelzin on 19/10/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

import Alamofire


class BaseWeatherViewController: UIViewController {
    var coordinates = Coordinates()
    var currentForecast: WeatherForecast?
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        return locationManager
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateCurrentForecast), for: .valueChanged)
        return refreshControl
    }()
}

// MARK: - Update
extension BaseWeatherViewController {
    func updateCurrentForecast() {
        print("Updating...")
        let URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&APPID=\(Constants.apiKey)"
        
        Alamofire.request(URL).responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        refreshControl.endRefreshing()
    }
}

// MARK: - CLLocationManagerDelegate
extension BaseWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError %@", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Get locations")
        let currentLocation: CLLocation = locations[0] // Unsafe
        if (!currentLocation.isEqual(nil)) { // == nil
            coordinates = Coordinates(
                latitude: currentLocation.coordinate.latitude,
                longitude: currentLocation.coordinate.longitude
            )
        }
    }
}
