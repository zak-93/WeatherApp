//
//  DitailsDayView.swift
//  WeatherApp
//
//  Created by Yashin Zahar on 18.05.2023.
//

import SwiftUI

struct DitailsDayView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var day: List
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: viewModel.gradientDay(time: Int(viewModel.getTimeDay(time: day.dtTxt, format: .hour)) ?? 0)), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Text(viewModel.getTimeDay(time: day.dtTxt, format: .day))
                Text(viewModel.getTimeDay(time: day.dtTxt, format: .hours))
                Image(day.weather.first?.icon ?? "")
                Text("\(Int(day.main.temp)) °C")
                Text("Ощущается как \(Int(day.main.feelsLike)) °C")
                Text(day.weather.first?.description ?? "")
                Text("Влажность \(day.main.humidity) %")
                Text("Ветер до \(Int(day.wind.speed)) м/с")
                Spacer()
                
            }
            .font(.custom("Inter-Regular", size: 25))

            .foregroundColor(viewModel.colorText(time: Int(viewModel.getTimeDay(time: day.dtTxt, format: .hour)) ?? 0) ? .black : .white)

        }
    }
}

struct DitailsDayView_Previews: PreviewProvider {
    @StateObject static var viewModel = ViewModel()
    
    static var previews: some View {
        DitailsDayView(day: List(dt: 1, main: MainClass(temp: 10, feelsLike: 10, tempMin: 10, tempMax: 10, pressure: 1, seaLevel: 1, grndLevel: 1, humidity: 1, tempKf: 1.1), weather: [Weather(id: 1, main: .clouds, description: "ясно", icon: "11n")], clouds: Clouds(all: 10), wind: Wind(speed: 1.1, deg: 1, gust: 1.1), visibility: 1, pop: 1.1, sys: Sys(pod: .d), dtTxt: "2023-05-18 13:00:00", rain: nil))
            .environmentObject(viewModel)
    }
}
