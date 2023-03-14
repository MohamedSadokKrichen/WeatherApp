//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 7/3/2023.
//

import UIKit

import WeatherAPIFramework

class WFCityListViewController: UIViewController {
    
    private let wfCityListView = WFCityListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cities"
        setupView()
    }
    
    private func setupView() {
        view.addSubview(wfCityListView)
        wfCityListView.delegate = self
        NSLayoutConstraint.activate([
            wfCityListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wfCityListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            wfCityListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            wfCityListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WFCityListViewController: WFCityListViewDelegate {
    func shouldGotoCityDetails(city: Cities) {
        let detailVC = WFCityDetailsViewController()
        detailVC.city = city
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: false)
    }
}
