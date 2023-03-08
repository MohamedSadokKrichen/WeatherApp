//
//  WFCityListTableViewCell.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit

class WFCityListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "WFCityListTableViewCell"
    
    private let cityNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let cityTempLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50),
            cityNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            cityNameLabel.rightAnchor.constraint(equalTo: cityTempLabel.leftAnchor, constant: 5),
            
            cityTempLabel.widthAnchor.constraint(equalToConstant: 100),
            cityTempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5),
            cityTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            cityTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = nil
        cityTempLabel.text = nil
    }
    
    public func configure(with viewModel: WFCityListTableViewCellViewModel) {
        cityNameLabel.text = viewModel.cityName
        cityTempLabel.text = viewModel.cityTempString
    }

}
