import Foundation

struct CurrentResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    let sys: Sys
    let wind: Wind
    
    struct Weather: Decodable {
        let icon: String
        let description: String
    }
    
    struct Main: Decodable {
        let temp: Float
        let pressure: Int
        let humidity: Int
        let temp_min: Float
        let temp_max: Float
    }
    
    struct Sys: Decodable {
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    
    struct Wind: Decodable {
        let speed: Float
    }
}
