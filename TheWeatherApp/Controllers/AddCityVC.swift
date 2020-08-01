//
//  AddCityVC.swift
//  TheWeatherApp
//
//  Created by KUNAL PARIKH on 29/7/20.
//  Copyright © 2020 KUNAL PARIKH. All rights reserved.
//

import UIKit

protocol AddCityDelegate {
    func addCityName(newCity:String)
}

class AddCityVC: UIViewController {
    
    var city = City()
    var name : String = ""
    @IBOutlet weak var addCitytxt: UITextField!
    var delegate : AddCityDelegate?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnAddCity(_ sender: UIButton) {
        name = addCitytxt.text!
        delegate?.addCityName(newCity: name)
        print(name)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    


    

}
