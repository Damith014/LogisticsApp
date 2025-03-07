struct Shipment: Equatable {
    let id: String
    let weight: Double
    let distance: Double
    let offerCode: String?
    var deliveryTime: Double = 0.0
    var totalCost: Double = 0.0
    var discount: Double = 0.0
}
