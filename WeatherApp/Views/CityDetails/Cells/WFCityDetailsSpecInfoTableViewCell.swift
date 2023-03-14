//
//  WFCityDetailsSpecInfoTableViewCell.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 10/03/2023.
//

import UIKit
import WeatherAPIFramework

class WFCityDetailsSpecInfoTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "WFCityDetailsSpecInfoTableViewCell"
    
    public var weather : Weather?
    
    public var cityInfo : Cities?
    
    private var cellviewModel : [WFCityDetailsSpecificCollectionViewCellViewModel] = []
    
    public let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WFCityDetailsSpecificCollectionViewCell.self, forCellWithReuseIdentifier: WFCityDetailsSpecificCollectionViewCell.cellIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.addSubview(collectionView)
        selectionStyle = .none
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func initializeCellViewModel() {
        if weather != nil {
            cellviewModel = [
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(weather?.main?.feelsLike ?? 0))" , type: .feelLike),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(weather?.main?.tempMin ?? 0))" , type: .tempMin),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(weather?.main?.tempMax ?? 0))" , type: .tempMax),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(weather?.main?.pressure ?? 0))" , type: .pressure),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(weather?.main?.humidity ?? 0))" , type: .humidity),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(weather?.wind?.speed ?? 0))" , type: .wind),
            ]
        } else {
            cellviewModel = [
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(cityInfo?.feelsLike ?? 0))" , type: .feelLike),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(cityInfo?.tempMin ?? 0))" , type: .tempMin),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(cityInfo?.tempMax ?? 0))" , type: .tempMax),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(cityInfo?.pressure ?? 0))" , type: .pressure),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(cityInfo?.humidity ?? 0))" , type: .humidity),
                WFCityDetailsSpecificCollectionViewCellViewModel(value: "\(Int(cityInfo?.windSpeed ?? 0))" , type: .wind),
            ]
        }
        
    }

}

extension WFCityDetailsSpecInfoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WFCityDetailsSpecificCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? WFCityDetailsSpecificCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        initializeCellViewModel()
        let viewModel = cellviewModel[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 80)
    }
    
}
