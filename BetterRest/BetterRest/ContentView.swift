//
//  ContentView.swift
//  BetterRest
//
//  Created by Thomas Dobson on 1/18/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    
                    Section(header: Text("When do you want to wake up?")) {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    Section(header: Text("Desired amount of sleep"))  {
                        Stepper(value: $sleepAmount, in: 1...24 , step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    Section(header: Text("Daily Coffee Intake"))  {

                        Picker("Daily Coffee Intake", selection: $coffeeAmount) {
                            ForEach(0..<20) {cup in
                                if cup == 1 {
                                    Text("\(cup) cup")
                                } else {
                                    Text("\(cup) cups")
                                }
                            }
                        }
                        //.pickerStyle(DefaultPickerStyle())
                    }
                }
                Spacer()
                Text("Your Recomended bedtime is:")
                    .font(.headline)
                    .padding()
                Text("\(calculateBedtime())")
                    .font(.largeTitle)
                    .padding()
            }
            .navigationBarTitle(Text("BetterRest"))
            //.navigationBarHidden(true)
        }

}
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = components.hour ?? 0 * 60 * 60
        let minutes = components.minute ?? 0 * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter  = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            print("Error")
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
