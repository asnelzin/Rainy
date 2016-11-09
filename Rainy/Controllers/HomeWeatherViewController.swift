//
//  SecondViewController.swift
//  Rainy
//
//  Created by Alexander Nelzin on 17/10/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import UIKit


class HomeWeatherViewController: BaseWeatherViewController {
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
extension HomeWeatherViewController {
    override func updateCurrentForecast() {
        forecastManager.getHomeForecast(from: "Saint Petersburg")
    }
    
    override func updateUI() {
        locationLabel.text = currentForecast!.location
        
        tempLabel.text = "\(round(currentForecast!.temperature))"
        rainLabel.text = "\(round(currentForecast!.rainProbability))"
        windLabel.text = "\(round(currentForecast!.wind))"
    }
}
