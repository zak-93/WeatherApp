//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Yashin Zahar on 17.05.2023.
//

import Foundation
import Alamofire

enum Link {
    case currentWeather
    case allDaysWeather
    
    var url: URL {
        switch self {
            
        case .currentWeather:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Novosibirsk&lang=ru&appid=35af60600d37343e1036490eec5c270f&units=metric")!
        case .allDaysWeather:
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Novosibirsk&lang=ru&appid=35af60600d37343e1036490eec5c270f&units=metric")!
        }
    }
}

func decode<T: Decodable>(_ data: Data) -> T? {
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        print(error)
        return nil
    }
}

enum NetworkError: Error {
    case noData
    case tooManyRequests
    case decodingError
}

final class NetworkManager {
    
    
    
    
    
    func fetchCurrentDay(from url: URL, complition: @escaping(Result<WeatherCurrent, NetworkError>) ->()) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                case .success(let currectData):
                    if let modal = self.parseWeatherCurrent(currectData) {
                        complition(.success(modal))
                    }
                case .failure(let afError ):
                    print("AF Error: \(afError.localizedDescription)")
                    if responseData.response?.statusCode == 429 {
                        complition(.failure(.tooManyRequests))
                    } else {
                        complition(.failure(.noData))
                    }
                }
            }
    }
    
    func fetchAllDay(from url: URL, complition: @escaping(Result<WeatherAllDay, NetworkError>) ->()) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                case .success(let currectData):
                    if let modal = self.parseWeatherAllDay(currectData) {
                        complition(.success(modal))
                    }
                case .failure(let afError ):
                    print("AF Error: \(afError.localizedDescription)")
                    if responseData.response?.statusCode == 429 {
                        complition(.failure(.tooManyRequests))
                    } else {
                        complition(.failure(.noData))
                    }
                }
            }
    }
    
    private func parseWeatherCurrent(_ data: Data) -> WeatherCurrent? {
        var modal: WeatherCurrent? = nil
        if let decoded: WeatherCurrent = decode(data) {
            modal = decoded
        }
        return modal
    }
    
    private func parseWeatherAllDay(_ data: Data) -> WeatherAllDay? {
        var modal: WeatherAllDay? = nil
        if let decoded: WeatherAllDay = decode(data) {
            modal = decoded
        }
        return modal
    }
    
}
