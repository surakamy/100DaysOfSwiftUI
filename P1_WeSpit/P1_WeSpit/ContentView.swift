import SwiftUI

struct ContentView: View {

    @State var checkAmount = ""
    @State var numberOfPeople = 2
    @State var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let amountPerPerson = totalAmount / Double(numberOfPeople)

        return amountPerPerson
    }

    var orderAmount: Double {
        let orderAmount = Double(checkAmount) ?? 0
        return orderAmount
    }
    var totalAmount: Double {
        let grandTotal = orderAmount + tipAmount

        return grandTotal
    }

    var tipAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection

        return tipValue
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Your check")
                        TextField("Amount", text: $checkAmount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("How many persons?")) {
                    Stepper("\(self.numberOfPeople)", value: $numberOfPeople, in: 2...99)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                if !checkAmount.isEmpty {
                    Section(header: Text("Amount per person")) {
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                            .font(.largeTitle)
                            .padding(5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Section(header: Text("Grand Total")) {
                        Text("$\(orderAmount, specifier: "%.2f")")
                            .fontWeight(.light)
                            +
                            Text(" + $\(tipAmount, specifier: "%.2f")")
                                .fontWeight(.light)

                        Text("$\(totalAmount, specifier: "%.2f")")
                            .fontWeight(.bold)

                    }
                }

            }.navigationBarTitle("We⇄Spit") //Form
        }.environment(\.horizontalSizeClass, .compact) //NavigationView
    }
}


