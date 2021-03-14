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
    
    var updateDate = [SimpleDate]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        задаем цвет background
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func configureWeek(weather: List) {
        self.highTempLabel.text = "\(Int(weather.main.temp_max))"
        self.lowTempLabel.text = "\(Int(weather.main.temp_min))"
        self.dayLabel.text = getDayForDate(weather.dt_txt)
        if weather.weather[0].main == "Clouds" {
            self.iconImageView.image = UIImage(named: "cloud")
        } else if weather.weather[0].main == "Snow" {
            self.iconImageView.image = UIImage(named: "snow")
        } else if weather.weather[0].main == "Sun" {
            self.iconImageView.image = UIImage(named: "sun")
        } else if weather.weather[0].main == "Rain" {
            self.iconImageView.image = UIImage(named: "rain")
        }
    }
    
    
    
    func simpleWeatherDate (weather: WeatherResponse) {
        DispatchQueue.main.async {
            for i in 0..<weather.list.count {
                let first = weather.list[i].dt_txt.suffix(8)
                let second = first.prefix(2)
                if second == "03" {
                    self.updateDate[0].night.append(weather.list[i])
                } else if second == "15" {
                    self.updateDate[0].day.append(weather.list[i])
                }
            }
        }
    }
    
    
//    изъятие только  месяца и числа и времени из dt_txt
    func getDayForDate(_ date: String) -> String {
        let allDate = date.prefix(10)
        let dates = allDate.suffix(5)
        let day = dates.suffix(2)
        let month = dates.prefix(2)
        let time = date.suffix(8)
        let timeWithoutSec = time.prefix(5)

        return "\(day).\(month) \(timeWithoutSec)"
    }
}

struct SimpleDate {
    var day = [List]()
    var night = [List]()
}
