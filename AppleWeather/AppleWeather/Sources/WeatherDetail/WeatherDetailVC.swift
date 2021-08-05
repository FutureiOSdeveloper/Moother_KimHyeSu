//
//  WeatherDetailVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/24.
//

import UIKit
import CoreLocation

class WeatherDetailVC: UIViewController {
    
    public static let identifier = "WeatherDetailVC"
    
    //let headerview = UIView()
    
    
    
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
        tableview.backgroundColor = .none
        tableview.delegate = self
        tableview.dataSource = self
        
        print(labelTop.constant)
        //getLocation()
        
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
            //headerview.addSubview(headercell)
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
        return 200
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
                return 200
            case 10:
                return 40
            default:
                return 100
            }
        }
        
        return 40
    }
    
}

