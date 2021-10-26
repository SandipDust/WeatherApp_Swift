//WeatherModel.swift
//  Weather App
//
//  Created by Sandip Das on 26/10/21.
//

import Foundation

struct WeatherModel{
    let cityName: String
    let temp: Double
    let description: String
    let humidity: Int
    
    var temperatureString: String{
        return String(format: "%.1f", temp)
    }
}
