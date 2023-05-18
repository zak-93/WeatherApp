//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Yashin Zahar on 11.05.2023.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
