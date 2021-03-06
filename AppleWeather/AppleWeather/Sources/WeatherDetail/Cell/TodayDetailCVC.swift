//
//  TodayDetailCVC.swift
//  AppleWeather
//
//  Created by κΉνμ on 2021/07/29.
//

import UIKit

class TodayDetailCVC: UICollectionViewCell {
    
    public static let identifier = "TodayDetailCVC"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(title: String, contents: String) {
        
        titleLabel.text = title
        contentsLabel.text = contents
    }

}
