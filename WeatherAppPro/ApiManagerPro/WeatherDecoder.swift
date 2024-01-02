import Foundation

struct WeatherDecoder {
    let decoder = JSONDecoder()
    
    func decodeCurrent(data: Data) throws -> [WeatherModel] {
        do {
            let decoded = try decoder.decode(CurrentResponse.self, from: data)
            let model = WeatherModel.makeCurrent(from: decoded)
            return model
        } catch {
            throw error
        }
    }
    
    func decodeForecast(data: Data) throws -> [WeatherModel] {
        do {
            let decoded = try decoder.decode(ForecastResponse.self, from: data)
            let model = WeatherModel.makeForecast(from: decoded)
            return model
        } catch {
            throw error
        }
    }
}
