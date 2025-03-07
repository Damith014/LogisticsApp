protocol InputHandler {
    func getUserInput() throws -> (Double, [Shipment], [Vehicle])
}
