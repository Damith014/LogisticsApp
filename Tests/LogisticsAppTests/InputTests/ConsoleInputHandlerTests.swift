import XCTest
@testable import LogisticsApp

final class ConsoleInputHandlerTests: XCTestCase {
    func testValidUserInput() {
        let mockStdin = [
            "100 2",                  // Base cost: 100, 2 packages
            "PKG1 50 100 OFR001",      // First package
            "PKG2 75 150 OFR002",      // Second package
            "2 70 200"                 // 2 vehicles, speed 70, weight 200
        ]
        var inputIndex = 0
        let mockInputProvider: () -> String? = {
            guard inputIndex < mockStdin.count else { return nil }
            defer { inputIndex += 1 }
            return mockStdin[inputIndex]
        }
        let inputHandler = ConsoleInputHandler(inputProvider: mockInputProvider)
        do {
            let (baseCost, shipments, vehicles) = try inputHandler.getUserInput()
            XCTAssertEqual(baseCost, 100)
            XCTAssertEqual(shipments.count, 2)
            XCTAssertEqual(shipments[0].id, "PKG1")
            XCTAssertEqual(shipments[0].weight, 50)
            XCTAssertEqual(shipments[0].distance, 100)
            XCTAssertEqual(shipments[0].offerCode, "OFR001")
            
            XCTAssertEqual(shipments[1].id, "PKG2")
            XCTAssertEqual(shipments[1].weight, 75)
            XCTAssertEqual(shipments[1].distance, 150)
            XCTAssertEqual(shipments[1].offerCode, "OFR002")
            
            XCTAssertEqual(vehicles.count, 2)
            XCTAssertEqual(vehicles[0].maxSpeed, 70)
            XCTAssertEqual(vehicles[0].maxCarriableWeight, 200)
            
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testInvalidBaseCostInput() {
        let mockStdin = ["invalid input"]
        let mockInputProvider: () -> String? = { mockStdin.first }
        
        let inputHandler = ConsoleInputHandler(inputProvider: mockInputProvider)
        XCTAssertThrowsError(try inputHandler.getUserInput()) { error in
            XCTAssertEqual(error as? InputError, InputError.invalidFormat)
        }
    }
}

