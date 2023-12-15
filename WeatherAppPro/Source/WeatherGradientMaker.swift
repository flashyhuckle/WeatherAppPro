import UIKit

struct WeatherGradientMaker {
    
    func createGradient(for weatherType: WeatherType) -> CAGradientLayer {
        
        var colorTop =  UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        var colorBottom = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        switch weatherType {
        case .hot:
            colorTop = UIColor(red: 121.0/255.0, green: 4.0/255.0, blue: 4.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 255.0/255.0, green: 91.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        case .warm:
            colorTop = UIColor(red: 121.0/255.0, green: 70.0/255.0, blue: 4.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 255.0/255.0, green: 220.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        case .mild:
            colorTop = UIColor(red: 121.0/255.0, green: 105.0/255.0, blue: 4.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 218.0/255.0, green: 217.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        case .cold:
            colorTop = UIColor(red: 4.0/255.0, green: 121.0/255.0, blue: 11.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 0.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        case .freezing:
            colorTop = UIColor(red: 4.0/255.0, green: 33.0/255.0, blue: 121.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
        return gradientLayer
    }
}
