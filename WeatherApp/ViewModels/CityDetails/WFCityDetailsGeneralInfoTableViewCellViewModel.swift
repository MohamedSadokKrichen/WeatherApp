//
//  WFCityDetailsGeneralInfoTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 10/03/2023.
//

import UIKit


class WFCityDetailsGeneralInfoTableViewCellViewModel {
    public let iconImageView: String
    public let title: String
    public let description: String
    private let degree: String
    
    init(iconImageView: String, title: String, description: String, degree: String) {
        self.iconImageView = iconImageView
        self.title = title
        self.description = description
        self.degree = degree
    }
    
    public var degreeString: String {
        return "\(degree)°C"
    }
    
}
