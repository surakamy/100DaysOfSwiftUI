import Foundation

public final class UnitFoodCalories: Dimension {
    static let oneKal = UnitFoodCalories(symbol: "", converter: UnitConverterLinear(coefficient: 1))
    static let apple = UnitFoodCalories(symbol: "🍎", converter: UnitConverterLinear(coefficient: 81))
    static let banana = UnitFoodCalories(symbol: "🍌", converter: UnitConverterLinear(coefficient: 105))
    static let orange = UnitFoodCalories(symbol: "🍊", converter: UnitConverterLinear(coefficient: 65))
    static let pear = UnitFoodCalories(symbol: "🍐", converter: UnitConverterLinear(coefficient: 98))

    public override class func baseUnit()
        -> UnitFoodCalories { oneKal }

    static var formatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter
    }()
}


//let ten_apple = Measurement(value: 10, unit: UnitFoodCalories.apple)
//let bananas = ten_apple.converted(to: .banana)
//
//UnitFoodCalories.formatter.string(from: bananas)
