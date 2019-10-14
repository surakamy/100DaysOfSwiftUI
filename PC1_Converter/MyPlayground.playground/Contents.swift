import Foundation

public final class UnitFoodCalories: Dimension {
    static let oneKal = UnitFoodCalories(symbol: "", converter: UnitConverterLinear(coefficient: 1))
    static let apple = UnitFoodCalories(symbol: "🍎", converter: UnitConverterLinear(coefficient: 81))
    static let banana = UnitFoodCalories(symbol: "🍌", converter: UnitConverterLinear(coefficient: 105))

    public override class func baseUnit()
        -> UnitFoodCalories { oneKal }

    static var formatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter
    }()
}

let ten_apple = Measurement(value: 2, unit: UnitFoodCalories.banana)
let bananas = ten_apple.converted(to: .apple)

UnitFoodCalories.formatter.string(from: bananas)
//10.0 🍎 = "7.7 🍌"

