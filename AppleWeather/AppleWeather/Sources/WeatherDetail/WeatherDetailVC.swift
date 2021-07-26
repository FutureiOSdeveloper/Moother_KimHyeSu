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
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension WeatherDetailVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //print(scrollview.frame.height)
        print(scrollview.contentOffset.y)
        if scrollview.contentOffset.y > 0 {
            //self.topviewHieght.constant -= scrollview.frame.height
            self.topviewHeight.constant = 100
            UIView.animate(withDuration: 0.5){
                self.view.layoutIfNeeded()
            }
        }
        else {
            print("내릴때")
            topviewHeight.constant = 300
            UIView.animate(withDuration: 0.5){
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
    
}
