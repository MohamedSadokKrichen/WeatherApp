//
//  WFCityListViewViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit
import WeatherAPIFramework

protocol WFCityListViewViewModelDelegate: AnyObject {
    func didLoadCityList()
//    func didSelectCity(weather: Weather)
}

class WFCityListViewViewModel: NSObject {
    
    public weak var delegate : WFCityListViewViewModelDelegate?
    
    private var cities : [Cities] = []
    
    public func fetchCitiesList() {
        CityDBManager.shared.fetchCityList {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let cities):
                self.cities = cities
                self.delegate?.didLoadCityList()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension WFCityListViewViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WFCityListTableViewCell.cellIdentifier, for: indexPath) as? WFCityListTableViewCell else { fatalError("Unsupported cell") }
        let city = cities[indexPath.row]
        let viewModel = WFCityListTableViewCellViewModel(cityName: city.cityName ?? "", cityTemp: Float(city.lastTemp))
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
