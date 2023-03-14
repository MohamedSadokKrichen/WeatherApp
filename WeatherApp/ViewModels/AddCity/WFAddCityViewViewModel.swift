//
//  WFAddCityViewViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 9/3/2023.
//

import UIKit

protocol WFAddCityViewViewModelDelegate: AnyObject {
    func shouldReloadTableViewData()
    func didSelectCityToSave(cityName: String)
    func shouldReloadCityList()
}


class WFAddCityViewViewModel: NSObject {
    
    private var citiesList : [CityJSON] = []
    private var filteredCitiesList : [CityJSON] = []
    
    public weak var delegate: WFAddCityViewViewModelDelegate?
    
    public func populateTableViewFromJson() {
        guard let data = getJsonFileData() else { return }
        citiesList = serializeJsonData(data: data)
        filteredCitiesList = citiesList
        self.delegate?.shouldReloadTableViewData()
    }
    
    private func getJsonFileData() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: "city.list", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    private func serializeJsonData(data: Data) -> [CityJSON] {
        do {
            let result = try JSONDecoder().decode([CityJSON].self, from: data)
            return result
        }
        catch {
            fatalError("error parsing JSON")
        }
    }
    
    public func searchForCity(with text: String) {
        filteredCitiesList = []
        
        filteredCitiesList = citiesList.filter({ city in
            return city.name?.uppercased().contains(text.uppercased()) ?? false
        })
        self.delegate?.shouldReloadTableViewData()
    }
    
    public func saveCity(with name: String) {
        CityDBManager.shared.delegate = self
        CityDBManager.shared.saveNewCity(with: name)
        
    }
}

extension WFAddCityViewViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCitiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WFAddCityTableViewCell.cellIdentifier, for: indexPath) as? WFAddCityTableViewCell else { fatalError("Unsupported cell") }
        let city = filteredCitiesList[indexPath.row]
        cell.configure(with: WFAddCityTableViewCellViewModel(cityName: city.name ?? "", cityCountryName: city.country ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectCityToSave(cityName: filteredCitiesList[indexPath.row].name ?? "")
    }
    
}

extension WFAddCityViewViewModel: CityDBManagerDelegate {
    func didSaveNewCity() {
        self.delegate?.shouldReloadCityList()
    }
    
    
}
