import Foundation

struct ForecastResponse: Decodable {
    let list: [List]
    let city: City
    let cnt: Int

//    private enum CodingKeys: String, CodingKey {
//        case lists = "list"
//        case city
//    }

    struct List: Decodable {
        let main: Main
        let weather: [Weather]
    }

    struct Main: Decodable {
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

    struct City: Decodable {
        let name: String
    }
}
