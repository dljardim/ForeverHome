//
//  MoodButton.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/4/25.
//

import SwiftUI





struct MoodButtonView: View {
    
    enum Mood: CaseIterable {
        case happy, angry, sleepy, excited
        
        var message: String {
            switch self {
                case .happy: return "I'm feeling awesome today!"
                case .angry: return "Grrr! Leave me alone!"
                case .sleepy: return "Zzzzz..."
                case .excited: return "YAY! Something cool is happening!"
            }
        }
    }
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MoodButtonView()
}
