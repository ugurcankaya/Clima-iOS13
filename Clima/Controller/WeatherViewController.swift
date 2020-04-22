//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
}


//MARK: - UITextFieldDelegate

extension WeatherViewController:UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            searchTextField.placeholder = "Type something"
            return false
        }else {
            return true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use searchTextField.text  to get the weather for that city
        if let city = searchTextField.text {
           weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""

    }
   
}
//MARK: - WeatherManagerDelegate
extension WeatherViewController:WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
           print(weather.cityName)
           print(weather.tempString)
           print(weather.conditionName)
           
           DispatchQueue.main.async {
               self.temperatureLabel.text = weather.tempString
               self.cityLabel.text = weather.cityName
               self.conditionImageView.image = UIImage(systemName: weather.conditionName)

           }
           
           
       }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

