//
//  WFCityDetailsSpecificCollectionViewCellViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 10/03/2023.
//

import Foundation


class WFCityDetailsSpecificCollectionViewCellViewModel {
    
    private let value: String
    
    private let type: `Type`
    
    public var title: String {
        self.type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty {
            return "None"
        }
        switch type {
            case .feelLike: return "\(value)°C"
            case .tempMin: return "\(value)°C"
            case .tempMax: return "\(value)°C"
            case .pressure: return value
            case .humidity: return "\(value)%"
            case .wind: return "\(value)Km/H"
        }
    }
    
    enum `Type`: String{
        case feelLike
        case tempMin
        case tempMax
        case pressure
        case humidity
        case wind
        
        var displayTitle: String {
            switch self {
                case .feelLike: return "Feels Like"
                case .tempMin: return "Min Temperature"
                case .tempMax: return "Max Temperature"
                case .pressure: return "Pressure"
                case .humidity: return "Humidity"
                case .wind: return "Wind Speed"
            }
        }
    }
    
    init(value: String, type: `Type`) {
        self.value = value
        self.type = type
    }
}
