struct DiscountOffer: Discountable {
    let code: String
    let discountPercentage: Double
    let minDistance: Double
    let maxDistance: Double
    let minWeight: Double
    let maxWeight: Double
    
    func isApplicable(for shipment: Shipment) -> Bool {
        return shipment.distance >= minDistance && shipment.distance <= maxDistance && shipment.weight >= minWeight && shipment.weight <= maxWeight
    }
    
    func calculateDiscount(for cost: Double) -> Double {
        return (discountPercentage / 100) * cost
    }
}
