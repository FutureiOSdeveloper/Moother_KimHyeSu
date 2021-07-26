//
//  WeatherDetailVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/24.
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    public static let identifier = "WeatherDetailVC"

    @IBOutlet weak var topviewHeight: NSLayoutConstraint!
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var cityLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureDegreeLabel: UILabel!
    
    var height : Int = 300
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("우왕")
        topviewHeight.constant = CGFloat(height)
        setTopUI()
        
    }
    
    // MARK:- 가장 상단의 UI
    func setTopUI(){
        
    }

}
