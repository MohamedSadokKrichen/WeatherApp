//
//  CityDBManger.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit
import CoreData


final class CityDBManager {
    public static let shared = CityDBManager()
    
    public func saveNewCity(with name: String) {
        let city = Cities()
        city.cityName = name
        city.lastTemp = 0.0
        let context = getManagedObjectContext()
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Cities", in: context) else { return }
        let newCity = NSManagedObject(entity: entityDescription, insertInto: context)
        newCity.setValue(name, forKey: "cityName")
        newCity.setValue(0.0, forKey: "lastTemp")
        do {
            try context.save()
        } catch {
            print("ERROR Saving Data")
        }
    }
    
    public func fetchCityList(completion: @escaping (Result<[Cities], Error>) -> Void) {
        let context = getManagedObjectContext()
        let fetchRequest = NSFetchRequest<Cities>(entityName: "Cities")
        var results: [Cities] = []
        do {
            results = try context.fetch(fetchRequest)
            completion(.success(results))
        }
        catch {
            completion(.failure(error))
        }
    }
    
    private func getManagedObjectContext() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return delegate!.persistentContainer.viewContext
    }
}
