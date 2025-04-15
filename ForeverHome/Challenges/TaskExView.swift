//
//  TaskEx.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/10/25.
//

import SwiftUI

struct TaskExView: View {
    
    @State private var displayMessage = ""
    
    func makePizza() {
        Task{
            displayMessage = "🍕 Starting pizza..."
            await Task.sleep(3_000_000_000)
            displayMessage = "✅ Pizza ready!"
        }
    }

    
    var body: some View {
        Text("status: \(displayMessage)")
        
        Button("Make Pizza"){
            makePizza()
        }.buttonStyle(.borderedProminent)
        
    }
}


struct BakeCakeView: View {
    @State private var displayMessage = ""
    func bakeCake(){
        Task{
            await Task.sleep(3 * 1_000_000_000)
            displayMessage = "🎂 Cake is ready!"
            await Task.sleep(2 * 1_000_000_000)
            displayMessage = "🎉 Time to eat!"
        }
    }
    var body: some View {
        Text("status: \(displayMessage)")
        Button("Bake Cake"){
            bakeCake()
        }
    }
}

/*
 
 ❓ Why does Swift require await Task.sleep(...) instead of just sleep(...)?
 
 

 */

#Preview {
//    TaskExView()
    BakeCakeView()
}
