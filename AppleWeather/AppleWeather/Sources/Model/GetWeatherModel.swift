//
//  GetWeatherModel.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/11.
//



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - GetWeatherModel
struct GetWeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main?
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = (try? values.decode(Double.self, forKey: .temp)) ?? 0.0
        feelsLike = (try? values.decode(Double.self, forKey: .feelsLike)) ?? 0.0
        tempMin = (try? values.decode(Double.self, forKey: .tempMin)) ?? 0.0
        tempMax = (try? values.decode(Double.self, forKey: .tempMax)) ?? 0.0
        pressure = (try? values.decode(Int.self, forKey: .pressure)) ?? 0
        humidity = (try? values.decode(Int.self, forKey: .humidity)) ?? 0
        seaLevel = (try? values.decode(Int.self, forKey: .seaLevel)) ?? 0
        grndLevel = (try? values.decode(Int.self, forKey: .grndLevel)) ?? 0
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = (try? values.decode(Int.self, forKey: .type )) ?? 0
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        country = (try? values.decode(String.self, forKey: .country)) ?? ""
        sunrise = (try? values.decode(Int.self, forKey: .sunrise)) ?? 0
        sunset = (try? values.decode(Int.self, forKey: .sunset)) ?? 0
        
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
}
