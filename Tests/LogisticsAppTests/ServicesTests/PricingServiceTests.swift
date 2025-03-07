import XCTest
@testable import LogisticsApp

final class PricingServiceTests: XCTestCase {

    func testCalculateDeliveryCost_WithValidOffer() {
        let shipment = Shipment(id: "PKG1", weight: 50, distance: 100, offerCode: "OFR001")
        let offers = [
            DiscountOffer(code: "OFR001", discountPercentage: 10, minDistance: 70, maxDistance: 200, minWeight: 10, maxWeight: 150)
        ]
        let (discount, totalCost) = PricingService.calculateDeliveryCost(for: shipment, baseCost: 100, offers: offers)

        XCTAssertEqual(discount, 110.0)
        XCTAssertEqual(totalCost, 990.0)
    }

    func testCalculateDeliveryCost_WithoutValidOffer() {
        let shipment = Shipment(id: "PKG2", weight: 20, distance: 50, offerCode: nil)
        let offers: [DiscountOffer] = []
        let (discount, totalCost) = PricingService.calculateDeliveryCost(for: shipment, baseCost: 100, offers: offers)

        XCTAssertEqual(discount, 0.0)
        XCTAssertEqual(totalCost, 550.0)
    }
}
