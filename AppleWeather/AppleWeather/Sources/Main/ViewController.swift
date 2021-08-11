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

    //public static var cityList : [String] = []
    public static var cityList: [LocationListModel] = []
    var vcList : [UIViewController] = []
    
    private let weatherProvider = MoyaProvider<GetWeatherService>()
    var weatherData: GetWeatherModel?
    
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double? // 위도
    var longitude: Double?// 경도
    
    public static var nowLocation = CLLocation(latitude: 0, longitude: 0)
    var locationName : String?
    
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
        //getWeather(lat: 37.0, lon: 127.0)
        setDummy()
        getLocation()
        setupPageControl()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pageChange), name: Notification.Name("noti1"), object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cityAdd),
                                               name: Notification.Name("addCityNoti"),
                                               object: nil)
    }
    
    @objc func cityAdd(notification: NSNotification){
        let containerView = UIView()
        let sb = UIStoryboard(name: "WeatherDetail", bundle: nil)
        guard let addLocation = notification.object as? LocationListModel else {
            return
        }
        
        if let vc = sb.instantiateViewController(withIdentifier: WeatherDetailVC.identifier) as? WeatherDetailVC {
            //vc.locationLabel.text = cityList[index]
            containerView.frame = UIScreen.main.bounds
            containerView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(ViewController.cityList.count - 1)
            containView.addSubview(containerView)
            containerView.addSubview(vc.view)
            //let locationList =
            vc.locationLabel.text = addLocation.locationName
            
            vcList.append(vc)
            vc.reloadInputViews()
                    }
        else { return }
        
        containviewWidth.constant += UIScreen.main.bounds.width
        
        scrollview.reloadInputViews()
        pagecontrol.numberOfPages += 1
    }
    
    // MARK:- getLocation() 현재 위치 받아오기
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
            latitude = location?.latitude ?? 50
            longitude = location?.longitude ?? 50
            
            //print("위도: \(latitude), 경도: \(longitude)")
            
            ViewController.nowLocation = CLLocation(latitude: latitude!, longitude: longitude!)
            print(ViewController.nowLocation)
            
            /// 위도 경도->주소변환
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(ViewController.nowLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in if let address: [CLPlacemark] = placemarks { if let name: String = address.last?.name { print(name)
                //ViewController.cityList[0] = name
                ViewController.cityList[0] = LocationListModel(locationName: name,
                                                               locationLati: self.latitude!,
                                                               locationLong: self.longitude!)
                print("ViewController.cityList[0]: ", ViewController.cityList[0])
                self.setScrollviewUI()
            } //전체 주소
            }
            })
        }}
    
    
    func setScrollviewUI(){
        scrollview.delegate = self

        for index in 0..<ViewController.cityList.count {
            
            
            let containerView = UIView()
            let sb = UIStoryboard(name: "WeatherDetail", bundle: nil)
            
            if let vc = sb.instantiateViewController(withIdentifier: WeatherDetailVC.identifier) as? WeatherDetailVC {
                //vc.locationLabel.text = cityList[index]
                containerView.frame = UIScreen.main.bounds
                containerView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(index)
                containView.addSubview(containerView)
                containerView.addSubview(vc.view)
                
                vc.locationLabel.text = ViewController.cityList[index].locationName
                print("잘 받아와졌는지", ViewController.cityList[index].locationLong)
                
                getWeather(lat: ViewController.cityList[index].locationLati,
                           lon: ViewController.cityList[index].locationLong)
                vc.reloadInputViews()
                vcList.append(vc)
            }
            else { return }
            
        }
        
        containviewWidth.constant = UIScreen.main.bounds.width * CGFloat(ViewController.cityList.count-1)
        
        scrollview.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(ViewController.cityList.count), height: UIScreen.main.bounds.height
        )
        
        scrollview.alwaysBounceVertical = false
        //scrollview.alwaysBounceHorizontal = false
        pagecontrol.numberOfPages = ViewController.cityList.count
        
    }
    
    func setDummy(){
        ViewController.cityList.append(contentsOf: [LocationListModel(locationName: "현재위치", locationLati: 0, locationLong: 0)])
        
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
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagecontrol.currentPage = Int(floor(scrollview.contentOffset.x / UIScreen.main.bounds.width))
    }
}

extension ViewController {
    
    func getWeather(lat: Double, lon: Double){
        let param: RequestWeatherModel = RequestWeatherModel.init(lat: lat, lon: lon, appid: GeneralAPI.APIkey, units: "metric")
        
        // 일단 서버통신 완료.
        //let param: RequestWeatherModel = RequestWeatherModel.init(lat: 37, lon: 127, appid: GeneralAPI.APIkey, units: "metric")
        
        weatherProvider.request(.getWeather(param: param) ){ response in
            switch response {
            case .success(let result):
                do {
                    self.weatherData = try result.map(GetWeatherModel.self)
                    print("모야서버통신", self.weatherData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print("에러", err.localizedDescription)
            }
        }
    }
}
