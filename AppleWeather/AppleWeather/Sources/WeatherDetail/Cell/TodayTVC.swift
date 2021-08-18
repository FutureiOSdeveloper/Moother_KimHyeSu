//
//  TodayTVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/29.
//

import UIKit

class TodayTVC: UITableViewCell {
    
    public static let identifier = "TodayTVC"

    @IBOutlet weak var todayDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(currentState: String,
                 maxTemp: Int,
                 minTemp: Int){
        todayDetailLabel.text = "오늘: 현재 날씨 \(currentState), 최고 기온은 \(maxTemp)º 입니다. 최저 기온은 \(minTemp)º 입니다."
    }
    
}
