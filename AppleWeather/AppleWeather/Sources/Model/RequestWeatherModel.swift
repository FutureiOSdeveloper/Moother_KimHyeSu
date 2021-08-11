//
//  RequestWeatherModel.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/11.
//

import Foundation

struct RequestWeatherModel: Codable {
    var lat: Double
    var lon: Double
    var appid: String
    var units: String
}
