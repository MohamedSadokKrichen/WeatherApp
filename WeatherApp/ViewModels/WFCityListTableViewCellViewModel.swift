//
//  WFCityListTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import Foundation

class WFCityListTableViewCellViewModel {
    public let cityName : String
    private let cityTemp : Float
    
    init(cityName: String, cityTemp: Float) {
        self.cityName = cityName
        self.cityTemp = cityTemp
    }
    
    public var cityTempString : String {
        return "\(cityTemp) °C"
    }
}
