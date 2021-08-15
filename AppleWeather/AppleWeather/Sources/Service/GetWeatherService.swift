//
//  GetWeatherService.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/11.
//

import Foundation
import Moya

enum GetWeatherService {
    //case getWeather(_ lat: Double? = nil, _ lon: Double? = nil, _ appid: String? = nil, _ units: String? = nil)
    case getWeatherOne(param: RequestWeatherModel)
}

extension GetWeatherService: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        
        case .getWeatherOne(_):
            return "/data/2.5/onecall"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        
        case .getWeatherOne(_):
            return URLEncoding.default
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherOne(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getWeatherOne(let param):
            
            return .requestParameters(parameters: try! param.asDictionary() , encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
