//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import UIKit

import WeatherAPIFramework

class WFCityListViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherApiCalls.shared.getWeatherInfo(for: "Paris") { result in
            switch result {
            case .success(let success):
                print(success.weather?.first?.description ?? "")
            case .failure(let failure):
                print(failure)
            }
        }
    }


}

