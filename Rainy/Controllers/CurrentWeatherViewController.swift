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


class CurrentWeatherViewController: BaseWeatherViewController {
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatheImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.insertSubview(refreshControl, at: 0)
        update()
    }
}


// MARK: - Update
extension CurrentWeatherViewController {
    override func updateCurrentForecast() {
        locationManager.requestLocation()
    }

    override func updateUI() {
        locationLabel.text = currentForecast!.location
        
        tempLabel.text = "\(lround(currentForecast!.temperature))"
        rainLabel.text = "\(lround(currentForecast!.rainProbability))"
        windLabel.text = "\(lround(currentForecast!.wind))"
    }
}


// MARK: - CLLocationManagerDelegate
extension CurrentWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError %@", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Get locations")
        if let location = locations.first {
            forecastManager.getCurrentLocationForecast(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        }
    }
}
