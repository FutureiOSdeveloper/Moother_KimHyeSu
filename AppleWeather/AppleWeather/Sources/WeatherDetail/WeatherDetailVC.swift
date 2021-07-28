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
    @IBOutlet weak var cityLabelTop: NSLayoutConstraint!
    
    @IBOutlet weak var temperatureView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureDegreeLabel: UILabel!
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
}

extension WeatherDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(tableview.contentOffset.y)
        print("labeltop",labelTop.constant)
        if tableview.contentOffset.y > 0 {
            if tableview.contentOffset.y < 70 {
                labelTop.constant = 100 - tableview.contentOffset.y
            }
        }
        else {
            labelTop.constant = 100
        }
    }
}

extension WeatherDetailVC: UITableViewDelegate {
    
}

extension WeatherDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let view = UIView()
            view.backgroundColor = .black
            return view
        case 1:
            return topview
        default:
            return UIView()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        default:
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

