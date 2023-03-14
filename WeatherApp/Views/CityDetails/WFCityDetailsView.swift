//
//  WFCityDetailsView.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 10/03/2023.
//

import UIKit

class WFCityDetailsView: UIView {

    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.alpha = 0
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .white)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return(spinner)
    }()
    
    private let viewModel = WFCityDetailsViewViewModel()
    
    public var cityName: String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(city: Cities) {
        super.init(frame: .zero)
        viewModel.delegate = self
        viewModel.fetchWeatherInfoForCity(with: city)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        addSubview(tableView)
        spinner.startAnimating()
        setupConstraints()
        configuretableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.heightAnchor.constraint(equalTo: heightAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    private func configuretableView() {
        tableView.register(UINib(nibName: String(describing: WFCityDetailsGeneralInfoTableViewCell.self), bundle: nil), forCellReuseIdentifier: WFCityDetailsGeneralInfoTableViewCell.cellIdentifier)
        tableView.register(WFCityDetailsSpecInfoTableViewCell.self, forCellReuseIdentifier: WFCityDetailsSpecInfoTableViewCell.cellIdentifier)
        tableView.backgroundColor = .clear
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
}

extension WFCityDetailsView: WFCityDetailsViewViewModelDelegate {
    func didGetWeatherInfo() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
            self.tableView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 1
            }
        }
        
    }
    
    
}
