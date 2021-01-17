//
//  ContentView.swift
//  WeSplit
//
//  Created by Thomas Dobson on 1/15/21.
//

//Tells Swift you want to use all the Functionality of Swift UI Framework
import SwiftUI

//Create a new Struct - ContentView that conforms to the view protocol
//View comes from Swift UI and is the basic protocol that must be adopted by anything you want to draw on the screen.
struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    var orderAmount: Double {
        let orderAmount = Double(checkAmount) ?? 0
        return orderAmount
    }
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = orderAmount / 100 * tipSelection
        return tipValue
    }
    
    func calculateGrandTotal() -> Double {
        return orderAmount + tipValue
    }
    
    func calculateTotalPerPerson() -> Double {
        return calculateGrandTotal() / Double(numberOfPeople)
    }
    
    let tipPercentages = [5,10,15,20,25,0]
    
    //defines body of type some View
    //returns something that conforms to the view protocol
    //some indicates the same kind of view must be returned
    //View protocol only has one requirement - a computed property called body that returns some view
    var body: some View {
        NavigationView {
            Form {
                
                //Enter Check Ammoutn
                Section {
                    TextField("Check Amount" ,text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(0..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                
                //Picker for Tip Percentage
                Section(header: Text("Tip Amount")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                //GrandTotal
                //Specifier rounds to nearest 2nd decimal
                Section(header: Text("Total Check")){
                    Text("$\(calculateGrandTotal(), specifier: "%.2f")")
                }
                
                //Check Amount Label
                //Specifier rounds to nearest 2nd decimal
                Section(header: Text("Total Per Person")) {
                    Text("$\(calculateTotalPerPerson(), specifier: "%.2f")")
                }
            }
            .navigationTitle("WeSplit")
        }

    }
}

//This doesnt go towards the final app. Xcode uses this to show a preivew of your app via the canvas. Requires catilina or later.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
