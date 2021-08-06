//
//  SearchVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/05.
//

import UIKit

class SearchVC: UIViewController {
    
    public static let identifier = "SearchVC"

    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarUI()
        setBlur()
        tableview.backgroundColor = .clear
        //tableview.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        // Do any additional setup after loading the view.
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
