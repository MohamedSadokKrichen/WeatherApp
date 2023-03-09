//
//  WFAddCityViewController.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit

class WFAddCityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    let viewModel = WFAddCityViewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add City"
        setupTableView()
        viewModel.delegate = self
        viewModel.populateTableViewFromJson()
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
    
    @IBAction func addButtonAction(_ sender: UIButton) {
    }
    
}


extension WFAddCityViewController: WFAddCityViewViewModelDelegate {
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
        tableView.reloadData()
    }
    
    
}
