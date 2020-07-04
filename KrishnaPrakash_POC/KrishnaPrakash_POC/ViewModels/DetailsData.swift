//
//  DetailsData.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation

class DetailsData {
    var title:String = ""
    var value:String = ""
    
    fileprivate init () {
        
    }
    
    init(title:String, value:String) {
        self.title = title
        self.value = value
    }
    
}
