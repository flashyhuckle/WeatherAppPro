import SwiftUI

struct LandingVCSUI: View {
    @State private var searchText = ""
    var goToUIKIT: (() -> Void)?
    @State var viewModel: LandingViewModel
    
    @State private var backgroundColor: Color = .black
    @State var currentWeather: WeatherModel
    
    @StateObject var favorites = Favorites()
    
    var body: some View {
        NavigationView {
            VStack {
                DateAndLocationSUIView(
                    location: viewModel.currentWeather.locationString,
                    date: viewModel.currentWeather.dateString
                )
                
                MainWeatherSUIView(
                    weatherIcon: viewModel.currentWeather.systemIcon,
                    temperature: viewModel.currentWeather.temperatureString,
                    description: viewModel.currentWeather.descriptionString
                )
                
                DetailWeatherSUIView(
                    tempMin: viewModel.currentWeather.mintemperatureString,
                    tempMax: viewModel.currentWeather.maxtemperatureString,
                    pressure: viewModel.currentWeather.pressureString,
                    wind: viewModel.currentWeather.windSpeedString,
                    sunrise: viewModel.currentWeather.sunriseString,
                    sunset: viewModel.currentWeather.sunsetString
                )
                
                HStack {
                    NavigationLink(destination: ForecastVCSUI(viewModel: ForecastViewModel(apiManager: ApiManager(), currentWeather: viewModel.currentWeather), weather: [WeatherModel.example]), label: { Text("5 day forecast")
                    }).buttonStyle(.bordered)
                    
                        .padding()
                    
                    NavigationLink(destination: FavoritesVCSUI(didTapCell: viewModel.searchBy(cityName:), viewModel: FavoritesViewModel(favorites: favorites)), label: { Text("Favorite cities")
                    }).buttonStyle(.bordered)
                    
                }
                
                Button("UIKit") {
                    viewModel.UIButtonPressed()
                }.buttonStyle(.bordered)
                
                Spacer()
                
            }
            .navigationBarItems(trailing: Button("Favorite", systemImage: favorites.contains(viewModel.currentWeather.cityName) ? "star.fill" : "star", action: {
                favorites.buttonTapped(viewModel.currentWeather.cityName)
            }))
            
            .navigationBarItems(leading: Button("location", systemImage: "location", action: {
                self.viewModel.onTapLocationButton()
            }))
            
            .searchable(text: $searchText, prompt: "Search city")
            .onSubmit(of: .search) {
                viewModel.searchBy(cityName: searchText)
                searchText = ""
            }
            
            .foregroundColor(.white)
            .background(backgroundColor)
            .onAppear {
                viewModel.didReceiveData = { weather in
                    currentWeather = weather[0]
                    switch currentWeather.weatherType {
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
