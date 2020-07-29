//
//  WeatherData.swift
//  TheWeatherApp
//
//  Created by KUNAL PARIKH on 23/7/20.
//  Copyright © 2020 KUNAL PARIKH. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    
    let main : Main
    let name : String
    let weather : [Weather]
}

struct Main:Codable {
    let temp: Double
    
}

//weather[0].id
//https://openweathermap.org/weather-conditions
struct Weather : Codable {
    let id : Int
    

    
}


