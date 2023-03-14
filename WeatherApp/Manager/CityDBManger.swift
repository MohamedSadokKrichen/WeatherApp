//
//  CityDBManger.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit
import CoreData
import WeatherAPIFramework

protocol CityDBManagerDelegate: AnyObject {
    func didSaveNewCity()
}

final class CityDBManager {
    public static let shared = CityDBManager()
    
    public weak var delegate : CityDBManagerDelegate?
    
    public func saveNewCity(with name: String) {
        let context = getManagedObjectContext()
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Cities", in: context) else { return }
        let newCity = NSManagedObject(entity: entityDescription, insertInto: context)
        if Reachability.isConnectedToNetwork() {
            WeatherApiCalls.shared.getWeatherInfo(for: name) { result in
                switch result {
                case .success(let weather):
                    newCity.setValue(name, forKey: "cityName")
                    newCity.setValue(weather.main?.temp, forKey: "lastTemp")
                    newCity.setValue(weather.main?.feelsLike, forKey: "feelsLike")
                    newCity.setValue(weather.main?.humidity, forKey: "humidity")
                    newCity.setValue(weather.main?.pressure, forKey: "pressure")
                    newCity.setValue(weather.main?.tempMax, forKey: "tempMax")
                    newCity.setValue(weather.main?.tempMin, forKey: "tempMin")
                    newCity.setValue(weather.wind?.speed, forKey: "windSpeed")
                    newCity.setValue(weather.weather?.first?.main, forKey: "main")
                    newCity.setValue(weather.weather?.first?.description, forKey: "weatherDescription")
                    newCity.setValue(weather.weather?.first?.icon, forKey: "iconName")
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "EEEE, dd MMMM, yyyy HH:mm"
                    let stringDate = formatter.string(from: date)
                    newCity.setValue(stringDate, forKey: "lastUpdate")
                    do {
                        try context.save()
                        self.delegate?.didSaveNewCity()
                    } catch {
                        print("ERROR Saving Data")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            newCity.setValue(name, forKey: "cityName")
            do {
                try context.save()
                self.delegate?.didSaveNewCity()
            } catch {
                print("ERROR Saving Data")
            }
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
    
    public func updateWeather(with weather: Weather, cityName: String) {
        let context = getManagedObjectContext()
        let fetchRequest = NSFetchRequest<Cities>(entityName: "Cities")
        let predicate = NSPredicate(format: "cityName = '\(cityName)'")
        fetchRequest.predicate = predicate
        do
            {
                let object = try context.fetch(fetchRequest)
                if object.count == 1
                {
                    let objectUpdate = object.first!
                    objectUpdate.setValue(cityName, forKey: "cityName")
                    objectUpdate.setValue(weather.main?.temp, forKey: "lastTemp")
                    objectUpdate.setValue(weather.main?.feelsLike, forKey: "feelsLike")
                    objectUpdate.setValue(weather.main?.humidity, forKey: "humidity")
                    objectUpdate.setValue(weather.main?.pressure, forKey: "pressure")
                    objectUpdate.setValue(weather.main?.tempMax, forKey: "tempMax")
                    objectUpdate.setValue(weather.main?.tempMin, forKey: "tempMin")
                    objectUpdate.setValue(weather.wind?.speed, forKey: "windSpeed")
                    objectUpdate.setValue(weather.weather?.first?.main, forKey: "main")
                    objectUpdate.setValue(weather.weather?.first?.description, forKey: "weatherDescription")
                    objectUpdate.setValue(weather.weather?.first?.icon, forKey: "iconName")
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "EEEE, dd MMMM, yyyy HH:mm"
                    let stringDate = formatter.string(from: date)
                    objectUpdate.setValue(stringDate, forKey: "lastUpdate")
                    do{
                        try context.save()
                        NotificationCenter.default.post(Notification(name: Notification.Name("refreshCityList")))
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
            catch
            {
                print(error)
            }
    }
    
    public func fetchCity(with name: String,
                          completion: @escaping (Result<Cities, Error>) -> Void) {
        let context = getManagedObjectContext()
        let fetchRequest = NSFetchRequest<Cities>(entityName: "Cities")
        let predicate = NSPredicate(format: "cityName = '\(name)'")
        fetchRequest.predicate = predicate
        var results: [Cities] = []
        do {
            results = try context.fetch(fetchRequest)
            guard let weather = results.first else {return}
            completion(.success(weather))
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
