//
//  RequestWeatherModel.swift
//  AppleWeather
//
//  Created by κΉνμ on 2021/08/11.
//

import Foundation

struct RequestWeatherModel: Codable {
    var lat: Double
    var lon: Double
    var appid: String
    var units: String
    var lang: String
    //var exclude: String
}
