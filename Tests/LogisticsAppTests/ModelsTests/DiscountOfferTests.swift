import XCTest
@testable import LogisticsApp

final class DiscountOfferTests: XCTestCase {
    
    func testDiscountEligibility() {
        let offer = DiscountOffer(code: "OFR001", discountPercentage: 10, minDistance: 70, maxDistance: 200, minWeight: 10, maxWeight: 150)
        let shipment = Shipment(id: "PKG1", weight: 50, distance: 100, offerCode: "OFR001")

        XCTAssertTrue(offer.isApplicable(for: shipment))
    }

    func testDiscountCalculation() {
        let offer = DiscountOffer(code: "OFR001", discountPercentage: 10, minDistance: 70, maxDistance: 200, minWeight: 10, maxWeight: 150)
        let cost = 500.0
        let discount = offer.calculateDiscount(for: cost)

        XCTAssertEqual(discount, 50.0)
    }
}
