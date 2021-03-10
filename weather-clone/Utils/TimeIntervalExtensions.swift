import Foundation

// Extension for unix-time stuff
extension TimeInterval {
    func asDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}

extension Date {
    func hour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: self)
    }
    
    func monthDayFull() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    func time() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
