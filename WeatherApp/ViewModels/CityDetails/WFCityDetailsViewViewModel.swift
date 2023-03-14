//
//  WFCityDetailsViewViewModel.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 10/03/2023.
//

import UIKit

import WeatherAPIFramework

protocol WFCityDetailsViewViewModelDelegate: AnyObject {
    func didGetWeatherInfo()
}


class WFCityDetailsViewViewModel: NSObject {
    
    private var weatherInfo : Weather?
    
    private var cityInfo: Cities?
    
    public weak var delegate : WFCityDetailsViewViewModelDelegate?
    
    public func fetchWeatherInfoForCity(with city: Cities) {
        if Reachability.isConnectedToNetwork() {
            WeatherApiCalls.shared.getWeatherInfo(for: city.cityName ?? "") {[weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let success):
                    self.weatherInfo = success
                    CityDBManager.shared.updateWeather(with: success, cityName: city.cityName ?? "")
                    self.delegate?.didGetWeatherInfo()
                    
                case .failure(let failure):
                    print(failure)
                }
            }
        } else {
            CityDBManager.shared.fetchCity(with: city.cityName ?? "") {[weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let success):
                    self.cityInfo = success
                    self.delegate?.didGetWeatherInfo()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
    }
}

extension WFCityDetailsViewViewModel : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WFCityDetailsGeneralInfoTableViewCell.cellIdentifier, for: indexPath) as? WFCityDetailsGeneralInfoTableViewCell else { fatalError("Unsupported cell") }
            var viewModel : WFCityDetailsGeneralInfoTableViewCellViewModel
            if Reachability.isConnectedToNetwork() {
                viewModel = WFCityDetailsGeneralInfoTableViewCellViewModel(iconImageView: weatherInfo?.weather?.first?.icon ?? "", title: weatherInfo?.weather?.first?.main ?? "", description: weatherInfo?.weather?.first?.description ?? "", degree: "\(Int(weatherInfo?.main?.temp ?? 0))")
            } else {
                viewModel = WFCityDetailsGeneralInfoTableViewCellViewModel(iconImageView: cityInfo?.iconName ?? "", title: cityInfo?.main ?? "", description: cityInfo?.weatherDescription ?? "", degree: "\(Int(cityInfo?.lastTemp ?? 0))")
            }
            
            cell.configure(with: viewModel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WFCityDetailsSpecInfoTableViewCell.cellIdentifier, for: indexPath) as? WFCityDetailsSpecInfoTableViewCell else { fatalError("Unsupported cell") }
            if Reachability.isConnectedToNetwork() {
                guard let _ = weatherInfo else {return cell}
                cell.weather = weatherInfo
            } else {
                cell.cityInfo = cityInfo
            }
            cell.collectionView.reloadData()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        else {
            return 200
        }
    }
    
}
