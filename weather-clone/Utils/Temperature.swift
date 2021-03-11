import Foundation

struct Temperature: ExpressibleByFloatLiteral, Codable {
    typealias FloatLiteralType = Double
    var value: Double
    
    init(floatLiteral value: Double) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Double.self)
        self.value = value
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.value)
    }

    func formatted(decimalPlaces: UInt = 0) -> String {
        return String(format: "%.\(decimalPlaces)f°", self.value)
    }
}
