//
//  ViewController.swift
//  WeatherAppV2
//
//  Created by Dastan Mambetaliev on 10/3/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var table: UITableView!
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var currentTemp: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    
    var models = [List]()
    var modelToCurrent = [CurrentWeatherStruct]()
    
    
    //Свойство где мы будем захватывать координаты местоположения
//    var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       картинка для заднего фона
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
//       прозрачный цвет для TableView
        self.table.backgroundColor = UIColor.clear
//      register 2 cells for
    
        
        table.delegate = self
        table.dataSource = self
        
//        
        ServerManager.shared.getWeatherList { (weatherList) in
            
            
            
            self.models = weatherList.list
            self.table.delegate = self
            self.table.dataSource = self
            self.table.reloadData()
            
            self.cityName.text = weatherList.city.name
            self.currentTemp.text = "\(Int(weatherList.list[0].main.temp))"
            if self.models[0].weather[0].main == "Clouds" {
                self.weatherIcon.image = UIImage(named: "cloud")
            } else if self.models[0].weather[0].main == "Snow" {
                self.weatherIcon.image = UIImage(named: "snow")
            } else if self.models[0].weather[0].main == "Sun" {
                self.weatherIcon.image = UIImage(named: "sun")
            } else if self.models[0].weather[0].main == "Rain" {
                self.weatherIcon.image = UIImage(named: "rain")
            }
            
        } _: { (error) in
            print(error)
        }
    }
    
    
    
//    запускает после загрузки во viewdidload
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        setupLocation()
//
//    }
    
    
//    Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == table {
            return models.count
        }
        return modelToCurrent.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForDay = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let weather = models[indexPath.row]
        cellForDay.configureWeek(weather: weather)
        return cellForDay
    }
    
    
    
    
}
            


