//
//  LocationListVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/01.
//

import UIKit

class LocationListVC: UIViewController {

    public static let identifier = "LocationListVC"
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableviewHeight.constant = 100 + 70*4
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: LocationListTopTVC.identifier, for: indexPath) as? LocationListTopTVC else {
                return UITableViewCell()
            }
            return cell
            
        default:
            guard let cell = tableview.dequeueReusableCell(withIdentifier: LocationListTVC.identifier, for: indexPath) as? LocationListTVC else {
                return UITableViewCell()
            }
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        default:
            return 70
        }
        
        
    }
    
    
    
    
    
}
