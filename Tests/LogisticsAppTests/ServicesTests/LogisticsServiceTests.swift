import XCTest
@testable import LogisticsApp

final class LogisticsServiceTests: XCTestCase {

    func testEstimateDeliveryTime() {
        let shipments = [
            Shipment(id: "PKG1", weight: 50, distance: 100, offerCode: "OFR001"),
            Shipment(id: "PKG2", weight: 75, distance: 50, offerCode: "OFR002")
        ]
        let vehicles = [
            Vehicle(maxSpeed: 70, maxCarriableWeight: 200)
        ]
        let offers = [
            DiscountOffer(code: "OFR001", discountPercentage: 10, minDistance: 70, maxDistance: 200, minWeight: 10, maxWeight: 150),
            DiscountOffer(code: "OFR002", discountPercentage: 7, minDistance: 50, maxDistance: 150, minWeight: 100, maxWeight: 250)
        ]

        let service = LogisticsService(baseDeliveryCost: 100, offers: offers, vehicles: vehicles)
        let results = service.estimateDeliveryTime(for: shipments)

        XCTAssertEqual(results.count, 2)
        XCTAssertGreaterThan(results[0].deliveryTime, 0)
        XCTAssertGreaterThan(results[1].deliveryTime, 0)
    }
}
