//
//  CityTableViewController.swift
//  TheWeatherApp
//
//  Created by KUNAL PARIKH on 16/7/20.
//  Copyright © 2020 KUNAL PARIKH. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController,AddCityDelegate {
    
    
   
    
    var city = City()
    
    var defaults = UserDefaults.standard
    var newCity : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        city.cityArray = ["Sydney","New York","Melbourne","Vadodara"]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.darkGray
        
        //Right bar button item
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
        //Left bar button item
        let addBarButton = UIBarButtonItem(title: "Add City", style: .done, target: self, action: #selector(addCity) )
        self.navigationItem.leftBarButtonItem = addBarButton
        
        
        //Loding User defaults in tableView
        if let items = defaults.array(forKey: "cityArray") as? [String]{
            city.cityArray = items
        }
        
             
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return city.cityArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = city.cityArray[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            city.cityArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            defaults.set(city.cityArray, forKey: "cityArray")
            tableView.reloadData()
            
            
        }    
    }
     
    //Action for left bar button item
    @IBAction func addCity(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cityVC = storyboard.instantiateViewController(identifier: "AddCityVC") as! AddCityVC
        self.navigationController?.pushViewController(cityVC, animated: true)
        cityVC.delegate = self
    }
    
    
    //Adding the city name to the array
    func addCityName(newCity: String) {
        city.cityArray.append(newCity)
        defaults.set(city.cityArray, forKey: "cityArray")
        print(city.cityArray)
        tableView.reloadData()
    }
    
}

