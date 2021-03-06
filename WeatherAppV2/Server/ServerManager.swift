//
//  ServerManager.swift
//  CRMClient
//
//  Created by Dastan Mambetaliev on 14/3/21.
//  Copyright © 2021 Dastan Mambetaliev. All rights reserved.

import UIKit
import Alamofire

class ServerManager: HTTPRequestManager  {
    
    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
}
//

extension ServerManager {
    
    func getWeatherList(_ completion: @escaping (WeatherResponse) -> Void, _ error: @escaping (String) -> Void){
            let header: [String: String] = [
                "Content-Type": "application/json"
            ]
           self.get(url: "http://api.openweathermap.org/data/2.5/forecast?appid=887423efb2e91bf0b8ce30df56f2ebd0&units=metric&q=bishkek", header: header, completion: {
                (data) in
                do {
                    guard let data = data else {return}
                    let weatherList = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(weatherList)
                    }
                } catch let err {
                           error(err.localizedDescription)
                    print(err.localizedDescription)
                    
                       }
                   }, error: error)
        }
    
    func getCurrentWeatherList(_ completion: @escaping (CurrentWeatherStruct) -> Void, _ error: @escaping (String) -> Void){
        let header: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        self.get(url: "https://api.openweathermap.org/data/2.5/weather?appid=887423efb2e91bf0b8ce30df56f2ebd0&units=metric&q=bishkek", header: nil, completion: {
            (data) in
            do {
                guard let data = data else {return}
                let weatherList = try JSONDecoder().decode(CurrentWeatherStruct.self, from: data)
//        обновление и скорость пользовательского интерфейса
                DispatchQueue.main.async {
                    completion(weatherList)
                }
            } catch let err {
                error(err.localizedDescription)
            }
        }, error: error)
    }
    //    func getBalanceList(token: String, _ completion: @escaping (BalanceStruct) -> Void, _ error: @escaping (String) -> Void){
    ////
    //        let header: [String: String] = [
    //            "Authorization": "Bearer \(token)"
    //        ]
    //
    //        self.get(url: "https://neobis.herokuapp.com/account/get", header: header, completion: {
    //            (data) in
    //            do {
    //                guard let data = data else {return}
    //                let balanceList = try JSONDecoder().decode(BalanceStruct.self, from: data)
    //                DispatchQueue.main.async {
    //                    completion(balanceList)
    //                }
    //            } catch let err {
    //                       error(err.localizedDescription)
    //                   }
    //               }, error: error)
    //        }
    //
    
    
    
}
