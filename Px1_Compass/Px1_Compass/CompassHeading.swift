import Foundation
import Combine
import CoreLocation

class CompassHeading2: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var degree: Double = .zero

    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        setup()
    }

    private func setup() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.degree = -1 * newHeading.magneticHeading
    }
}

class CompassHeading: NSObject, ObservableObject, CLLocationManagerDelegate {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var degrees: Double = .zero {
        didSet {
            objectWillChange.send()
        }
    }

    private let locationManager: CLLocationManager

    override init() {
        self.locationManager = CLLocationManager()
        super.init()

        self.locationManager.delegate = self
        self.setup()
    }

    private func setup() {
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.degrees = -1 * newHeading.magneticHeading
    }
}
