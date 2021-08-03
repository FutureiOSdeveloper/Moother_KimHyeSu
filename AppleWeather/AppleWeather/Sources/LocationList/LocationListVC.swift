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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        

    }


}

extension LocationListVC : UITableViewDelegate {
    
    
}

extension LocationListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: LocationListTVC.identifier, for: indexPath) as? LocationListTVC else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
    
    
}
