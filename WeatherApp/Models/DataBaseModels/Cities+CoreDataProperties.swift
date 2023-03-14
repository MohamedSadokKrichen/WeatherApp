//
//  Cities+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 13/03/2023.
//
//

import Foundation
import CoreData


extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var lastTemp: Double
    @NSManaged public var lastUpdate: String?
    @NSManaged public var iconName: String?
    @NSManaged public var main: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var feelsLike: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var tempMax: Double
    @NSManaged public var pressure: Int32
    @NSManaged public var humidity: Double
    @NSManaged public var windSpeed: Double

}
