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
    
    private let weatherProvider = MoyaProvider<GetWeatherService>(plugins: [MoyaLoggingPlugin()])
    var weatherData: GetWeatherModel?
    
    public static let identifier = "WeatherDetailVC"
    public static var nowLocationName : String = "기본"
    //let headerview = UIView()
    var locationLatitude: Double!
    var locationLongitude: Double!
    var index: Int = 0
    var collectionData: [String]?
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var selectView: UIView!
    
    @IBOutlet weak var topviewHeight: NSLayoutConstraint!
    @IBOutlet weak var cityLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureDegreeLabel: UILabel!
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    
    
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getWeather(lat: ViewController.cityList[index].locationLati,
//                   lon: ViewController.cityList[index].locationLong)
        tableview.backgroundColor = .none
        
        locationLabel.text = "아놔"
        selectView.isHidden = true
        registerXib()
        
        
        
    }
    
    
    @IBAction func selectCancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectAddButtonClicked(_ sender: Any) {
        // UserDefaults에 저장하기
        let newLocation = LocationListModel(locationName: locationLabel.text!, locationLati: locationLatitude, locationLong: locationLongitude)
        ViewController.cityList.append(newLocation )
        NotificationCenter.default.post(name: NSNotification.Name("addCityNoti")
                                        ,object: newLocation)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        

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
                    print("여기")
                    return UITableViewCell()
                }
                
                return cell
                
            case 8:
                guard let cell = tableview.dequeueReusableCell(withIdentifier: TodayTVC.identifier, for: indexPath) as? TodayTVC else {
                    print("여기")
                    return UITableViewCell()
                }
                
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
    
    func getWeather(lat: Double, lon: Double){
        let param: RequestWeatherModel = RequestWeatherModel.init(lat: lat, lon: lon, appid: GeneralAPI.APIkey, units: "metric")
        
        weatherProvider.request(.getWeatherOne(param: param) ){ response in
            switch response {
            case .success(let result):
                do {
                    self.weatherData = try result.map(GetWeatherModel.self)
                    print("모야서버통신", self.weatherData)
                    self.temperatureLabel.text = "\(Int((self.weatherData?.current.temp)!))"
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
