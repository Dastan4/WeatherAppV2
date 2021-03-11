//
//  WeatherTableViewCell.swift
//  WeatherAppV2
//
//  Created by Dastan Mambetaliev on 10/3/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        задаем цвет background
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    //    ???
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    func configure(weather: WeatherResponse) {
        self.highTempLabel.text = String(weather.list[0].main.temp_max!)
        self.lowTempLabel.text = String(weather.list[0].main.temp_min!)
        self.dayLabel.text = weather.list[0].dt_txt
        self.iconImageView.image = UIImage(named: "clear")
        self.cityLabel.text = weather.city.name
    }
    
    
    
    //    настройка ячейки
    //    func configure(with model: WeatherResponseModel) {
    //
    //        for i in 0 ..< model.weather.count {
    //            self.lowTempLabel.text = "\(Int(model.weather[i].temperature_min))°"
    //            self.highTempLabel.text = "\(Int(model.weather[i].temperature_max))°"
    //
    //            self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.weather[i].dateText)!))
    //    //        default icon
    //            self.iconImageView.image = UIImage(named: "clear")
    //        }
    //    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        //        получаем день по дате
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: inputDate)
    }
    
}
