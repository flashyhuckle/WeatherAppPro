//
//  ForecastVCSUI.swift
//  WeatherAppPro
//
//  Created by Marcin Głodzik on 29/11/2023.
//

import SwiftUI

struct ForecastVCSUI: View {
    
    var viewModel: ForecastViewModel
    @State var weather: [WeatherModel]
    
    var body: some View {
        VStack {
            ForEach(0...(weather.count-1), id: \.self) { number in
                ForecastVCSUISubview(weather: weather[number])
            }
        }
        .onAppear {
            viewModel.didReceiveData = { weather in
                self.weather = weather
            }
            viewModel.viewDidLoad()
        }
    }
}

//#Preview {
//    ForecastVCSUI()
//}
