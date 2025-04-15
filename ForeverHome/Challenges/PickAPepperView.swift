//
//  PickAPepperView.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/10/25.
//

import SwiftUI
//
//🕹 Next Mini-Challenge: “Pick a Pepper”
//Let’s spice things up with a fun bug-finding challenge!
//Imagine this SwiftUI view:

//❓ Spot 2+ major issues in this code.
//What would go wrong and how would you fix it?


struct PepperView: View {
    @State private var pepperMessage = "🌶️ Picking pepper..."
    
    func pickPepper() {
        sleep(3)
        pepperMessage = "✅ Pepper picked!"
    }
    
    var body: some View {
        VStack {
            
            Text(pepperMessage)
            Button("Pick Pepper", action: pickPepper)
        }
    }
}


/*
 
 1. sleep() - blocking the main thread -
 - create a background Task
 - use Task.sleep() instead of sleep()
 2. pepperMessage conveys that the pepper picking as already started before pressing the button
 - pepperMessage shows as a blank string on start ""
 
 */

struct PepperViewSolution: View {
    
    @State private var pepperMesssage = ""
    
    func pickPepper() {
        Task{
            pepperMesssage = "🌶️ Picking pepper..."
            await Task.sleep(3 * 1_000_000_000)
            pepperMesssage = "✅ Pepper picked!"
        }
    }
    
    var body: some View {
        VStack {
            Text(pepperMesssage)
            Button("Pick Pepper", action: pickPepper)
        }
    }
}

/*
 
 🔍 Bonus Touches You Might Consider:
 Enhancement    What It Does
 Use .animation()    Smoothly fades the message in/out (extra polish!)
 Disable the button while picking    Prevents double-click chaos
 
 */

struct PepperViewSolution2: View {
    
    @State private var pepperMesssage = ""
    @State private var isRunning = false
    
    
    func pickPepper() {
        Task{
            isRunning = true
            pepperMesssage = "🌶️ Picking pepper..."
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            pepperMesssage = "✅ Pepper picked!"
            isRunning = false

        }
    }
    
    var body: some View {
        VStack {
            Text(pepperMesssage)
                .frame(width: .infinity, height: 50.0, alignment: .leading)
                .animation(.easeInOut(duration: 0.5), value: pepperMesssage)
            
            Button{
                pickPepper()
            }label:{
                Text("Pick a Pepper")
                
            }.buttonStyle(.borderedProminent)
                .disabled(isRunning ? true : false)
                .animation(.easeInOut(duration: 0.2), value: isRunning)
        }
    }
}


struct SoupView: View {
    @State private var message = ""
    @State private var isRunning = false
    
    func cookSoup() {
        Task {
            message = "Soup is cooking"
            isRunning = true
            try await Task.sleep(nanoseconds: 2_000_000_000)
            message = "🥣 Soup is ready!"
            isRunning = false
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            if isRunning {
                ProgressView("Soup is cooking...")
            } else {
                Text(message)
            }
            
            Spacer()
            Button{
                cookSoup()
            }label:{
                Text("Cook Soup")
            }
            .buttonStyle(.bordered).tint(.blue)
            .disabled(isRunning)
        }
    }
}


#Preview {
//    PepperViewSolution2()
    SoupView()
}
