//
//  LocationListVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/01.
//

import UIKit

class LocationListVC: UIViewController {

    public static let identifier = "LocationListVC"
    var select : Bool = true
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var temperatureButton: UIButton!
    @IBOutlet weak var footerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonUI(selected: select)
    
        tableview.delegate = self
        tableview.dataSource = self
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.backgroundColor = .black
        tableview.tableFooterView = footerView
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cityAdd),
                                               name: Notification.Name("addCityNoti"),
                                               object: nil)

    }
    
    // MARK:- 지역 추가시
    @objc func cityAdd(notification: NSNotification){
        tableview.reloadData()
    }
    
    func setButtonUI(selected : Bool){
        
        let attributedStr = NSMutableAttributedString(string: (temperatureButton.titleLabel?.text)!)
        if selected == true {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.white, range: ((temperatureButton.titleLabel?.text)! as NSString).range(of: "ºC"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.gray, range: ((temperatureButton.titleLabel?.text)! as NSString).range(of: "/ ºF"))
        }
        else {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.white, range: ((temperatureButton.titleLabel?.text)! as NSString).range(of: "ºF"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.gray, range: ((temperatureButton.titleLabel?.text)! as NSString).range(of: "ºC /"))
        }
        
        temperatureButton.setAttributedTitle(attributedStr, for: .normal)
        select = !select
        
    }

    @IBAction func temperatureButtonClicked(_ sender: Any) {
        
        setButtonUI(selected: select)
        tableview.reloadData()

    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SearchVC.identifier) as? SearchVC else { return }
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension LocationListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)선택됨")
        self.dismiss(animated: true){
            //notificationcenter
            
            NotificationCenter.default.post(name: NSNotification.Name("noti1"), object: indexPath.row)
        }
    }
    
    
    
}

extension LocationListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: LocationListTVC.identifier, for: indexPath) as? LocationListTVC else {
                return UITableViewCell()
            }
            cell.setData(time: ViewController.cityList[indexPath.row].locationName!,
                         location: "나의위치",
                         temperature: ViewController.cityList[indexPath.row].locationTemp ?? 0,
                         celsius: !select)
            return cell
            
        default:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: LocationListTVC.identifier, for: indexPath) as? LocationListTVC else {
                return UITableViewCell()
            }
            cell.setData(time: ViewController.cityList[indexPath.row].locationTime ?? "아직..",
                         location: ViewController.cityList[indexPath.row].locationName!,
                         temperature: ViewController.cityList[indexPath.row].locationTemp ?? 0 , celsius: !select)
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        default:
            return 70
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            // MARK:- 지역 밀어서 삭제
            if editingStyle == .delete {
                
                ViewController.cityList.remove(at: indexPath.row)
                
                /// 노티로 메인 ViewController 리로드 하도록 하기
                NotificationCenter.default.post(name: NSNotification.Name("deleteCityNoti")
                                                ,object: indexPath.row)
                
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
            } else if editingStyle == .insert {
                
            }
        }
    
    
}
