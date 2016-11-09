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
    var coordinates = Coordinates()
    
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
        locationManager.requestLocation()
    }
}


// MARK: - Update
extension CurrentWeatherViewController {
    override func updateCurrentForecast() {
        forecastManager.getCurrentLocationForecast(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }

    override func updateUI() {
        tempLabel.text = "\(round(currentForecast!.temperature))"
        rainLabel.text = "\(round(currentForecast!.rainProbability))"
    }
}


// MARK: - CLLocationManagerDelegate
extension CurrentWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError %@", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Get locations")
        let currentLocation: CLLocation = locations[0] // TODO: Unsafe
        if (!currentLocation.isEqual(nil)) { // == nil
            coordinates = Coordinates(
                latitude: currentLocation.coordinate.latitude,
                longitude: currentLocation.coordinate.longitude
            )
        }
    }
}
