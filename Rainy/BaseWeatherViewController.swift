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
    
    var locationManager = CLLocationManager()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        setupRefreshControl()
    }
}

// MARK: - Update
extension BaseWeatherViewController {
    func updateCurrentForecast() {
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
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError %@", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[0]
        if (!currentLocation.isEqual(nil)) {
            coordinates = Coordinates(
                latitude: currentLocation.coordinate.latitude,
                longitude: currentLocation.coordinate.longitude
            )
            updateCurrentForecast()
        }
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - UIRefreshControl
extension BaseWeatherViewController {
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(updateCurrentForecast), for: .valueChanged)
    }
}
