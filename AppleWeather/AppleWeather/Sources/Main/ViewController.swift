//
//  ViewController.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/24.
//

import UIKit
import Lottie
import CoreLocation
import Moya

class ViewController: UIViewController, CLLocationManagerDelegate {

    public static let identifier = "ViewController"
    
    //public static var cityList : [String] = []
    public static var cityList: [LocationClass] = [LocationClass()]
    public static var vcList : [WeatherDetailVC] = []
   

    var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double? // 위도
    var longitude: Double?// 경도
    
    public static var nowLocation = CLLocation(latitude: 0, longitude: 0)
    var locationName : String?
    
    /// 로티뷰 추가
    lazy var lottieView : AnimationView = {
        let animationView = AnimationView(name: "4800-weather-partly-cloudy")
        animationView.frame = CGRect(x: 0, y: 0, width: 230, height: 230)
        animationView.center.x = self.view.center.x
        animationView.center.y = self.view.center.y - 100
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .loop
        animationView.isHidden = false
        return animationView
    }()
    

    @IBOutlet var allView: UIView!
    @IBOutlet weak var bgLottieView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var containviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var vccontain: UIView!
    @IBOutlet weak var scrollcontentsview: UIView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //+화면초기화 추가
        //removeFromParent()
        //super.viewWillAppear(true)
        super.viewWillAppear(animated)
        ViewController.vcList = []
        getLocation()
        setupPageControl()
        
        print("viewWillAppear호출")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bgLottieView.addSubview(lottieView)
        //setDummy()
        
        print("ViewDidLoad호출")
        NotificationCenter.default.addObserver(self, selector: #selector(pageChange), name: Notification.Name("noti1"), object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cityAdd),
                                               name: Notification.Name("addCityNoti"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cityDelete),
                                               name: Notification.Name("deleteCityNoti"),
                                               object: nil)
    }
    
    @objc func cityDelete(notification: NSNotification){
        //self.removeFromParent()
        print("삭제")
        
        guard let deleteIndex = notification.object as? Int else {
            return
        }
        
        ViewController.vcList.remove(at: deleteIndex)
        self.viewWillAppear(true)
        //containerView.removeFromSuperview()
//        containviewWidth.constant -= UIScreen.main.bounds.width
//        scrollview.inputViewController?.reloadInputViews()
//        scrollview.reloadInputViews()
//        pagecontrol.numberOfPages -= 1
        
    }
    
    @objc func cityAdd(notification: NSNotification){
        //self.becomeFirstResponder()
        
        print(self)
        //self.removeFromParent()
       // ViewController.vcList = []
        self.viewWillAppear(true)
        print("추가")
//
//        guard let vc = UIStoryboard(name: "WeatherDetail", bundle: nil).instantiateViewController(withIdentifier: WeatherDetailVC.identifier) as? WeatherDetailVC else {
//            return
//        }
//        self.addChild(vc)
        
        //containviewWidth.constant += UIScreen.main.bounds.width
        //pagecontrol.numberOfPages += 1
        
        
        
        
        //self.removeFromParent()
//        self.scrollview.reloadInputViews()
//        self.containView.reloadInputViews()
//        self.view.reloadInputViews()
        
        //self.getLocation()
        
        //self.viewWillAppear(true)
        
       
//        let sb = UIStoryboard(name: "WeatherDetail", bundle: nil)
//        guard let addLocation = notification.object as? LocationClass else {
//            return
//        }
//
//        if let vc = sb.instantiateViewController(withIdentifier: WeatherDetailVC.identifier) as? WeatherDetailVC {
//            let containerView = UIView()
//            containerView.frame = UIScreen.main.bounds
//            containerView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(ViewController.cityList.count - 1)
//            containView.addSubview(containerView)
//            containerView.addSubview(vc.view)
//            vc.locationLabel.text = addLocation.locationName
//            vcList.append(vc)
//            let locationModel = LocationClass()
//            locationModel.setLocation(locationName: addLocation.locationName!,
//                                      locationLati: addLocation.locationLati!,
//                                      locationLong: addLocation.locationLong!, locationTemp: nil)
//            vc.getWeather(locationModel: locationModel)
//            vc.reloadInputViews()
//                    }
//        else { return }
//
//        containviewWidth.constant += UIScreen.main.bounds.width
//
//        scrollview.reloadInputViews()
//        pagecontrol.numberOfPages += 1
    }
    
    // MARK:- getLocation() 현재 위치 받아오기
    func getLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            
            /// 현재 위도와 경도 가져오기
            let location = locationManager.location?.coordinate
            /// 가져온 현재 위도와 경도 저장
            latitude = location?.latitude ?? 50
            longitude = location?.longitude ?? 50
            
            /// 현재 위치 nowLocation에 저장
            ViewController.nowLocation = CLLocation(latitude: latitude!, longitude: longitude!)
            print(ViewController.nowLocation)
            
            /// 위도 경도->주소변환
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(ViewController.nowLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in if let address: [CLPlacemark] = placemarks { if let name: String = address.last?.locality { print(name)
                
                /// 첫번째 cityList[0]에 현재 위치 저장
                let locationList = LocationClass()
                locationList.setLocation(locationName: name, locationLati: self.latitude!, locationLong: self.longitude!, locationTemp: nil, locationTime: nil)
                ViewController.cityList[0] = locationList
                
                print("ViewController.cityList[0]: ", ViewController.cityList[0])
                //ViewController.vcList = []
                
                /// 현재 위치를 다 받아왔기에 이제 UI 설정 시작
                self.setScrollviewUI()
            }
            }
            })
        }}
    
    
    // MARK:- ScrollViewUI 설정
    func setScrollviewUI(){
        
        scrollview.delegate = self
        print("setScrollUI")
       
        /// ViewController.cityList 만큼 돌면서 (index)
        for index in 0..<ViewController.cityList.count {
            
            /// WeatherDetailVC를 담을 view (containerView)를 생성한다.
            let containerView = UIView()
            
            /// 새로운 뷰컨 인스턴스 생성
            let sb = UIStoryboard(name: "WeatherDetail", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: WeatherDetailVC.identifier) as? WeatherDetailVC {
                
                containerView.frame = UIScreen.main.bounds
                
                // index = 0 이면 origin.x == 0, index = 1 이면 origin.x == 1 ...
                containerView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(index)
                
                // 스크롤뷰 내부 뷰인 'containView'에 addSubview 해준다.
                containView.addSubview(containerView)
                
                containerView.addSubview(vc.view)
                
              //  vc.reloadInputViews()
                vc.index = index
                vc.locationLabel.text = ViewController.cityList[index].locationName
                //print("잘 받아와졌는지", ViewController.cityList[index].locationLong)
                vc.getWeather(locationModel: ViewController.cityList[index])
                
                //vc.reloadInputViews()
                ViewController.vcList.append(vc)
            
            }
            else { return }
            
        }
        
        containviewWidth.constant = UIScreen.main.bounds.width * CGFloat(ViewController.cityList.count-1)
        
        scrollview.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(ViewController.cityList.count), height: UIScreen.main.bounds.height
        )
        
        scrollview.alwaysBounceVertical = false
        print("몇개나오는지", ViewController.cityList.count)
        pagecontrol.numberOfPages = ViewController.cityList.count
        
    }
    
    func setDummy(){
        let locationFirst = LocationClass()
        locationFirst.setLocation(locationName: "현재위치", locationLati: 0, locationLong: 0, locationTemp: nil, locationTime: nil)
        ViewController.cityList.append(locationFirst)
        

    }
    
    func setupPageControl() {
         pagecontrol.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0)
    }
    
    @objc func pageChange(notification: NSNotification){
        pagecontrol.currentPage = notification.object as! Int
        self.scrollview.contentOffset.x = UIScreen.main.bounds.width * CGFloat(self.pagecontrol.currentPage)
        
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
        //vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagecontrol.currentPage = Int(floor(scrollview.contentOffset.x / UIScreen.main.bounds.width))
    }
}

