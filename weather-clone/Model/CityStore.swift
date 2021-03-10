import SwiftUI
import Combine

struct City: Codable, Identifiable {
    var id: Int  // city id in OWM
    var name: String
    var lat: Double
    var long: Double
}

class CityStore: ObservableObject
{
    let storeName: String
    
    @Published var cities: [Int: City]
    private var autosave: AnyCancellable?
    
    func addCity(_ city: City) {
        self.cities[city.id] = city
    }

    func removeDocument(_ city: City) {
        self.cities[city.id] = nil
    }
    
    init(named name: String = "Cities") {
        self.storeName = name
        let defaultsKey = "WeatherCloneStore.\(name)"
        let defaultCity = City(id: 1, name: "Saint-Petersburg", lat: 59.9167, long: 30.25)
        self.cities = UserDefaults.standard.object(forKey: defaultsKey) as? [Int: City] ?? [1: defaultCity]
        
        // TODO: autosave
//        autosave = cities.sink { names in
//            UserDefaults.standard.set(names.asPropertyList, forKey: defaultsKey)
//        }
    }
}
