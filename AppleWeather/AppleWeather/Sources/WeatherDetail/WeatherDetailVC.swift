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
    
    var height : Int = 300
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("우왕")
        topviewHeight.constant = CGFloat(height)
        //scroll.delegate = self
        //topviewHeight.constant = 300
        
        
    }
    
    @objc
    func didRecieveTestNotification(_ notification: Notification) {
             print("Test Notification")
     }
    
    
   
    
}

//extension WeatherDetailVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("호출되니~")
//    }
//
////    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
////
////    }
////
////
////    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////
////        print("호출됨?")
////        //print(scrollview.frame.height)
////        //print(scrollview.contentOffset.y)
////        if scrollview.contentOffset.y > 0 {
////            //self.topviewHieght.constant -= scrollview.frame.height
////            self.topviewHeight.constant = 100
////            UIView.animate(withDuration: 0.5){
////                self.view.layoutIfNeeded()
////            }
////        }
////        else {
////            print("내릴때")
////            topviewHeight.constant = 300
////            UIView.animate(withDuration: 0.5){
////                self.view.layoutIfNeeded()
////            }
////        }
////
////    }
//
//}
