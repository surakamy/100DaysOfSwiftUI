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


public func round(_ value: Double, toNearest: Double) -> Double {
  return round(value / toNearest) * toNearest
}
