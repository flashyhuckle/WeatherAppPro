import SwiftUI

struct LandingVCSUI: View {
    @State private var searchText = ""
    var dismiss: (() -> Void)?
    var viewModel: LandingViewModel
    @State private var backgroundColor: Color = .black
    
    @State private var currentWeather: WeatherModel?
    
    var body: some View {
        NavigationView {
            VStack {
                DateAndLocationSUIView(
                    location: currentWeather?.locationString ?? "Kraków",
                    date: currentWeather?.dateString ?? "31.02"
                )
                
                MainWeatherSUIView(
                    weatherIcon: currentWeather?.systemIcon ?? "cloud",
                    temperature: currentWeather?.temperatureString ?? "0",
                    description: currentWeather?.description ?? "clouds"
                )
                
                DetailWeatherSUIView(
                    tempMin: currentWeather?.mintemperatureString ?? "0",
                    tempMax: currentWeather?.maxtemperatureString ?? "0",
                    pressure: currentWeather?.pressureString ?? "0",
                    wind: currentWeather?.windSpeedString ?? "0",
                    sunrise: currentWeather?.sunriseString ?? "0",
                    sunset: currentWeather?.sunsetString ?? "0"
                )
                
                HStack {
                    Button("5 day forecast", action: {}).buttonStyle(.bordered)
                        .padding()
                    NavigationLink(destination: FavoritesVCSUI(), label: { Text("Favorite cities")
                    }).buttonStyle(.bordered)
                    
                }
                
                Button("UIKit") {
                    self.dismiss?()
                }.buttonStyle(.bordered)
                
                Spacer()
                
            }
            .navigationBarItems(trailing: Button("Favorite", systemImage: "star", action: {
//                favorite pressed
            }))
            
            .navigationBarItems(leading: Button("location", systemImage: "location", action: {
                self.viewModel.onTapLocationButton()
            }))
            
            .searchable(text: $searchText, prompt: "Search city")
            .foregroundColor(.white)
            .background(backgroundColor)
            .onAppear {
                viewModel.didReceiveData = { weather in
                    currentWeather = weather[0]
                    switch currentWeather?.weatherType {
                    case .hot:
                        backgroundColor = .red
                    case .warm:
                        backgroundColor = .orange
                    case .mild:
                        backgroundColor = .yellow
                    case .cold:
                        backgroundColor = .green
                    case .freezing:
                        backgroundColor = .blue
                    case nil:
                        backgroundColor = .black
                    }
                }
                viewModel.viewDidLoad()
            }
        }
    }
}

//#Preview {
//    LandingVCSUI()
//}
