//
//  WFCityListView.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit

protocol WFCityListViewDelegate: AnyObject {
    func shouldGotoCityDetails(city: Cities)
}

class WFCityListView: UIView {
    
    private let viewModel = WFCityListViewViewModel()
    
    public weak var delegate: WFCityListViewDelegate?

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .white)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return(spinner)
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.isHidden = true
        tableView.alpha = 0
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCitiesList()
        addSubview(spinner)
        addSubview(tableView)
        addConstraints()
        configuretableView()
        NotificationCenter.default.addObserver(self, selector: #selector(refetchCityList(_:)), name: Notification.Name("refreshCityList"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func refetchCityList(_ sender: NSNotification) {
        viewModel.fetchCitiesList()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configuretableView() {
        tableView.register(WFCityListTableViewCell.self, forCellReuseIdentifier: WFCityListTableViewCell.cellIdentifier)
        tableView.backgroundColor = .clear
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}


extension WFCityListView: WFCityListViewViewModelDelegate {
    func didLoadCityList() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
            self.tableView.isHidden = false
            UIView.animate(withDuration: 0.4) { [weak self] in
                guard let self = self else { return }
                self.tableView.alpha = 1
            }
        }
        
        
    }
    
    func didSelectCity(city: Cities) {
        self.delegate?.shouldGotoCityDetails(city: city)
    }
    
}
