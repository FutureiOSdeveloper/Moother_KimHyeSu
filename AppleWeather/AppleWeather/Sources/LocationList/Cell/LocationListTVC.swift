//
//  LocationListTVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/01.
//

import UIKit

class LocationListTVC: UITableViewCell {
    
    public static let identifier = "LocationListTVC"

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(time: String, location: String, temperature: Int, celsius: Bool){
        timeLabel.text = time
        locationLabel.text = location
        if celsius == true {
            temperatureLabel.text = "\(temperature)º"
        }
        else {
            temperatureLabel.text = "\(temperature+32)º"
            print(temperature+32)
        }
    }
    
}
