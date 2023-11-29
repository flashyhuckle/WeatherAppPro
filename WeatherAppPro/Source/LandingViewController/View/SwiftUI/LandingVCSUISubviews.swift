import SwiftUI

struct DetailWeatherSUISubview: View {

    var data: String
    var label: String
    
    var body: some View {
        VStack {
            Text(data)
                .font(.custom("Avenir-Light", size: 30))
            Text(label)
                .font(.custom("Avenir-Light", size: 20))
        }
        .padding(.horizontal)
    }
}

struct DetailWeatherSUIView: View {
    var tempMin: String
    var tempMax: String
    var pressure: String
    var wind: String
    var sunrise: String
    var sunset: String
    
    var body: some View {
        HStack {
            VStack {
                DetailWeatherSUISubview(data: tempMax, label: "Max")
                DetailWeatherSUISubview(data: tempMin, label: "Min")
            }
            VStack {
                DetailWeatherSUISubview(data: wind, label: "Wind")
                DetailWeatherSUISubview(data: pressure, label: "Pressure")
            }
            VStack {
                DetailWeatherSUISubview(data: sunrise, label: "Sunrise")
                DetailWeatherSUISubview(data: sunset, label: "Sunset")
            }
        }
        .padding(.horizontal)
    }
}

struct DateAndLocationSUIView: View {
    
    var location: String
    var date: String
    
    var body: some View {
        VStack {
            Text(location)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Avenir-Light", size: 50))
            Text(date)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Avenir-Light", size: 20))
        }
        .padding(.horizontal)
    }
}

struct MainWeatherSUIView: View {
    
    var weatherIcon: String
    var temperature: String
    var description: String
    
    
    var body: some View {
        HStack {
            Image(systemName: weatherIcon)
                .font(.custom("Avenir-Light", size: 120))
            Spacer()
            VStack {
                Text(temperature)
                    .font(.custom("Avenir-Light", size: 100))
                Text(description)
                    .font(.custom("Avenir-Light", size: 30))
            }
        }
        .padding(.horizontal)
    }
}
