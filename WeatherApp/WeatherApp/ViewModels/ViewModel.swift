//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Yashin Zahar on 17.05.2023.
//

import Foundation
import SwiftUI

enum FormatTime {
    case hours
    case day
    case hour
}

class ViewModel: ObservableObject {
    
    private var networkManager = NetworkManager()
    
    @Published var currentWeather: WeatherCurrent? = nil
    @Published var weatherFullDay: WeatherAllDay? = nil
    
    public func getCurrentWeather() {
        networkManager.fetchCurrentDay(from: Link.currentWeather.url) { result in
            switch result {
            case .success(let data):
                self.currentWeather = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getAllDayWether() {
        networkManager.fetchAllDay(from: Link.allDaysWeather.url) { result in
            switch result {
            case .success(let data):
                self.weatherFullDay = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTimeDay(time: String, format: FormatTime) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
        guard let dateFromStr = dateFormatter.date(from: time) else { return ""}
        switch format {
        case .hours:
            dateFormatter.dateFormat = "HH:mm"
        case .day:
            dateFormatter.dateFormat = "dd MMM"
        case .hour:
            dateFormatter.dateFormat = "HH"
        }
        let timeFromDate = dateFormatter.string(from: dateFromStr)
        return timeFromDate
    }
    
    func getTime() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss Z"
        let dateString = dateFormatter.string(from: date)
        guard let dateFromStr = dateFormatter.date(from: dateString) else { return 0}
        dateFormatter.dateFormat = "HH"
        guard let timeFromDate = Int(dateFormatter.string(from: dateFromStr)) else { return 0}
        return timeFromDate
    }
    
    func colorText(time: Int) -> Bool {
        switch time {
        case 5...17:
            return true
        default:
            return false
        }
    }
    
    func gradientDay(time: Int) -> [Color] {
        switch time {
        case 5...11:
            return [.colorMorning1, .colorMorning2]
        case 12...17:
            return [.colorDay1, .colorDay2]
        case 18...23:
            return [.colorEvening1, .colorEvening2]
        default:
            return [.colorNight1, .colorNight2]
        }
    }
}
