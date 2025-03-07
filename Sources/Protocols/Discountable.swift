protocol Discountable {
    func isApplicable(for shipment: Shipment) -> Bool
    func calculateDiscount(for cost: Double) -> Double
}
