class LogisticsService {
    private let baseDeliveryCost: Double
    private let offers: [DiscountOffer]
    private var vehicles: [Vehicle]
    
    init(baseDeliveryCost: Double, offers: [DiscountOffer], vehicles: [Vehicle]) {
        self.baseDeliveryCost = baseDeliveryCost
        self.offers = offers
        self.vehicles = vehicles
    }
    func estimateDeliveryTime(for shipments: [Shipment]) -> [Shipment] {
        var vehicleAvailability: [Double] = Array(repeating: 0.0, count: vehicles.count)
        var remainingShipments = shipments.sorted { $0.distance > $1.distance }
        var updatedShipments = shipments
        
        while !remainingShipments.isEmpty {
            let nextAvailableVehicleIndex = vehicleAvailability.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0
            let vehicle = vehicles[nextAvailableVehicleIndex]
            let roundTripMultiplier: Double = 2.00
            let shipments_ = getShipmentsForVehicle(vehicle: vehicle, shipments: remainingShipments)
            
            if !shipments_.isEmpty {
                for shipment in shipments_ {
                    let travelTime = (shipment.distance / vehicle.maxSpeed).formatted()
                    let availableVehicleTime = vehicleAvailability[nextAvailableVehicleIndex].formatted()
                    let deliveryTime = availableVehicleTime + travelTime
                    
                    if let index = updatedShipments.firstIndex(where: { $0.id == shipment.id }) {
                        updatedShipments[index].deliveryTime = deliveryTime.formattedDouble()
                        let (discount, totalCost) = PricingService.calculateDeliveryCost(for: shipment, baseCost: baseDeliveryCost, offers: offers)
                        updatedShipments[index].discount = discount
                        updatedShipments[index].totalCost = totalCost
                    }
                }
                
                let maxDistance = shipments_.map { $0.distance }.max() ?? 0.00
                let roundTripTime = ((maxDistance / vehicle.maxSpeed).formatted() * roundTripMultiplier).formatted()
                vehicleAvailability[nextAvailableVehicleIndex] += roundTripTime
                remainingShipments = remainingShipments.filter { !shipments_.contains($0) }
            }
        }
        
        return updatedShipments
    }
    func getShipmentsForVehicle(vehicle: Vehicle, shipments: [Shipment]) -> [Shipment] {
        var selectedShipments: [Shipment] = []
        var totalWeight = 0.0
        for package in shipments {
            if totalWeight + package.weight <= vehicle.maxCarriableWeight {
                selectedShipments.append(package)
                totalWeight += package.weight
            }
        }
        return selectedShipments
    }
}
