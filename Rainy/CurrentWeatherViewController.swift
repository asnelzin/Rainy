//
//  FirstViewController.swift
//  Rainy
//
//  Created by Alexander Nelzin on 17/10/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    var currentForecast: WeatherForecast? {
        didSet {
            reloadUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentForecast = updateCurrentForecast()
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
        // ... MAGIC
        return nil
    }
}

// MARK: - UI
extension CurrentWeatherViewController {
    func reloadUI() {

    }
}