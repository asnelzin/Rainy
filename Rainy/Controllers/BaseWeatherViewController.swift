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

    var currentForecast: WeatherForecast?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        return refreshControl
    }()

    lazy var forecastManager: OpenWeatherMapForecastManager = {
        let forecastManager = OpenWeatherMapForecastManager()
        forecastManager.delegate = self
        return forecastManager
    }()
    
    override func viewDidLoad() {
        update()
    }
}


// MARK: - Update
extension BaseWeatherViewController {
    func update() {
        defer {
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
        updateCurrentForecast()
    }
    
    func updateCurrentForecast() {
        print("Subclass has not implemented abstract method `updateCurrentForecast`!")
        abort()
    }
    
    func updateUI() {
        print("Subclass has not implemented abstract method `updateUI`!")
        abort()
    }
}


// MARK: - OpenWeatherMapForecastDelegate
extension BaseWeatherViewController: OpenWeatherMapForecastDelegate {
    func didUpdateForecast(_ manager: OpenWeatherMapForecastManager, forecast: WeatherForecast?) {
        if (forecast != nil) {
            currentForecast = forecast
            updateUI()
        }
    }
}
