//
//  ViewController + Extension.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/06.
//

import Foundation
import UIKit

extension UIViewController {
    
    func dismissKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer =
                UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            tap.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
}
