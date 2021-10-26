//
//  ViewController.swift
//  Weather App
//  Created by Sandip Das on 25/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    let textField = UITextField()
    let cityName = UILabel()
    let temperature = UILabel()
    let humidity = UILabel()
    let conditions = UILabel()
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 255/255.0, green: 218/255.0, blue: 121/255.0, alpha: 1)
      
        weatherManager.delegate = self
        
        configureTextField()
        configureCityName()
        configureTemperatureLabel()
        configureDescriptionLabel()
        
        addConstraints()
        
    }
    
    func configureTextField(){
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 204/255.0, green: 174/255.0, blue: 98/255.0, alpha: 1)
        textField.placeholder = "🔍 Search"
        textField.tintColor = .white
        textField.delegate = self
    }
    
    func configureCityName(){
        view.addSubview(cityName)
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.text = ""
        cityName.textAlignment = .center
        cityName.font = UIFont.systemFont(ofSize: 30)
    }
    
    func configureDescriptionLabel(){
        view.addSubview(conditions)
        conditions.translatesAutoresizingMaskIntoConstraints = false
        conditions.text = ""
        conditions.textAlignment = .center
        conditions.font = UIFont.systemFont(ofSize: 20)
    }
    
    func configureTemperatureLabel(){
        view.addSubview(temperature)
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.text = ""
        temperature.textAlignment = .center
        temperature.font = UIFont.systemFont(ofSize: 70)
    }
    
    
    func addConstraints(){
        var constraint = [NSLayoutConstraint]()

        constraint.append(textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraint.append((textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)))
        constraint.append((textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)))
        constraint.append(textField.heightAnchor.constraint(equalToConstant: 50))
        
        
        constraint.append(cityName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraint.append(cityName.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor))
        constraint.append(cityName.heightAnchor.constraint(equalToConstant: 50))
        
        constraint.append(temperature.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraint.append(temperature.bottomAnchor.constraint(equalTo: cityName.topAnchor, constant: -20))
        
        constraint.append(conditions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraint.append(conditions.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 20))
        
       
        NSLayoutConstraint.activate(constraint)

}
    
}


extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel){
        cityName.text = weather.cityName
        temperature.text = "\(weather.temperatureString) °C"
        print(weather.temperatureString)
        print(weather.humidity)
        conditions.text = weather.description
    }
}




extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.sendRequest(cityName: textField.text!)
        textField.text = ""
        
    }
}




