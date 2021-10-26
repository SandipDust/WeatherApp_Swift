//
//  WeatherData.swift
//  Weather App
//
//  Created by Sandip Das on 25/10/21.
//

// To decode the JSON!

import UIKit

struct WeatherData: Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: Double
    let humidity: Int
    
}

struct Weather: Decodable{
    let description: String
}
