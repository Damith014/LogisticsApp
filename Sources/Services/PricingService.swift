class PricingService {
    static func calculateDeliveryCost(for shipment: Shipment, baseCost: Double, offers: [DiscountOffer]) -> (discount: Double, totalCost: Double) {
        let baseDeliveryCost = baseCost + (shipment.weight * 10) + (shipment.distance * 5)
        guard let offerCode = shipment.offerCode, let offer = offers.first(where: { $0.code == offerCode }) else {
            return (0, baseDeliveryCost)
        }
        
        if offer.isApplicable(for: shipment) {
            let discount = offer.calculateDiscount(for: baseDeliveryCost)
            return (discount, baseDeliveryCost - discount)
        }
        return (0, baseDeliveryCost)
    }
}
