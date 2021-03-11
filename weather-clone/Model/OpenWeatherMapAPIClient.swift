import Foundation
import Combine
import CoreLocation

class OpenWeatherMapAPIClient {
    private static let host: String = "api.openweathermap.org"
    private static let apiKey: String = "a002bd4fab71c3e41d079ddd94e9f030"  // Storing API keys in repo is no-no, but it's just a demo, right?
    
    init() { }
    
    static func baseUrl(method: OWMAPIMethods, params: [URLQueryItem]) -> URL? {
        var url = URLComponents()
        url.scheme = "https"
        url.host = self.host
        url.path = method.rawValue
        url.queryItems = params + ["appid": self.apiKey].asURLQueryParams()
        
        return url.url
    }
    
    static func getBaseRequest<T: Codable>(_ method: OWMAPIMethods,
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
    private static var getWeatherDefaultParams: [URLQueryItem] {
        get {
            return [
                "units": "metric",
                "exclude": "minutely"
            ].asURLQueryParams()
        }
    }
    
    static func getWeather(_ city: City, callback onComplete: @escaping (OneCallForecastResponse?, Error?) -> Void) {
        let params: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: String(city.lat)),
            URLQueryItem(name: "lon", value: String(city.long))
        ] + self.getWeatherDefaultParams
                
        self.getBaseRequest(.OneCall, params: params) { (weather: OneCallForecastResponse?, error) in
            onComplete(weather, error)
        }
    }
}

// GEO API
extension OpenWeatherMapAPIClient {
    private static var searchCityDefaultParams: [URLQueryItem] {
        get {
            return [
                "limit": "5",
            ].asURLQueryParams()
        }
    }
    
    static func searchCity(_ query: String, callback onComplete: @escaping ([CitySearchResult]?, Error?) -> Void) {
        let params: [URLQueryItem] = [
            URLQueryItem(name: "q", value: query),
        ] + self.searchCityDefaultParams
                
        self.getBaseRequest(.Geo, params: params) { (weather: [CitySearchResult]?, error) in
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
