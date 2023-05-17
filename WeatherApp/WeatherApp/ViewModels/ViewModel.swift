//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Yashin Zahar on 17.05.2023.
//

import Foundation

class ViewModel: ObservableObject {
    
    var networkManager = NetworkManager()
    
    @Published var currentWeather: WeatherCurrent? = nil
    @Published var weatherFullDay: WeatherAllDay? = nil
    
    func getCurrentWeather() {
        networkManager.fetchCurrentDay(from: Link.currentWeather.url) { result in
            switch result {
            case .success(let data):
                self.currentWeather = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAllDayWether() {
        networkManager.fetchAllDay(from: Link.allDaysWeather.url) { result in
            switch result {
            case .success(let data):
                self.weatherFullDay = data
            case .failure(let error):
                print(error)
            }
        }
    }
}
