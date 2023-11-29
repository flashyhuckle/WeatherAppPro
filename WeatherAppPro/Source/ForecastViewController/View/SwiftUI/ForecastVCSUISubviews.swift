import SwiftUI

struct ForecastVCSUISubview: View {
    
    var weather: WeatherModel
    
    var body: some View {
        HStack {
            ForecastVCSUIMainSubview(date: weather.shortDateString, icon: weather.systemIcon)
            VStack {
                ForecastVCSUIDetailSubview(data: weather.maxtemperatureString, label: "Max")
                ForecastVCSUIDetailSubview(data: weather.mintemperatureString, label: "Min")
            }
            VStack {
                ForecastVCSUIDetailSubview(data: weather.pressureString, label: "Pressure")
                ForecastVCSUIDetailSubview(data: weather.windSpeedString, label: "Wind")
            }
        }
    }
}

struct ForecastVCSUIDetailSubview: View {
    var data: String
    var label: String
    
    var body: some View {
        VStack {
            Text(data)
                .font(.custom("Avenir-Light", size: 20))
            Text(label)
                .font(.custom("Avenir-Light", size: 15))
        }
        .padding(.horizontal)
    }
}

struct ForecastVCSUIMainSubview: View {
    var date: String
    var icon: String
    
    var body: some View {
        VStack {
            Text(date)
                .font(.custom("Avenir-Light", size: 25))
            Image(systemName: icon)
                .font(.custom("Avenir-Light", size: 80))
            
        }
    }
}

#Preview {
    ForecastVCSUISubview(weather: WeatherModel.example)
}
