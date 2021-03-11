//
//  NetworkingModel.swift
//  WeatherAppV2
//
//  Created by Dastan Mambetaliev on 10/3/21.
//

import Foundation
import Alamofire

class NetworkingModel {
    
    static let shared = NetworkingModel()
    
//    прием данных
    func execute(_ answer: @escaping (WeatherResponse)->()) {
        
        let url = WeatherApi().urlForDays
        AF.request(url, method: .get, encoding: JSONEncoding.default).validate().responseDecodable(of: WeatherResponse.self){ (response) in
            
            guard let weather = response.value else { return }
            
            DispatchQueue.main.async {
                answer(weather)
            }
            
        }
    }
    
    
}
