//
//  String + Extension.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/15.
//

import Foundation

extension String {
    
    /// UTC -> 오전/오후 시간:분 반환
    func stringFromDate() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(Double(self)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date as Date)
    }
    
    /// UTC -> 요일반환
    func weekdayFromDate() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(Double(self)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date as Date)
    }
    
    /// UTC -> 시간 반환
    func hourFromDate() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(Double(self)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h시"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date as Date)
    }
    
    
    /// 현재시간
    func nowTime(_ format: String, _ timezone: Int) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return dateFormatter.string(from: date as Date)
    }
    
}
