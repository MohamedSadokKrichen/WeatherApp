//
//  WFCityDetailsViewController.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 10/03/2023.
//

import UIKit

class WFCityDetailsViewController: UIViewController {

    private var wfCityDetailsView = WFCityDetailsView()
    public var city = Cities()
    override func viewDidLoad() {
        super.viewDidLoad()
        wfCityDetailsView = WFCityDetailsView(city: city)
        view.addSubview(wfCityDetailsView)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            wfCityDetailsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            wfCityDetailsView.heightAnchor.constraint(equalTo: view.heightAnchor),
            wfCityDetailsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            wfCityDetailsView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }

}
