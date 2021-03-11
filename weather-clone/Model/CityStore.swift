import SwiftUI
import Combine

struct City: Codable, Identifiable, Equatable {
    var id = UUID()
    var owm_id: Int = -1  // city id in OWM
    var name: String
    var lat: Double
    var long: Double
}

class CityStore: ObservableObject {
    let storeName: String
    
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
    
    init(named name: String = "Cities") {
        self.storeName = name
        let defaultsKey = "WeatherCloneStore.\(name)"
        
        self.cities = UserDefaults.standard.object(forKey: defaultsKey) as? [City] ?? CityStore.defaultCities
        
        self.autosave = self.$cities.sink { newCities in
            let data = newCities.map { try? JSONEncoder().encode($0) }
            UserDefaults.standard.set(data, forKey: defaultsKey)
            // FIXME: why you are not saving??
        }
    }
}
