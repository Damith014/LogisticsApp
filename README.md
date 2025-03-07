# LogisticsApp

## Overview
A Swift-based command-line application for calculating delivery costs and applying discounts for shipments based on predefined offer criteria..

## Features
- Calculate delivery cost based on weight, distance, and discount offers.
- Estimate delivery time using vehicle speed and capacity constraints.
- Apply discounts based on predefined offers.
- Handle user input via the console.
- 90% test coverage ensuring reliability and correctness.

## Requirements
- Swift 5+
- Xcode (for development and testing)
- macOS (for execution)

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/Damith014/LogisticsApp
   ```
2. Navigate to the project directory:
   ```sh
   cd LogisticsApp
   ```
3. Open the project in Xcode or compile it using Swift:
   ```sh
   swift run
   ```

## Usage
Run the program and enter the required input:

1. **Enter base delivery cost and number of shipments:**
   ```sh
   100 5
   ```
2. **Enter shipment details (Format: ID Weight Distance OfferCode):**
   ```sh
   PKG1 50 30 OFR001
   PKG2 75 125 OFFR0008
   PKG3 175 100 OFFR003
   PKG4 110 60 OFFR002
   PKG5 155 95 NA
   ```
3. **Enter number of vehicles, max speed, and max carriable weight:**
   ```sh
   2 70 200
   ```

### Example Output
```
==============================
Shipment: PKG1, Discount: 0.00, Total Cost: 750.00, Delivery Time: 3.98
Shipment: PKG2, Discount: 0.00, Total Cost: 1475.00, Delivery Time: 1.78
Shipment: PKG3, Discount: 0.00, Total Cost: 2350.00, Delivery Time: 1.42
Shipment: PKG4, Discount: 0.00, Total Cost: 1500.00, Delivery Time: 0.85
Shipment: PKG5, Discount: 0.00, Total Cost: 2125.00, Delivery Time: 4.19
```

## Code Structure
- **`LogisticsService.swift`** - Main service handling delivery estimation.
- **`PricingService.swift`** - Handles cost and discount calculations.
- **`Models.swift`** - Contains `Shipment`, `Vehicle`, and `DiscountOffer` structures.
- **`InputHandler.swift`** - Handles console input processing.
