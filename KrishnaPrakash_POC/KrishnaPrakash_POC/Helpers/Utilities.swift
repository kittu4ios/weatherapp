//
//  Utilities.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/4/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation

struct Utilites {
    
    static func convertTemp(temparature: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        if temparature == 0.0 {
            return "-"
        }
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.unitOptions = .providedUnit
        let inputValue = Measurement(value: temparature, unit: inputTempType)
        let outputValue = inputValue.converted(to: outputTempType)
        return formatter.string(from: outputValue)
    }
    ///Generic method to pasre the API response data into given Model
    static func dataToObject<T>(type: T.Type, from data: Data, completion:@escaping((T?, Error?) -> Void)) where T : Decodable {
        
        do{
            let dataModel = try JSONDecoder().decode(type, from: data)
            completion(dataModel,nil)
        }
        catch DecodingError.dataCorrupted(let context){
            completion(nil, context.underlyingError)
        }
        catch let err {
            completion(nil, err)
        }
    }
}

