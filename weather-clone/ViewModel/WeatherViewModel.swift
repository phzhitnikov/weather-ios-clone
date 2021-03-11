import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {    
    @Published var currentWeather: Weather?
    @Published var hourlyWeather: [Weather]?
    @Published var dailyWeather: [MultiWeather]?
    
    var city: City
    var isLoading: Bool = true
    
    init(_ city: City) {
        self.city = city
    }
    
    func fetchData() {
        self.isLoading = true
        OpenWeatherMapAPIClient.getWeather(self.city) { weather, error in
            if weather != nil {
                self.currentWeather = weather?.current
                self.hourlyWeather = weather?.hourly
                self.dailyWeather = weather?.daily
            }
            
            // TODO: show error in UI in some way
                
            self.isLoading = false
        }
    }
    
    var currentWeatherString: String? {
        return self.currentWeather?.weather?.first?.main
    }
    
    var minTempToday: Double? {
        return self.dailyWeather?.first?.temp?.min
    }
    
    var maxTempToday: Double? {
        return self.dailyWeather?.first?.temp?.max
    }
    
    var windString: String? {
        if let data = self.currentWeather, let wind_deg = data.wind_deg, let speed = data.wind_speed {
            let direction = degToWindDirection(Double(wind_deg))
            return "\(direction) \(Int(speed)) m/s"
        }
        return ""
    }
    
    var details: [(title: String, text: String?)] {
        return [
            ("Sunrise", self.currentWeather?.sunrise?.asDate().time()),
            ("Sunset", self.currentWeather?.sunset?.asDate().time()),
            ("Humidity", "\(self.currentWeather?.humidity ?? 0)%"),
            ("Wind", windString),
            ("Feels like", self.currentWeather?.feels_like?.formatted()),
            ("Pressure", "\(self.currentWeather?.pressure ?? 0) mm Hg"),
            ("Visibility", "\(self.currentWeather?.visibility ?? 0) m"),
            ("UV Index", "\(Int(self.currentWeather?.uvi ?? 0))")

        ]
    }
}
