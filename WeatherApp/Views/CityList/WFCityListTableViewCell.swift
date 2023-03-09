//
//  WFCityListTableViewCell.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit
import WeatherAPIFramework

class WFCityListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "WFCityListTableViewCell"
    
    private let cityNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let cityTempLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seperatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(cityTempLabel)
        contentView.addSubview(seperatorView)
        contentView.addSubview(iconImageView)
        selectionStyle = .none
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50),
            cityNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cityNameLabel.rightAnchor.constraint(equalTo: cityTempLabel.leftAnchor, constant: -5),
            
            cityTempLabel.widthAnchor.constraint(equalToConstant: 100),
            cityTempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            cityTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cityTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            
            seperatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            seperatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
            seperatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = nil
        cityTempLabel.text = nil
    }
    
    public func configure(with viewModel: WFCityListTableViewCellViewModel) {
        cityNameLabel.text = viewModel.cityName
        WeatherApiCalls.shared.getWeatherInfo(for: viewModel.cityName) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.cityTempLabel.text = "\(Int(success.main?.temp ?? 0.0))°C"
                    self.iconImageView.image = UIImage(named: success.weather?.first?.icon ?? "")
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
        
    }

}
