//
//  Cities+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
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

}
