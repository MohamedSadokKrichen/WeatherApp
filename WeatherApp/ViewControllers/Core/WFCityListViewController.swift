//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import UIKit

import WeatherAPIFramework

class WFCityListViewController: UIViewController {
    
    private let wfCityListView = WFCityListView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 122.0/255.0, green: 207.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        title = "Cities"
        
        view.addSubview(wfCityListView)
        NSLayoutConstraint.activate([
            wfCityListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wfCityListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            wfCityListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            wfCityListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
    }


}

