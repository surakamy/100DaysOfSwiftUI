//
//  ContentView.swift
//  PC1_Converter
//
//  Created by Dmytro Kholodov on 10/11/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI


struct UnitPicker: View {

    @Binding var selected: UnitFoodCalories

    var units: [UnitFoodCalories]

    var body: some View {

        let p = Picker("Which Fruit", selection: $selected) {
             ForEach(units, id: \.self) { unit in
                Text("\(unit.symbol)").font(.system(size: 40))
             }
            }.frame(width: 100).clipped()
        //defaultWheelPickerItemHeight



        return p
    }
}

struct InputValue: View {
    @Binding var value: String
    @Binding var selected: UnitFoodCalories

    var units: [UnitFoodCalories]

    var body: some View {
        HStack {
            TextField("Enter", text: $value)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .font(.system(size: 80))

            UnitPicker(selected: $selected, units: units)
        }
    }
}

struct OutputValue: View {
    var value: String

    @Binding var selected: UnitFoodCalories

    var units: [UnitFoodCalories]

    var body: some View {
        HStack {
            Spacer()
            Text("\(value)")
                .multilineTextAlignment(.center)
                .font(.system(size: 80))
            Spacer()
            UnitPicker(selected: $selected, units: units)
        }//.padding()
    }
}

struct ContentView: View {

    @State var input = "1"
    @State var inputUnit = UnitFoodCalories.apple
    @State var outputUnit = UnitFoodCalories.apple

    var output: String {
        let a = Double(input) ?? 0
        let values_a = Measurement(value: a, unit: inputUnit)
        let values_b = values_a.converted(to: outputUnit)
        print(UnitFoodCalories.formatter.string(from: values_b))
        let b = values_b.value

        return String(format: "%.1f", b)
    }

    var units: [UnitFoodCalories] = [.apple, .banana, .orange, .pear]


    var body: some View {
        VStack {
            Text("How Much, eh?").font(.largeTitle)
        VStack {
            InputValue(value: $input, selected: $inputUnit, units: units)
            Text("=").font(.largeTitle)
            OutputValue(value: output, selected: $outputUnit, units: units)
        }

        //.border(Color.green, width: 1).padding(EdgeInsets(top: 10, leading: 100, bottom: 100, trailing: 100))
        }
    }


}


