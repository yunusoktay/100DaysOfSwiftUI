//
//  ContentView.swift
//  BetterRest
//
//  Created by yunus oktay on 22.08.2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8
    @State private var coffeeAmount = 1
    
    @State private var alertTile = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
       
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")
                    .font(.headline)) {
                    
                    DatePicker ("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section() {
                    
                    Picker("Select sleep amount", selection: $sleepAmount) {
                        ForEach(4...12, id: \.self) { hours in
                            Text("\(hours.formatted()) hours")
                        }
                    }
                    
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                
                Section(header: Text("Daily coffee intake")
                    .font(.headline)) {
                    
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20 )
                }
                
                Section(header: Text("Your recommended bedtime")
                        .font(.headline)
                        .foregroundColor(.black)) {
                    Text(alertMessage)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
            
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTile, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
        
        
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTile = "Your ideal bedtime is.."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTile = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
