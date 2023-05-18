//
//  ContentView.swift
//  WeatherApp
//
//  Created by Yashin Zahar on 11.05.2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var showDay = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: viewModel.gradientDay(time: viewModel.getTime())), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                if let currentWeather = viewModel.currentWeather {
                    VStack {
                        Text(currentWeather.name)
                            .font(.custom("Inter-Regular", size: 36))

                            .foregroundColor(viewModel.colorText(time: viewModel.getTime()) ? .black : .white)
                        HStack {
                            if let weatherDitail = currentWeather.weather.first {
                                Image(weatherDitail.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                VStack(alignment: .leading) {
                                    Text("\(Int(currentWeather.main.temp)) °C")
                                        .font(.custom("Inter-Regular", size: 36))
                                        .fontWeight(.bold)

                                    Text(weatherDitail.description.capitalized)
                                        .font(.custom("Inter-Regular", size: 30))

                                }
                                .foregroundColor(viewModel.colorText(time: viewModel.getTime()) ? .black : .white)

                            }
                        }
                        HStack {
                            Text("Влажность \(currentWeather.main.humidity) %")
                            Text("Ветер до \(Int(currentWeather.wind.speed)) м/с")
                        }
                        .font(.custom("Inter-Regular", size: 18))
                        .foregroundColor(viewModel.colorText(time: viewModel.getTime()) ? .black : .white)

                        Spacer()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                if let weather = viewModel.weatherFullDay?.list {
                                    ForEach(weather, id: \.self) { day in
                                        NavigationLink(destination: {
                                            DitailsDayView(day: day)
                                        }, label: {
                                            DayView(day: day)
                                        })
                                        .padding(10)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .task {
                viewModel.getCurrentWeather()
                viewModel.getAllDayWether()
            }
        }
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    
    @StateObject static var viewModel = ViewModel()
    
    static var previews: some View {
        MainView()
            .environmentObject(viewModel)
    }
}
