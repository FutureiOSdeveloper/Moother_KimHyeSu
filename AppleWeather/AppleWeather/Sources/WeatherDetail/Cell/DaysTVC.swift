//
//  DaysTVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/29.
//

import UIKit

class DaysTVC: UITableViewCell {
    
    public static let identifier = "DaysTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func maskCell(fromTop margin: CGFloat) {
            layer.mask = visibilityMask(withLocation: margin / frame.size.height)
            layer.masksToBounds = true
        }

    private func visibilityMask(withLocation location: CGFloat) -> CAGradientLayer {
            let mask = CAGradientLayer()
            mask.frame = bounds
            mask.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
            let num = location as NSNumber
            mask.locations = [num, num]
            return mask
    }
}
