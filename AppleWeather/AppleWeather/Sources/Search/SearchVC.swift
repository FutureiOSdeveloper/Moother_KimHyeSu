//
//  SearchVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/05.
//

import UIKit
import MapKit

class SearchVC: UIViewController {
    
    public static let identifier = "SearchVC"
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()

    var delegate: UISearchBarDelegate?
    
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarUI()
        setBlur()
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.keyboardDismissMode = .onDrag
        searchBar.delegate = self
        searchCompleter.delegate = self
        
        
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    func setBlur(){
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.frame
        bgview.addSubview(visualEffectView)
        //topView.addSubview(visualEffectView)
    }
    
    func setSearchBarUI(){
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //서치바 백그라운드 컬러
            textfield.backgroundColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.0005)
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "검색", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            //서치바 텍스트입력시 색 정하기
            textfield.textColor = UIColor.white
            
        }
    }

    
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchResults.removeAll()
            tableview.reloadData()
        }
        searchCompleter.resultTypes = .address
        searchCompleter.queryFragment = searchText
    }
    
}

extension SearchVC: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        
        tableview.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("에러")
    }
}

extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = .clear
    }
    
    // 선택된 위치의 정보 가져오기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "WeatherDetail", bundle: nil)
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            
            
            print("가져온 주소", placeMark.coordinate)
            print("나라이름", placeMark.countryCode!)
            print("지역이름", placeMark.title!)
            print("위도", placeMark.coordinate.latitude)
            print("경도", placeMark.coordinate.longitude)
            
            guard let newVC = sb.instantiateViewController(withIdentifier: WeatherDetailVC.identifier) as? WeatherDetailVC else { return }
            newVC.view.backgroundColor = .blue
            newVC.locationLabel.text = placeMark.title!
            newVC.locationLatitude = placeMark.coordinate.latitude
            newVC.locationLongitude = placeMark.coordinate.longitude
            newVC.selectView.isHidden = false
            self.present(newVC, animated: true) {
                newVC.getWeather(lat: placeMark.coordinate.latitude, lon: placeMark.coordinate.longitude)
            }
        }
        
    }
    
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: SearchTVC.identifier, for: indexPath) as? SearchTVC else {
            return UITableViewCell()
        }
        
        cell.setData(title: searchResults[indexPath.row].title)
        return cell
        
    }
    
    
}
