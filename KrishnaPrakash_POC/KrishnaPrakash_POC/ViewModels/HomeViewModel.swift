//
//  HomeViewModel.swift
//  KrishnaPrakash_POC
//
//  Created by Krishna Prakash on 7/3/20.
//  Copyright © 2020 KrishnaPrakash. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var dataSource = [DetailsData]()
    fileprivate(set) var cityTitle = "Please search for the city"
    var temparature = 0.0
    var weatherResponse:WeatherResponse?
    ///Temparatyre type display format
    var temparatureType:TempType = .Celsius
    
    /// Prepare  weather details in tableview
    func prepareData() {
        temparature = weatherResponse?.main.temp ?? 0.0
        let minTemparature =  DetailsData(title: "Min Temp:", value: Utilites.convertTemp(temparature:weatherResponse?.main.tempMin ?? 0.0, from: .kelvin, to: temparatureType.getType()))
        let maxTemparature =  DetailsData(title: "Max Temp:", value: Utilites.convertTemp(temparature: weatherResponse?.main.tempMax ?? 0.0, from: .kelvin, to: temparatureType.getType()))
        let humidity =  DetailsData(title: "Humidity:", value:"\(weatherResponse?.main.humidity ?? 0)%")
        let pressure =  DetailsData(title: "Pressure:", value:"\(weatherResponse?.main.pressure ?? 0) hPa")
        
        dataSource = [minTemparature,maxTemparature,humidity,pressure]
    }
    
    /// Method to store city name in cache
    /// - Parameter cityName: cityname as String
    func storeInCache(cityName:String) {
        let cacheData = CityCacheData()
        cacheData.storeCity(name: cityName)
        cityTitle = cityName
    }
    
    /// Method to get temparatre in reable format
    /// - Returns: temparatre value as string
    func getCurrentTemparature() -> String {
        return  Utilites.convertTemp(temparature: temparature, from: .kelvin, to: temparatureType.getType())
    }
    /// Method to call waether API
    func callWeatherAPI(completion: @escaping (_ error:Error?) -> Void) {
        NetworkManager.sharedInstance.getWeatherAPI(paramsString: prepareInputParameters()) { (response, error) in
            
            if error == nil {
                ///Store the reponse
                self.weatherResponse = response
                ///Prepare  weather details
                self.prepareData()
                return completion(nil)
            } else {
                return completion(error)
            }
        }
    }
    
    /// Prepare URL input
    /// - Returns: input params as String
    private func prepareInputParameters() -> String {
        
        let inputString = "?q=\(cityTitle)&appid=\(Constants.AppKeys.ApiKey)"
        
        return inputString
    }
    
}
