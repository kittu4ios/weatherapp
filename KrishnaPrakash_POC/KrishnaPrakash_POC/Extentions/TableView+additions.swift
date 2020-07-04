//
//  TableView+additions.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import UIKit

extension UITableView {
    func tableDefaultSettings() {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = UITableView.automaticDimension
        self.tableFooterView = UIView()
    }
}
