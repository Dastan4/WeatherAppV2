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
    
    var models = [WeatherResponse]()
    
    
    //Свойство где мы будем захватывать координаты местоположения
    var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      register 2 cells for
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        ServerManager.shared.getWeatherList { (weatherList) in
            
            self.models = [WeatherResponse]()
            self.table.delegate = self
            self.table.dataSource = self
            self.table.reloadData()
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
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let weather = models[indexPath.row]
        cell.configure(weather: weather)
        return cell
        
    }
    
}
            
//extension UITableView {
//    @IBInspectable var backgroundImage: UIImage? {
//        get {
//            return nil
//        }
//        set {
//            backgroundView = UIImageView(image: newValue)
//        }
//    }
//}
//
