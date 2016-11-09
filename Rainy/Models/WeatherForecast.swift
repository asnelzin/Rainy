//
// Created by Alexander Nelzin on 17/10/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation


struct Coordinates {
    var latitude = 0.0
    var longitude = 0.0
}


class WeatherForecast {
    let temperature: Double
    let rainProbability: Double

    init(temperature: Double, rainProbability: Double) {
        self.temperature = temperature
        self.rainProbability = rainProbability
    }
}
