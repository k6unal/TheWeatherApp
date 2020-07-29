//
//  WeatherModel.swift
//  TheWeatherApp
//
//  Created by KUNAL PARIKH on 23/7/20.
//  Copyright © 2020 KUNAL PARIKH. All rights reserved.
//

import Foundation

struct WeatherModel:Codable {
    
    let conditionId : Int
    let temperature : Double
    let cityName : String
    
    var conditionName:String{
        switch conditionId {
        case 200...232:
            return "cloud.sun.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
            
        default:
            return "cloud"
        }
        
    }
    
    var tempString : String{
        return String(format: "%.1f", temperature)
    }
    
    
    
    
    
}
