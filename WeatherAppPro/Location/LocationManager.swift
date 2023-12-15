import Foundation
import CoreLocation
import CoreLocationUI

protocol LocationManagerType {
    var didReceiveLocation: ((CLLocationCoordinate2D) -> Void)? { get set }
    func requestLocation()
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, LocationManagerType {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    
    var didReceiveLocation: ((CLLocationCoordinate2D) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        manager.stopUpdatingLocation()
        if let location = location {
            didReceiveLocation?(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
