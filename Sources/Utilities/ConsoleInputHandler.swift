class ConsoleInputHandler: InputHandler {
    private let inputProvider: () -> String?
    
    init(inputProvider: @escaping () -> String? = { readLine() }) {
        self.inputProvider = inputProvider
    }

    func getUserInput() throws -> (Double, [Shipment], [Vehicle]) {
        print("Enter base delivery cost and number of packages:", terminator: " ")
        guard let input = inputProvider()?.split(separator: " "),
              input.count == 2,
              let baseCost = Double(input[0]),
              let packageCount = Int(input[1]) else {
            throw InputError.invalidFormat
        }

        var shipments: [Shipment] = []
        for _ in 1...packageCount {
            print("Enter package details (Format: ID Weight Distance OfferCode):", terminator: " ")
            guard let line = inputProvider()?.split(separator: " "), line.count >= 3,
                  let weight = Double(line[1]), let distance = Double(line[2]) else {
                throw InputError.invalidPackageInput
            }
            let offerCode = line.count > 3 ? String(line[3]) : nil
            shipments.append(Shipment(id: String(line[0]), weight: weight, distance: distance, offerCode: offerCode))
        }

        print("Enter number of vehicles, max speed, and max carriable weight:", terminator: " ")
        guard let vehicleLine = inputProvider()?.split(separator: " "), vehicleLine.count == 3,
              let vehicleCount = Int(vehicleLine[0]),
              let maxSpeed = Double(vehicleLine[1]),
              let maxWeight = Double(vehicleLine[2]) else {
            throw InputError.invalidVehicleInput
        }

        let vehicles = Array(repeating: Vehicle(maxSpeed: maxSpeed, maxCarriableWeight: maxWeight), count: vehicleCount)
        return (baseCost, shipments, vehicles)
    }
}

enum InputError: Error {
    case invalidFormat
    case invalidPackageInput
    case invalidVehicleInput
}
