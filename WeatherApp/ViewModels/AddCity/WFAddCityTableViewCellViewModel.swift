//
//  WFAddCityTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 09/03/2023.
//

import Foundation

class WFAddCityTableViewCellViewModel {
    
    private let cityName : String
    private let cityCountryName: String
    
    public var countryCityString : String {
        return "\(cityName), \(cityCountryName)"
    }
    
    init(cityName: String, cityCountryName: String) {
        self.cityName = cityName
        self.cityCountryName = cityCountryName
    }
}
