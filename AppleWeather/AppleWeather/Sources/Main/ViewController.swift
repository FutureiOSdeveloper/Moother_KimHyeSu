//
//  ViewController.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    var cityList : [String] = []
    var vcList : [UIViewController] = []
    

    @IBOutlet weak var containviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var vccontain: UIView!
    @IBOutlet weak var scrollcontentsview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("메인")
        setDummy()
        setScrollviewUI()
        
    }
    
    func setScrollviewUI(){
        scrollview.delegate = self
        
        
        
        for index in 0..<cityList.count {
            
            
            let containerView = UIView()
            let sb = UIStoryboard(name: "WeatherDetail", bundle: nil)
            
            guard let vc = sb.instantiateViewController(withIdentifier: WeatherDetailVC.identifier) as? WeatherDetailVC
            else { return }
 
            containerView.frame = UIScreen.main.bounds
            containerView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(index)
            containView.addSubview(containerView)
            containerView.addSubview(vc.view)
            
            //vc.scroll.delegate = self
            vcList.append(vc)
        }
        
        containviewWidth.constant = UIScreen.main.bounds.width * CGFloat(cityList.count)
        
        scrollview.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(cityList.count), height: UIScreen.main.bounds.height
        )
        
        scrollview.alwaysBounceVertical = false
        //scrollview.alwaysBounceHorizontal = false
        pagecontrol.numberOfPages = cityList.count
        
    }
    
    func setDummy(){
        cityList.append(contentsOf: ["서울", "부산", "마포구", "용산구", "수원시"])

    }

    @IBAction func pageChanged(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.scrollview.contentOffset.x = UIScreen.main.bounds.width * CGFloat(self.pagecontrol.currentPage)
        }
    }
    
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagecontrol.currentPage = Int(floor(scrollview.contentOffset.x / UIScreen.main.bounds.width))
    }
}

