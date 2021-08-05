//
//  ViewController.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/24.
//

import UIKit
import Lottie
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var cityList : [String] = []
    var vcList : [UIViewController] = []
    
    
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double? // 위도
    var longtitude: Double?// 경도
    
    lazy var lottieView : AnimationView = {
            let animationView = AnimationView(name: "4800-weather-partly-cloudy")
            animationView.frame = CGRect(x: 0, y: 0, width: 230, height: 230)
        animationView.center.x = self.view.center.x
        animationView.center.y = self.view.center.y - 100
            animationView.contentMode = .scaleAspectFill
            animationView.play()
            animationView.isHidden = false
            return animationView
        }()
    

    @IBOutlet weak var bgLottieView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var containviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var vccontain: UIView!
    @IBOutlet weak var scrollcontentsview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgLottieView.addSubview(lottieView)
        print("메인")
        setDummy()
        getLocation()
        setScrollviewUI()
        setupPageControl()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pageChange), name: Notification.Name("noti1"), object: nil)
    }
    
    func getLocation(){
        // LocationManager 인스턴스 생성
        //locationManager = CLLocationManager()
        
        // 델리게이트 생성
        locationManager.delegate = self
        
        // 포그라운드 상태에서 위치추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        
        // 배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            
            // 위도와 경도 가져오기
            let location = locationManager.location?.coordinate
            // 위도와 경도 저장
            latitude = location?.latitude ?? 0
            longtitude = location?.longitude ?? 0
            
            print("위도: \(latitude), 경도: \(longtitude)")
        }
        // 위치 업데이트
        
        
        
        //textLabel.text = "위도: \(latitude), 경도: \(longtitude)"
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
    
    func setupPageControl() {
         pagecontrol.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0)
    }
    
    @objc func pageChange(notification: NSNotification){
        pagecontrol.currentPage = notification.object as! Int
        self.scrollview.contentOffset.x = UIScreen.main.bounds.width * CGFloat(self.pagecontrol.currentPage)
//        UIView.animate(withDuration: 0.3){
//
//        }
        
    }

    @IBAction func pageChanged(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.3){
            self.scrollview.contentOffset.x = UIScreen.main.bounds.width * CGFloat(self.pagecontrol.currentPage)
        }
    }
    
    @IBAction func listButtonClicked(_ sender: Any) {
        
        let sb = UIStoryboard(name: "LocationList", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: LocationListVC.identifier) as? LocationListVC else {
            return
        }
        //vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagecontrol.currentPage = Int(floor(scrollview.contentOffset.x / UIScreen.main.bounds.width))
    }
}

