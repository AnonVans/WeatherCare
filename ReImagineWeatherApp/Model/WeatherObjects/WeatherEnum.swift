//
//  WeatherEnum.swift
//  ReImagineWeatherApp
//
//  Created by Stevans Calvin Candra on 17/07/24.
//

import Foundation
import SwiftUI

enum UVIType: String {
    case Low
    case Moderate
    case High
    case VeryHigh
    case Extreme
    
    var text: String {
        switch self {
        case .Low:
            return String(localized: "Low")
        case .Moderate:
            return String(localized: "Moderate")
        case .High:
            return String(localized: "High")
        case .VeryHigh:
            return String(localized: "Very High")
        case .Extreme:
            return String(localized: "Extreme")
        }
    }
    
    static func getType(_ index: Int) -> UVIType {
        switch true {
        case (0...2).contains(index) : return .Low
        case (3...5).contains(index) : return .Moderate
        case (6...7).contains(index) : return .High
        case (8...10).contains(index) : return .VeryHigh
        default : return .Extreme
        }
    }
    
    static func getLevel(_ type: UVIType) -> Int {
        switch type {
        case .Low:
            return 1
        case .Moderate, .High:
            return 2
        case .VeryHigh, .Extreme:
            return 3
        }
    }
}

enum AQIType: String {
    case NoData
    case Good
    case ModerateAQ
    case UnhealthyPartly
    case Unhealthy
    case VeryUnhealthy
    case Hazardous
    
    var text: String {
        switch self {
        case .NoData:
            return ""
        case .Good:
            return String(localized: "Good")
        case .ModerateAQ:
            return String(localized: "Moderate")
        case .UnhealthyPartly:
            return String(localized: "Unhealthy For Some People")
        case .Unhealthy:
            return String(localized: "Unhealthy")
        case .VeryUnhealthy:
            return String(localized: "Very Unhealthy")
        case .Hazardous:
            return String(localized: "Hazardous")
        }
    }
    
    static func getType(_ index: Int) -> AQIType {
        switch true {
            case index < 0 : return .NoData
            case (0...50).contains(index) : return .Good
            case (51...100).contains(index) : return .ModerateAQ
            case (101...150).contains(index) : return .UnhealthyPartly
            case (151...200).contains(index) : return .Unhealthy
            case (201...300).contains(index) : return .VeryUnhealthy
            default : return .Hazardous
        }
    }
    
    static func getLevel(_ type: AQIType) -> Int {
        switch type {
        case .NoData, .Good:
            return 1
        case .ModerateAQ, .UnhealthyPartly, .Unhealthy:
            return 2
        case .VeryUnhealthy, .Hazardous:
            return 3
        }
    }
}

enum WeatherType: String {
    case ClearDay
    case Rainny
    case ClearNight
}

enum WeatherStatus: String {
    case Safe
    case Caution
    case Unsafe
    
    var textColor: Color {
        switch self {
        case .Safe:
            return .safeText
        case .Caution:
            return .cautionText
        case .Unsafe:
            return .unsafeText
        }
    }
    
    var backGroundColor: Color {
        switch self {
        case .Safe:
            return .safe
        case .Caution:
            return .caution
        case .Unsafe:
            return .unsafe
        }
    }
    
    var markBackground: Color {
        switch self {
        case .Safe:
            return .safeMark
        case .Caution:
            return .cautionMark
        case .Unsafe:
            return .unsafeMark
        }
    }
    
    func getStatusTitle() -> String {
        switch self {
        case .Safe:
            return String(localized: "Safe")
        case .Caution:
            return String(localized: "Caution")
        case .Unsafe:
            return String(localized: "Unsafe")
        }
    }
    
    func getStatusCondition() -> String {
        switch self {
        case .Safe:
            return String(localized: "Conditions are favorable. ")
        case .Caution:
            return String(localized: "Conditions require precautions. ")
        case .Unsafe:
            return String(localized: "Conditions are dangerous. ")
        }
    }
    
    func getStatusDescription(uv: UVIType, aqi: AQIType) -> String {
        let uvDesc = String(localized: "UV index is \(uv.text). ")
        var aqiDesc = ""
        if aqi != AQIType.NoData {
            aqiDesc = String(localized: "Air quality is \(aqi.text). ")
        }
        var weatherDesc: String {
            switch self {
            case .Safe:
                return String(localized: "The weather is clear. ")
            case .Caution, .Unsafe:
                return String(localized: "The weather is not ideal. ")
            }
        }
        
        return uvDesc + aqiDesc + weatherDesc
    }
    
    func getStatusInfo() -> String {
        switch self {
        case .Safe:
            return String(localized: "Enjoy your time outside without special precautions.")
        case .Caution:
            return String(localized: "Check some precautions that are needed.")
        case .Unsafe:
            return String(localized: "Avoid outdoor activities to stay safe.")
        }
    }
    
    func getContent(uv: UVIType, aqi: AQIType) -> String {
        return getStatusCondition() + getStatusDescription(uv: uv, aqi: aqi) + getStatusInfo()
    }
}
