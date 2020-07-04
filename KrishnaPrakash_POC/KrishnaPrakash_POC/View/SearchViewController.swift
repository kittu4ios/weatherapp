//
//  SearchViewController.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //Searchbar to search the cache cities
    @IBOutlet weak var searbarView: UISearchBar!
    ///Clear button to clear the cache cities
    @IBOutlet weak var clearButton: UIButton!
    ///Delegate for passing city name to Adopted class
    weak var delegate:WeatherCityDelegate?
    ///Search view model
    private var viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        ///Prepare cities from stored cache
        viewModel.prepareCacheData()
        ///Checking to display clear cache option
        checkForClearOption()
        tableView.tableDefaultSettings()
        tableView.reloadData()
    }
    @IBAction func onTapCloseButton(_ sender: UIButton) {
        dismissMethod()
    }
    @IBAction func onTapClearCacheButton(_ sender: UIButton) {
        //Clear cache results
        viewModel.clearCacheData()
        tableView.reloadData()
        ///Checking to display clear cache option
        checkForClearOption()
    }
    /// Method to dismiss viewcontroller
    func dismissMethod() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    private func checkForClearOption() {
        ///Hide clear cache button if cache cities not available
        clearButton.isHidden = viewModel.cacheCities.count == 0
    }
}
extension SearchViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell")
        cell?.textLabel?.text = viewModel.dataSource?[indexPath.row]
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///passing selected city name from cached list
        delegate?.displayCityName(cityName: viewModel.dataSource?[indexPath.row] ?? "")
        dismissMethod()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        ///Passing search text to delegate method
        delegate?.displayCityName(cityName:searchText)
        searchBar.resignFirstResponder()
        dismissMethod()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ///Text changes in searchbox. check for result cities
        if searchBar.text != viewModel.searchString {
            viewModel.searchCities(string: searchBar.text ?? "")
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = viewModel.searchString
        searchBar.resignFirstResponder()
    }
}
