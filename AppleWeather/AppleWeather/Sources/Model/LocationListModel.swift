//
//  LocationListModel.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/08/10.
//

import Foundation

// MARK:- 이름, 위도, 경도를 저장하는 모델
/// 이름: 보여주는 용도, 위도와 경도는 서버 통신해서 날씨정보를 받아오는 용도
struct LocationListModel {
    let locationName: String
    let locationLati: Double
    let locationLong: Double
}
