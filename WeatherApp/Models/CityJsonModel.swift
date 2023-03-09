//
//  CityJsonModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 9/3/2023.
//

import Foundation

// MARK: - CityJSON
struct CityJSON: Codable {
    let id: Int?
    let name, state, country: String?
    let coord: Coord?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}
