//
//  WeatherManager.swift
//  Weather App
//
//  Created by Sandip Das on 25/10/21.
//

import UIKit
import Alamofire

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
}

class WeatherManager {
    var delegate: WeatherManagerDelegate?
    
    func sendRequest(cityName: String){
        let endURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric"
        
        //Manual validation and requesting
        AF.request(endURL, method: .get).validate()
            .responseData { response in
            switch response.result {
            
                case .success(let data):
                    if let safedata = jsonParser(data: data){
                        self.delegate?.didUpdateWeather(weather: safedata)
                    }
                    
                case .failure(let error):
                    print(error)
            }
                
                
        //Decoding the JSON
        func jsonParser(data: Data) -> WeatherModel?{
            do {
                let decoder = JSONDecoder()
                let info = try decoder.decode(WeatherData.self, from: data)
                let name = info.name
                let temp = info.main.temp
                let desc = info.weather[0].description
                let humidity = info.main.humidity
                
                let weather = WeatherModel(cityName: name, temp: temp, description: desc,humidity: humidity)
                return weather
                
               } catch {
                   print(error)
                return nil
               }
            }
    
        }
        
    }
}
