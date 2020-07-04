//
//  HomeViewController.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import UIKit
protocol WeatherCityDelegate: class {
    ///Method to capture cityname as String
    func displayCityName(cityName: String)
}
class HomeViewController: UIViewController,WeatherCityDelegate {
    
    /// Homeview Model
    private var homeViewModel = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        addSearchBarButton()
        ///Default custom tableview settings
        tableView.tableDefaultSettings()
        ///To display placeholders text reloading the tableview
        tableView.reloadData()
    }
    /// Adding search bar button to navigation bar method
    private func addSearchBarButton() {
        let searchButton = UIButton()
        searchButton.setImage(UIImage(named: "searchicon"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = searchBarButton
        
    }
    /// Search button tapped method
    @objc func searchTapped() {
        if let searchViewController = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchViewController.delegate = self
            self.present(searchViewController, animated: true, completion: nil)
        }
    }
    /// Get city name and prepare the API call
    /// - Parameter cityName: city name as String
    func displayCityName(cityName: String) {
        ///Store city name to cache
        homeViewModel.storeInCache(cityName: cityName)
        ///Call weather API in view model
        homeViewModel.callWeatherAPI() { [unowned self] (error) in
           DispatchQueue.main.async {
            if (error == nil) {
                ///Error is nil. Reload the data
                self.tableView.reloadData()
            } else {
                ///Display error alert
                self.showAlertMessageWith(title: "Error", message: error?.localizedDescription ?? "Something went wrong. Please try again.")
            }
          }
        }
    }
    
}
///Tableview Delegate methods
extension HomeViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ///Section 0 to display main titles, Section 1 for other details
        return section == 0 ? 1 : homeViewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell") as? DashboardTableViewCell {
                ///Set values as City name and Temparature
                cell.displayData(cityName:homeViewModel.cityTitle,temparature:homeViewModel.getCurrentTemparature())
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as? DetailsTableViewCell {
                ///Set data to display other weather details
                cell.data = homeViewModel.dataSource[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
}
