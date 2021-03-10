import Foundation
import Combine
import CoreLocation

class OpenWeatherMapAPIClient {
    private static let host: String = "api.openweathermap.org"
    private let apiKey: String = "a002bd4fab71c3e41d079ddd94e9f030"

    private var defaultParams: [URLQueryItem] {
        get {
            return [
                "appid": self.apiKey,
                "units": "metric",
                "exclude": "minutely"
            ].asURLQueryParams()
        }
    }
    
    init() { }
    
    private func baseUrl(method: OWMAPIMethods, params: [URLQueryItem]) -> URL? {
        var url = URLComponents()
        url.scheme = "https"
        url.host = OpenWeatherMapAPIClient.host
        url.path = method.rawValue
        url.queryItems = params + self.defaultParams
        
        return url.url
    }
    
    func getBaseRequest<T: Codable>(_ method: OWMAPIMethods,
                                    params: [URLQueryItem],
                                    callback onComplete:  @escaping (_ object: T?,_ error: Error?) -> ()) {
        
        let url = self.baseUrl(method: method, params: params)!
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            // Spawn on main thread as we will change the UI
            DispatchQueue.main.async {
                if let data = data {
                    // TODO: catch response errors
                    if let jsonString = String(data: data, encoding: .utf8) {
                       print(jsonString)
                    }
                    
                    // FIMXE: ugly cast
                    let httpResponse = response as! HTTPURLResponse
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try JSONDecoder().decode(T.self, from: data)
                            onComplete(weather, nil)
                        } catch let error {
                            // TODO: some readable error about decoding failure
                            onComplete(nil, error)
                            print(error)
                        }
                    } else {
                        // TODO: some readable error
                        onComplete(nil, nil)
                    }
                } else if let error = error {
                    // Catch unexpected internal errors
                    onComplete(nil, error)
                    print(error)
                }
            }
        }
        
        task.resume()
    }
}

// Weather API
extension OpenWeatherMapAPIClient {
    func getWeather(cityID: Int) {
        // TODO: implement
        // Get coords of city
        // Pass it to getForecastByCoords
    }
    
    func getForecastByCoords(lat latitude: Double, long longitude: Double,
                             callback onComplete: @escaping (OneCallForecastResponse?, Error?) -> Void) {
        
        let params: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude))
        ]
        
        self.getBaseRequest(.OneCall, params: params) { (weather: OneCallForecastResponse?, error) in
            onComplete(weather, error)
        }
    }
}


//
enum OWMAPIMethods: String {
    case OneCall = "/data/2.5/onecall"
    case Forecast = "/data/2.5/forecast"
    case Geo = "/geo/1.0/direct"
}


extension Dictionary where Key==String, Value==String {
    func asURLQueryParams() -> [URLQueryItem] {
        return self.map { key, value in
            URLQueryItem(name: key, value: value)
        }
    }
}
