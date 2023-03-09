//
//  WFAddCityTableViewCell.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 9/3/2023.
//

import UIKit

class WFAddCityTableViewCell: UITableViewCell {
    static let cellIdentifier = "WFAddCityTableViewCell"
    @IBOutlet weak var cityNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cityNameLabel.font = .systemFont(ofSize: 17)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = nil
    }
    
    public func configure(with viewModel: WFAddCityTableViewCellViewModel) {
        cityNameLabel.text = viewModel.countryCityString
    }
    
}
