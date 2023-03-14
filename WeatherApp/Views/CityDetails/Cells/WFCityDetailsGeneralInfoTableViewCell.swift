//
//  WFCityDetailsGeneralInfoTableViewCell.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 13/03/2023.
//

import UIKit

class WFCityDetailsGeneralInfoTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "WFCityDetailsGeneralInfoTableViewCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        iconImageView.image = nil
        titleLabel.text = nil
        degreeLabel.text = nil
        descriptionLabel.text = nil
    }
    
    public func configure(with viewModel: WFCityDetailsGeneralInfoTableViewCellViewModel) {
        iconImageView.image = UIImage(named: viewModel.iconImageView)
        titleLabel.text = viewModel.title
        degreeLabel.text = viewModel.degreeString
        descriptionLabel.text = viewModel.description
    }
    
}
