//
// Created by Alexander Nelzin on 17/10/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation

class WeatherForecast {
    let currentWeatherTemp: Double?
    let rainProbability: Double?

    let timestamp: Double

    let imageName: String

    let locationCoordinates: (lat: Double, lng: Double)?

    init(
            currentWeatherTemp: Double?, rainProbability: Double?, timestamp: Double,
            imageName: String, locationCoordinates: (Double, Double)?
    ) {
        self.currentWeatherTemp = currentWeatherTemp
        self.rainProbability = rainProbability
        self.timestamp = timestamp
        self.imageName = imageName
        self.locationCoordinates = locationCoordinates
    }


}
