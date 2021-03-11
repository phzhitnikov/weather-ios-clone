import Foundation

struct DailyTemperature: Codable {
    var morn, day, eve, night: Temperature
    var min, max: Temperature?
}

// FIXME: setting all fields to Optional seems wrong, consider refactoring
struct Weather: Codable, Identifiable {
    var id: String { "\(String(describing: dt))" }

    var dt, sunrise, sunset: TimeInterval?
    
    var temp, feels_like: Temperature?
    var weather: [WeatherDescription]?

    var pressure, humidity: Int?
    var dew_point: Double?
    var uvi: Double?
    var clouds: Int?  // in percents
    var visibility: Int?  // in meters
    var wind_speed, wind_gust: Double?
    var wind_deg: Int?  // FIXME: consider Angle.degrees here?

    var pop: Double? // probability of precipitation
    var rain, snow: Dictionary<String, Double>?  // last hour volume in mm  FIXME: type
    
    var rainValue: Double? { return self.rain?["1h"] }
    var snowValue: Double? { return self.snow?["1h"] }
}

// FIXME: DRY
struct MultiWeather: Codable, Identifiable {
    var dt, sunrise, sunset: TimeInterval?
    
    var temp, feels_like: DailyTemperature?
    var weather: [WeatherDescription]?

    var pressure, humidity: Int?
    var dew_point: Double?
    var uvi: Double?
    var clouds: Int?  // in percents
    var visibility: Int?  // in meters
    var wind_speed, wind_gust: Double?
    var wind_deg: Int?  // FIXME: consider Angle.degrees here?

    var pop: Double? // probability of precipitation
    var rain, snow: Double?  // mm
    
    var id: String { "\(String(describing: dt))" }
}

struct WeatherDescription: Codable {
    var id: Int
    var main, description, icon: String
}

struct WeatherAlert: Codable {
    var sender_name, event, description: String
    var start, end: TimeInterval
}

struct OneCallForecastResponse: Codable {
    var lat: Double
    var lon: Double
    var timezone: String
    var timezone_offset: Int
    var current: Weather?
    var hourly: [Weather]?
    var daily: [MultiWeather]?
//    var minutely: [Weather]?  // TODO: implement
    var alerts: [WeatherAlert]?
}

