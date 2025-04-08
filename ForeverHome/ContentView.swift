//
//  ContentView.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var count: Int = 0
    
    func increase() {
        count += 1
    }
    
    enum Person{
        case starving
        case hungry
        case happy
        case full
        case sick
        case throwup
    }
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.custom("AmericanTypewriter", size: 40, relativeTo: .largeTitle))
            Button {
                increase()
            } label: {
                Text("Feed Pet 🍗")
                    .padding()
                    .font(.custom("AmericanTypewriter", size: 40, relativeTo: .largeTitle))

            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
