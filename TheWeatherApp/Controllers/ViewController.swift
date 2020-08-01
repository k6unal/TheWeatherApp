//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by KUNAL PARIKH on 16/7/20.
//  Copyright © 2020 KUNAL PARIKH. All rights reserved.
//

import UIKit
import SideMenu
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, NetworkManagerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    
    var menu : SideMenuNavigationController?
    var weatherManager = NetworkManager()
    var locationManager = CLLocationManager()
    var newCity : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        menu = SideMenuNavigationController.init(rootViewController: CityTableViewController())
        menu?.leftSide = true
        
        
//        menu?.setNavigationBarHidden(true, animated: false)
        
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view  )
        
    }
    
    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
        
        present(menu!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
        
    }
    
    func didUpdateWeather(weather:WeatherModel) {
        //        print(weather.temperature)
        DispatchQueue.main.async {
            self.cityNameLabel.text = weather.cityName
            self.tempLabel.text = weather.tempString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    
    //MARK:- LocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude:lat, longitude:lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error, "Error in ViewController line 75")
    }
    
    
}
