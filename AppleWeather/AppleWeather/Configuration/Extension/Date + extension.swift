//
//  Date + extension.swift
//  AppleWeather
//
//  Created by κΉνμ on 2021/08/15.
//
import Foundation

extension Date {
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
    
}
