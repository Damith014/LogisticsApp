import XCTest
@testable import LogisticsApp

final class ShipmentTests: XCTestCase {

    func testShipmentInitialization() {
        let shipment = Shipment(id: "PKG1", weight: 50, distance: 100, offerCode: "OFR001")

        XCTAssertEqual(shipment.id, "PKG1")
        XCTAssertEqual(shipment.weight, 50)
        XCTAssertEqual(shipment.distance, 100)
        XCTAssertEqual(shipment.offerCode, "OFR001")
        XCTAssertEqual(shipment.deliveryTime, 0.0)
        XCTAssertEqual(shipment.totalCost, 0.0)
        XCTAssertEqual(shipment.discount, 0.0)
    }
}
