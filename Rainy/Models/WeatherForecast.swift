//
// Created by Alexander Nelzin on 17/10/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation
import UIKit


class WeatherForecast {
    let location: String
    let image: UIImage
    
    let temperature: Double
    let rainProbability: Double
    let wind: Double

    init(location: String, description: String, temperature: Double, rainProbability: Double, wind: Double) {
        self.location = location

        self.temperature = temperature
        self.rainProbability = rainProbability
        self.wind = wind

        switch description {
        case "clear sky":
            self.image = #imageLiteral(resourceName: "sunny")
        case "few clouds", "scattered clouds", "broken clouds", "overcast clouds", "mist":
            self.image = #imageLiteral(resourceName: "cloudy")
        case "shower rain", "rain", "thunderstorm":
            self.image = #imageLiteral(resourceName: "rain")
        case "snow":
            self.image = #imageLiteral(resourceName: "snow")
        default:
            self.image = #imageLiteral(resourceName: "sunny")
            break
        }
    }
}
