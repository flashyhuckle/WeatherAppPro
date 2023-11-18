import Foundation

struct CurrentResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    
    struct Weather: Decodable {
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Float
        let pressure: Int
        let humidity: Int
    }
}
