//
//  ContentView.swift
//  TimerDemo
//
//  Created by KyleLearnedThis on 4/28/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: TimerDemoStore
    @State var seconds: String = ""

    var body: some View {
        VStack {
            Text("Timer")
                .font(.title)
                .padding()
            TextField("Enter seconds", text: $seconds, onCommit: {
                startTimer(seconds)
            })
            .keyboardType(.numberPad)
            .padding(16)
            .padding(.horizontal)
            .frame(width: screenWidth * 0.82)
            .background(Color(.systemGray6))
            .cornerRadius(10)

            actionBar.frame(width: screenWidth * 0.8)
        }
    }
    var actionBar: some View {
        HStack {
            clearButton
            submitButton
        }
    }

    var clearButton: some View {
        Button(action: {
            self.seconds = ""
            UIApplication.shared.endEditing()
        }) {
            Text("Clear")
                .padding(10)
                .foregroundColor(.white)
        }
        .background(.blue)
        .cornerRadius(10)
    }

    var submitButton: some View {
        Button(action: {
            if !seconds.isEmpty {
                startTimer(seconds)
            } else {
                UIApplication.shared.endEditing()
            }
        }) {
            Text("Submit")
                .padding(10)
                .foregroundColor(.white)
        }
        .background(.blue)
        .cornerRadius(10)
    }

    func startTimer(_ input: String) {
        print("=== start: [\(input)] ====")
        let secondsNum = Int(input)!
        self.store.createNotificationTrigger(seconds: secondsNum)
        UIApplication.shared.endEditing()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
