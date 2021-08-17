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

// MARK:- HeaderCVC 데이터 모델
/// 시간, 날씨, 온도 저장
struct DaysModel {
    let hour: String
    let weather: String
    let temperature: Int
}

struct WeekModel {
    let day: String // 요일
    let icon: Int // 날씨 아이콘
    let rainPercent: Int // 강수확률
    let maxTemp: Int // 최고기온
    let minTemp: Int // 최저기온
}
