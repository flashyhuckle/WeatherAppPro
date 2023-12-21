import Foundation

struct ForecastResponse: Decodable {
    let list: [List]
    let city: City
    let cnt: Int

    struct List: Decodable {
        let main: Main
        let weather: [Weather]
        let wind: Wind
    }

    struct Main: Decodable {
        let temp: Float
        let temp_min: Float
        let temp_max: Float
        let pressure: Int?
        let humidity: Int?
    }

    struct Weather: Decodable {
        let main: String
        let description: String
        let icon: String
    }
    
    struct Wind: Decodable {
        let speed: Float
    }

    struct City: Decodable {
        let name: String
        let country: String
        let sunrise: Int
        let sunset: Int
        let timezone: Int
    }
}
