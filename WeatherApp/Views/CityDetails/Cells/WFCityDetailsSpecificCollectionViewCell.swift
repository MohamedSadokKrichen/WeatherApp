//
//  WFCityDetailsSpecificCollectionViewCell.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 10/03/2023.
//

import UIKit

class WFCityDetailsSpecificCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "WFCityDetailsSpecificCollectionViewCell"
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 182.0/255.0, green: 213.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        return view
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupContentView() {
        contentView.backgroundColor = UIColor(red: 85.0/255.0, green: 144.0/255.0, blue: 171.0/255.0, alpha: 1.0)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.white.cgColor
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowRadius = 8
        contentView.layer.shadowOffset = CGSize(width: 7, height: 5)
        titleContainerView.addSubview(titleLabel)
        contentView.addSubview(titleContainerView)
        contentView.addSubview(valueLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    public func configure(with viewModel: WFCityDetailsSpecificCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
    }
}
