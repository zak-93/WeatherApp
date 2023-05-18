//
//  DayView.swift
//  WeatherApp
//
//  Created by Yashin Zahar on 18.05.2023.
//

import SwiftUI

struct DayView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var day: List
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.clear)
            VStack(spacing: 0) {
                Text(viewModel.getTimeDay(time: day.dtTxt, format: .hours))
                    .padding(.top, 10)
                    .font(.custom("Inter-Regular", size: 17))
                if viewModel.getTimeDay(time: day.dtTxt, format: .hours) == "00:00" {
                    Text(viewModel.getTimeDay(time: day.dtTxt, format: .day))
                }
                Image(day.weather.first?.icon ?? "11n")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Text("\(Int(day.main.temp)) °C")
                    .font(.custom("Inter-Regular", size: 17))
                    .padding(.bottom, 10)
                
            }
            .foregroundColor(viewModel.colorText(time: viewModel.getTime()) ? .black : .white)

        }
        .frame(width: 100, height: 170)

    }
}

struct DayView_Previews: PreviewProvider {
    
    @StateObject static var viewModel = ViewModel()

    static var previews: some View {
        DayView(day: List(dt: 1, main: MainClass(temp: 10, feelsLike: 10, tempMin: 10, tempMax: 10, pressure: 1, seaLevel: 1, grndLevel: 1, humidity: 1, tempKf: 1.1), weather: [Weather(id: 1, main: .clouds, description: "1", icon: "11n")], clouds: Clouds(all: 10), wind: Wind(speed: 1.1, deg: 1, gust: 1.1), visibility: 1, pop: 1.1, sys: Sys(pod: .d), dtTxt: "13:00", rain: nil))
            .environmentObject(viewModel)
    }
}
