//
//  WeatherDetailVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/24.
//

import UIKit
import CoreLocation
import Moya


class WeatherDetailVC: UIViewController {
    
    //private let weatherProvider = MoyaProvider<GetWeatherService>(plugins: [MoyaLoggingPlugin()])
    private let weatherProvider = MoyaProvider<GetWeatherService>()
    var weatherData: GetWeatherModel?
    
    public static let identifier = "WeatherDetailVC"
    public static var nowLocationName : String = "기본"
    //let headerview = UIView()
    var locationLatitude: Double!
    var locationLongitude: Double!
    var index: Int = 0
    var collectionData: [String]?
    var daysData: [DaysModel] = []
    var weekData: [WeekModel] = []
    var locationTemp: Int!
    var locationTime: String!
    var maxTemp: Int!
    var minTemp: Int!
    //var location: String!
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var selectView: UIView!
    
    @IBOutlet weak var topviewHeight: NSLayoutConstraint!
    @IBOutlet weak var cityLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureDegreeLabel: UILabel!
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    
    
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    
//    lazy var locationLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        label.text = "우와아아앙ㅇ"
//        return label
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.backgroundColor = .none
        
        //locationLabel.text = "아놔"
        selectView.isHidden = true
        registerXib()
        
        
        
    }
    
    
    @IBAction func selectCancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK:- 지역 추가버튼 눌렀을 때
    @IBAction func selectAddButtonClicked(_ sender: Any) {
        // UserDefaults에 저장하기
        let newLocation = LocationClass()
        newLocation.setLocation(locationName: locationLabel.text! ,
                                locationLati: locationLatitude,
                                locationLong: locationLongitude,
                                locationTemp: locationTemp, locationTime: locationTime)
        
        //let newLocation = LocationListModel(locationName: locationLabel.text!, locationLati: locationLatitude, locationLong: locationLongitude, locationTemp: nil)
        ViewController.cityList.append(newLocation)
        
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        guard let vc = sb.instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController else {
//            return
//        }
        
       // self.presentingViewController?.presentingViewController?.presentingViewController?.becomeFirstResponder()
       
        //vc.view.reloadInputViews()
        self.presentingViewController?.presentingViewController?.presentingViewController?.removeFromParent()
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true){
            print(ViewController.cityList.count)
            //print(self.presentingViewController)
            NotificationCenter.default.post(name: NSNotification.Name("addCityNoti")
                                            ,object: newLocation)
           
            //self.reloadInputViews()
        }
        

    }
    
    
    
    func registerXib(){
        let snib = UINib(nibName: "HeaderTVC", bundle: nil)
        tableview.register(snib, forCellReuseIdentifier: "HeaderTVC")
        
        let daysnib = UINib(nibName: DaysTVC.identifier, bundle: nil)
        tableview.register(daysnib, forCellReuseIdentifier: DaysTVC.identifier)
        
        let todayNib = UINib(nibName: TodayTVC.identifier, bundle: nil)
        tableview.register(todayNib, forCellReuseIdentifier: TodayTVC.identifier)
        
        let todayDetailNib = UINib(nibName: TodayDetailTVC.identifier, bundle: nil)
        tableview.register(todayDetailNib, forCellReuseIdentifier: TodayDetailTVC.identifier)
        
        let bottomNib = UINib(nibName: BottomTVC.identifier, bundle: nil)
        tableview.register(bottomNib, forCellReuseIdentifier: BottomTVC.identifier)
    }

}



extension WeatherDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableview.contentOffset.y > 0 {
            if tableview.contentOffset.y < 60 {
                
                if labelTop.constant < 20 {
                    labelTop.constant = 20
                }
                else {
                    labelTop.constant = 80 - tableview.contentOffset.y
                    UIView.animate(withDuration: 0.5){
                        self.temperatureLabel.alpha = ((self.labelTop.constant-30)/100)
                    }
                }
            }
            else {
                UIView.animate(withDuration: 0.5){
                    self.temperatureLabel.alpha = 0
                }
            }
        }
        else {
            labelTop.constant = 80
            temperatureLabel.alpha = 1
        }
        
        for cell in tableview.visibleCells {
            let paddingToDisappear = CGFloat(200)
            let hiddenFrameHeight = scrollView.contentOffset.y + paddingToDisappear - cell.frame.origin.y
            if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                if let customCell = cell as? DaysTVC {
                    customCell.maskCell(fromTop: hiddenFrameHeight)
                }
            }
        }
    }
}

extension WeatherDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = UIView()
            view.backgroundColor = .none
            return view
        case 1:
            
            guard let headercell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as? HeaderTVC else { return UITableViewCell() }
            headercell.setData(list: daysData)
            return headercell
            
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}

extension WeatherDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 250
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        default:
            return 11
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvc = UITableViewCell()
        tvc.backgroundColor = .none
        
        if indexPath.section == 1 {
            
            switch indexPath.row {
            case 0 ... 7:
                
                guard let cell = tableview.dequeueReusableCell(withIdentifier: DaysTVC.identifier, for: indexPath) as? DaysTVC else {
                    print("dma")
                    return UITableViewCell()
                }
                cell.setData(day: weekData[indexPath.row].day,
                             icon: weekData[indexPath.row].icon,
                             percent: weekData[indexPath.row].rainPercent,
                             max: weekData[indexPath.row].maxTemp,
                             min: weekData[indexPath.row].minTemp)
                
                return cell
                
            case 8:
                guard let cell = tableview.dequeueReusableCell(withIdentifier: TodayTVC.identifier, for: indexPath) as? TodayTVC else {
                    print("여기")
                    return UITableViewCell()
                }
                cell.setData(currentState: descriptionLabel.text!, maxTemp: maxTemp, minTemp: minTemp)
                return cell
                
            case 9:
                guard let cell = tableview.dequeueReusableCell(withIdentifier: TodayDetailTVC.identifier, for: indexPath) as? TodayDetailTVC else {
                    return UITableViewCell()
                }
                
                cell.setData(contentslist: collectionData ?? ["1","1","1","1","1","1","1","1","1","1"])
                return cell
                
            case 10:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomTVC.identifier, for: indexPath) as? BottomTVC else {
                    return UITableViewCell()
                }
                cell.setData(location: locationLabel.text!)
                return cell
                
            default:
                
                return tvc
            }
            
        }
        
        return tvc
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0...7:
                return 35
            case 8:
                return 60
            case 9:
                return 250
            case 10:
                return 40
            default:
                return 100
            }
        }
        
        return 40
    }
    
}

extension WeatherDetailVC {
    
    func getWeather(locationModel: LocationClass){
        let param: RequestWeatherModel = RequestWeatherModel.init(lat: locationModel.locationLati!,
                                                                  lon: locationModel.locationLong!,
                                                                  appid: GeneralAPI.APIkey, units: "metric",
                                                                  lang: "kr")
        daysData = []
        // + viewcontroller 내용 없앴으면..
        weatherProvider.request(.getWeatherOne(param: param) ){ response  in
            switch response {
            case .success(let result):
                do {
                    self.weatherData = try result.map(GetWeatherModel.self)
                    //print("모야서버통신", self.weatherData!)
                    
                    /// 최고, 최저기온
                    self.maxTemp = Int((self.weatherData?.daily[0].temp.max)!)
                    self.minTemp = Int((self.weatherData?.daily[0].temp.min)!)
                    
                    /// 라벨 데이터
                    self.temperatureLabel.text = "\(Int((self.weatherData?.current.temp)!))"
                    self.descriptionLabel.text = self.weatherData?.current.weather[0].weatherDescription
                    locationModel.setTemp(locationTemp: Int((self.weatherData?.current.temp)!))
                    locationModel.setLocationTime(locationTime: "\((self.weatherData?.current.dt)!)".nowTime("a hh:mm",
                                                                                                          (self.weatherData?.timezoneOffset)!))
                    self.locationTime = "\((self.weatherData?.current.dt)!)".nowTime("a hh:mm",
                                                                                     (self.weatherData?.timezoneOffset)!)
                    self.locationTemp = Int((self.weatherData?.current.temp)!)
                    /// 아래 컬렉션뷰 데이터
                    self.collectionData = ["\((self.weatherData?.current.sunrise)!)".stringFromDate(),
                                           "\((self.weatherData?.current.sunset)!)".stringFromDate(),
                                           "비 올 확률",
                                           "\((self.weatherData?.current.humidity)!)%",
                                           "바람",
                                           "\(Int((self.weatherData?.current.feelsLike)!))º",
                                           "강수량",
                                           "\((self.weatherData?.current.pressure)!)hPa",
                                           "\((self.weatherData?.current.visibility)! / 1000)km",
                                           "자외선지수"]

                    for i in 1 ... 24 {
                        self.daysData.append(DaysModel(hour: "\((self.weatherData?.hourly[i].dt)!)".hourFromDate(),
                                                       weather: (self.weatherData?.hourly[i].weather[0].main)!,
                                                   temperature: Int((self.weatherData?.hourly[i].temp)!)))
                    }
                    /// 주간 날씨 (일주일) - daily
                    self.weekData = [WeekModel(day: "\((self.weatherData?.daily[0].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[0].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[0].pop)!),
                                               maxTemp: Int(((self.weatherData?.daily[0].temp.max)!)), minTemp: Int(((self.weatherData?.daily[0].temp.min)!))),
                                     WeekModel(day: "\((self.weatherData?.daily[1].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[1].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[1].pop)! * 100),
                                               maxTemp: Int(((self.weatherData?.daily[1].temp.max)!)), minTemp: Int(((self.weatherData?.daily[1].temp.min)!))),
                                     WeekModel(day: "\((self.weatherData?.daily[2].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[2].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[2].pop)! * 100),
                                               maxTemp: Int(((self.weatherData?.daily[2].temp.max)!)), minTemp: Int(((self.weatherData?.daily[2].temp.min)!))),
                                     WeekModel(day: "\((self.weatherData?.daily[3].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[3].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[3].pop)! * 100),
                                               maxTemp: Int(((self.weatherData?.daily[3].temp.max)!)), minTemp: Int(((self.weatherData?.daily[3].temp.min)!))),
                                     WeekModel(day: "\((self.weatherData?.daily[4].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[4].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[4].pop)! * 100),
                                               maxTemp: Int(((self.weatherData?.daily[4].temp.max)!)), minTemp: Int(((self.weatherData?.daily[4].temp.min)!))),
                                     WeekModel(day: "\((self.weatherData?.daily[5].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[5].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[5].pop)! * 100),
                                               maxTemp: Int(((self.weatherData?.daily[5].temp.max)!)), minTemp: Int(((self.weatherData?.daily[5].temp.min)!))),
                                     WeekModel(day: "\((self.weatherData?.daily[6].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[6].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[6].pop)! * 100),
                                               maxTemp: Int(((self.weatherData?.daily[6].temp.max)!)), minTemp: Int(((self.weatherData?.daily[6].temp.min)!))),
                                     WeekModel(day: "\((self.weatherData?.daily[7].dt)!)".weekdayFromDate(),
                                               icon: (self.weatherData?.daily[7].weather[0].main)!, rainPercent: Int((self.weatherData?.daily[7].pop)! * 100),
                                               maxTemp: Int(((self.weatherData?.daily[7].temp.max)!)), minTemp: Int(((self.weatherData?.daily[7].temp.min)!)))
                    ]
                    
                    
                    self.tableview.reloadData()
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    
                    
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
                
            case .failure(let err):
                print("에러", err.localizedDescription)
            }
        }
    }
}
