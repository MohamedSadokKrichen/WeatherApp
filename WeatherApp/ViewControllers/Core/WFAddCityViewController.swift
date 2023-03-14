//
//  WFAddCityViewController.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit

class WFAddCityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    let viewModel = WFAddCityViewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add City"
        spinner.hidesWhenStopped = true
        setupTableView()
        self.hideKeyboardWhenTappedAround()
        viewModel.delegate = self
        searchTextField.isEnabled = false
        DispatchQueue.global(qos: .background).async {
            self.viewModel.populateTableViewFromJson()
        }
        searchTextField.addTarget(self, action: #selector(findCity), for: .editingChanged)
    }
    
    
    @objc private func findCity() {
        viewModel.searchForCity(with: searchTextField.text ?? "")
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: WFAddCityTableViewCell.self), bundle: nil), forCellReuseIdentifier: WFAddCityTableViewCell.cellIdentifier)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
}


extension WFAddCityViewController: WFAddCityViewViewModelDelegate {
    func shouldReloadCityList() {
        NotificationCenter.default.post(Notification(name: Notification.Name("refreshCityList")))
    }
    
    func didSelectCityToSave(cityName: String) {
        let alertController = UIAlertController(title: "Weather App", message: "Do you really want to save this new city : \(cityName)", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Save", style: .default) {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.saveCity(with: cityName)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true)
    }
    
    func shouldReloadTableViewData() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
            self.searchTextField.isEnabled = true
        }
        
    }
    
    
}
