//
//  DetailsTableViewCell.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var data: DetailsData? = nil {
        didSet {
            self.titleLabel.text = data?.title
            self.valueLabel.text = data?.value
        }
    }

}
