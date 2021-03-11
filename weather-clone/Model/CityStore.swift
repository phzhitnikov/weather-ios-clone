import SwiftUI
import Combine

struct City: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var lat: Double
    var long: Double
}

class CityStore: ObservableObject {
    private let storeKeyPrefix = "WeatherCloneStore"
    
    static let defaultCities = [
        City(name: "Saint-Petersburg", lat: 59.9167, long: 30.25),
        City(name: "Miami", lat: 33.3992, long: -110.8687),
        City(name: "Berlin", lat: 43.968, long: -88.9435)
    ]
    
    @Published var cities: [City]
    private var autosave: AnyCancellable?
    
    func add(_ city: City) {
        if !self.cities.contains(city) {
            self.cities.append(city)
        }
    }

    func remove(_ city: City) {
        if let idx = self.cities.firstIndex(of: city) {
            self.cities.remove(at: idx)
        }
    }
    
    init() {
        let citiesKey = "\(self.storeKeyPrefix).Cities"
        self.cities = UserDefaults.standard.object(forKey: citiesKey) as? [City] ?? CityStore.defaultCities
        
        self.autosave = self.$cities.sink { newCities in
            let data = newCities.map { try? JSONEncoder().encode($0) }
            UserDefaults.standard.set(data, forKey: citiesKey)
            // FIXME: why you are not saving??
        }
    }
}
