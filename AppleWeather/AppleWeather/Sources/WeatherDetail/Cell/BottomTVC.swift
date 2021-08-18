//
//  BottomTVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/29.
//

import UIKit

class BottomTVC: UITableViewCell {
    
    public static let identifier = "BottomTVC"
    
    @IBOutlet weak var locationLabel: UILabel!
    //var city : String = "용산구"   // 예시

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func openButtonClicked(_ sender: Any) {
        if let url = URL(string: "https://www.naver.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func setData(location: String){
        locationLabel.text = "\(location)날씨"
    }
    
    
}
