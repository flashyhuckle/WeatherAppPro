
# WeatherAppPro

## Main Features
- Current weather in searched city or location 
- 5 day forecast for that city
- List of favorite cities

## About
App is made using MVVM-C architecture.
You can search for current weather by either typing desired city name into the search bar, chosing it from your favorite cities list or tap the location button to get weather for your current location. From landing view you can go to forecast view, which displays forecast for the next 5 days. The background gradient is set according to current weather - temperature. The app holds recently searched weather for 10 minutes. If you ask for the same city withing this time - the app will present you the same data. After that time, the repository fetches fresh one.
App is using OpenWeatherMap free API, which has some limitations for what data we can get, therefore the forecast data is "fake", meaning it uses 5 3-hour intervals which the UI presents as next 5 days.

## Planned Features
- Better error handling
- Using different data storage, not UserDefaults
- Alert when user types nonexistent city name

## UI Screenshots

<img src="https://github.com/flashyhuckle/WeatherAppPro/assets/66034170/072d761d-6121-49f8-85fc-da9486d445e9" width=20% height=20%>
<img src="https://github.com/flashyhuckle/WeatherAppPro/assets/66034170/ca58daf6-0d5e-4cec-8b12-fdb4280ae7e6" width=20% height=20%>
<img src="https://github.com/flashyhuckle/WeatherAppPro/assets/66034170/ae74f751-a109-4e02-8b5e-e7449620815f" width=20% height=20%>
