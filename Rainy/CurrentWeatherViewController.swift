//
//  FirstViewController.swift
//  Rainy
//
//  Created by Alexander Nelzin on 17/10/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

import Alamofire


class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate {

    var coordinates = Coordinates()

    var locationManager = CLLocationManager()

    var currentForecast: WeatherForecast? {
        didSet {
            reloadUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Update

extension CurrentWeatherViewController {
    func updateCurrentForecast() -> WeatherForecast? {
        let URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&APPID=\(Constants.apiKey)"

        Alamofire.request(URL).responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        return nil
    }
}

// MARK: - UI

extension CurrentWeatherViewController {
    func reloadUI() {

    }
}

// MARK: Location delegate

extension CurrentWeatherViewController {
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
            currentForecast = updateCurrentForecast()
        }
        locationManager.stopUpdatingLocation()
    }
}
