//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Modified by Abhisheka G on 12/04/2020
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    
    
    let locationManager = CLLocationManager()
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    //2a606af71fdc8a010be2a177096c2d3f

    

    let weatherModel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Setting up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getWeatherData(url : String, params : [String : String]){
        AF.request(url,method: .get,parameters: params).responseJSON { response in
            print(response)
             switch response.result {
                   case .success:
                       print("Validation Successful ",response)
                       let weatherJson: JSON = JSON(response.value)
                       self.updateWeatherData(json: weatherJson)
                   case let .failure(error):
                       print(error)
                       self.cityLabel.text = "Connection issue"
                   }
        }
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    func updateWeatherData(json : JSON){
            if let temp = json["main"]["temp"].double{
        weatherModel.temperature = Int(temp - 273.15)
        weatherModel.city = json["name"].stringValue
        weatherModel.condition = json["weather"][0]["id"].intValue
        weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
                updateUIWithWeatherData()
            }
        else{
                cityLabel.text = "Unable to fetch weather information"
        }
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    func updateUIWithWeatherData(){
        cityLabel.text = weatherModel.city
        temperatureLabel.text = String(weatherModel.temperature)+"°"
        weatherIcon.image = UIImage(named: weatherModel.weatherIconName)
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("lon = \(location.coordinate.longitude), lat = \(location.coordinate.latitude)")
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat":lat, "lon":lon, "appid" : APP_ID]
        
            getWeatherData(url: WEATHER_URL, params: params)

        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    func userEnteredANewCityName(cityName: String) {
        let params : [String : String ] = ["q":cityName,"appid":APP_ID]
        getWeatherData(url: WEATHER_URL, params: params)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
           let destVC =  segue.destination as! ChangeCityViewController
            destVC.delegate = self
        }
    }
    
    
    
    
}


