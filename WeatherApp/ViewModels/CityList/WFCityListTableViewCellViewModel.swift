//
//  WFCityListTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import Foundation
import WeatherAPIFramework

class WFCityListTableViewCellViewModel {
    public let cityName : String
    public let imageName : String
    private let cityTemp : Float
    
    init(cityName: String, imageName: String, cityTemp: Float) {
        self.cityName = cityName
        self.imageName = imageName
        self.cityTemp = cityTemp
    }
    
    public var cityTempString : String {
        return "\(Int(cityTemp))°C"
    }
}
