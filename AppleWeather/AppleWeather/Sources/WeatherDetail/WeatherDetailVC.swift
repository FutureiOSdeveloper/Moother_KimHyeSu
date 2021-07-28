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
        tableview.backgroundColor = .none
        print(labelTop.constant)
        
        let snib = UINib(nibName: "HeaderTVC", bundle: nil)
        tableview.register(snib, forCellReuseIdentifier: "HeaderTVC")
                
        
    }
}

extension WeatherDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(tableview.contentOffset.y)
        //print("labeltop",labelTop.constant)
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
    }
}

extension WeatherDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
                case 0:
                    let view = UIView()
                    view.backgroundColor = .black
                    return view
                case 1:
                    let headerview = UIView()
                    guard let headercell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as? HeaderTVC else { return UIView() }
                    headerview.addSubview(headercell)
                    return headerview
                    
            
                default:
                    return UIView()
                }
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
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

