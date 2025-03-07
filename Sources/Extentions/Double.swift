import Foundation
extension Double {
    func formatted(to decimals: Int = 2) -> Double {
        let divisor = pow(10.0, Double(decimals))
        return (self * divisor).rounded(.down) / divisor
    }
    func formattedDouble(decimals: Int = 2) -> Double {
        return Double(String(format: "%.\(decimals)f", self)) ?? self
    }
    func formattedString(decimals: Int = 2) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}
