//
//  HeaderCVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/29.
//

import UIKit

class HeaderCVC: UICollectionViewCell {
    
    public static let identifier = "HeaderCVC"

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(time: String, icon: String, temperature: Int){
        timeLabel.text = time
        iconLabel.text = icon.weatherIcon()
        temperatureLabel.text = "\(temperature)º"
    }

}
