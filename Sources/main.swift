let offers: [DiscountOffer] = [
    DiscountOffer(code: "OFR001", discountPercentage: 10, minDistance: 70, maxDistance: 200, minWeight: 10, maxWeight: 150),
    DiscountOffer(code: "OFR002", discountPercentage: 7, minDistance: 50, maxDistance: 150, minWeight: 100, maxWeight: 250),
    DiscountOffer(code: "OFR003", discountPercentage: 5, minDistance: 50, maxDistance: 250, minWeight: 10, maxWeight: 150)
]

let inputHandler: InputHandler = ConsoleInputHandler()
do {
    let (baseCost, shipments, vehicles) = try inputHandler.getUserInput()
    let service = LogisticsService(baseDeliveryCost: baseCost, offers: offers, vehicles: vehicles)
    let results = service.estimateDeliveryTime(for: shipments)

    print("\n==============================\n")
    for result in results {
        print("Shipment: \(result.id), Discount: \(String(format: "%.2f", result.discount)), Total Cost: \(String(format: "%.2f", result.totalCost)), Delivery Time: \(result.deliveryTime)")
    }
} catch InputError.invalidFormat {
    print("❌ Error: Invalid input format for base cost and package count.")
} catch InputError.invalidPackageInput {
    print("❌ Error: Invalid package details. Please check the format.")
} catch InputError.invalidVehicleInput {
    print("❌ Error: Invalid vehicle details. Please check the format.")
} catch {
    print("❌ Unexpected error: \(error)")
}
