//
//  WFTabBarController.swift
//  WeatherApp
//
//  Created by Mohamed Sadok  Krichen on 8/3/2023.
//

import UIKit

/// Tab Bar controller to encapsulate our two view controllers
class WFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let cityListVC = WFCityListViewController()
        let addCityVC = WFAddCityViewController()
        
        cityListVC.navigationItem.largeTitleDisplayMode = .automatic
        addCityVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: cityListVC)
        let nav2 = UINavigationController(rootViewController: addCityVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Cities",
                                       image: UIImage(named: "cities"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Add City",
                                       image: UIImage(named: "add"),
                                       tag: 2)
        
        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers([nav1, nav2],
                           animated: true)
    }

}
