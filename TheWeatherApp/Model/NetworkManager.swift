//
//  NetworkManager.swift
//  TheWeatherApp
//
//  Created by KUNAL PARIKH on 16/7/20.
//  Copyright © 2020 KUNAL PARIKH. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol NetworkManagerDelegate {
    func didUpdateWeather(weather:WeatherModel)
}


struct NetworkManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3a40d0a31837c418695e230c18a3c4cf&units=metric&"
    
    
    //this is required when we need to make the class/Struct an delegate
    var delegate: NetworkManagerDelegate?
    
    mutating func fetchWeather(cityName:String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //        print(urlString)
        performRequest(with: urlString)
    }
    
    
    mutating func fetchWeather(latitude: CLLocationDegrees, longitude:CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    //MARK:- Networking
    func performRequest(with urlString : String) {
        //1.Create a URL
        if let url = URL(string: urlString){
            //2. create a URL Session
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    print("\(String(describing: error)) in NetworkManager line 33")
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData) {
                        //we are transfering data via the delegate pattern
                        self.delegate?.didUpdateWeather(weather:weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let deCodedData =  try decoder.decode(WeatherData.self, from: weatherData) //here we are basically creating an object of type WeatherData
            let id = deCodedData.weather[0].id
            let temp = deCodedData.main.temp
            let name = deCodedData.name
            
            //Below we are creating an weather object from our data model
            let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
            return weather
            
        } catch  {
            print("\(Error.self) on NetworkManager line 80")
            return nil
        }
        
    }
}
