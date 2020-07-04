//
//  DashboardTableViewCell.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var temparatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    /// Method to display temparature and cityname in dashboard
    /// - Parameters:
    ///   - cityName: cityname as String
    ///   - temparature: temparature as String
    func displayData(cityName:String,temparature:String) {
        temparatureLabel.text = temparature
        cityNameLabel.text = cityName
    }
}
