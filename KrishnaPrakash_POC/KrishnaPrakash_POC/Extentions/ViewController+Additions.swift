//
//  ViewController+Additions.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/4/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {


    func showAlertMessageWith(title:String, message:String) {
        
        // create the alert
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}
