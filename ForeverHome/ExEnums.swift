//
//  ExEnums.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/4/25.
//

/* ** dev notes **
 
 https://www.swiftjectivec.com/swift-enums-as-lighweight-view-models/
 
 */


import SwiftUI

struct ExEnums: View {
    
    
    enum Mood: CustomStringConvertible, Identifiable, CaseIterable {
        case happy
        case angry
        case sleepy
        case excited
        
        var id: Self {self}
        
        var description: String {
            switch self {
                case .happy:
                     "I'm happy"
                case .angry:
                     "I'm angry"
                case .sleepy:
                     "I'm sleepy"
                case .excited:
                     "I'm excited"
            }
        
        }
        
        
        
        var image:Image{
            switch self {
                case .happy:
                    Image("smile")
                case .angry:
                    Image("angry")
                case .sleepy:
                    Image("sleepy")
                case .excited:
                    Image("excited")
            }
        }
    }
    

    @State private var mood:Mood = Mood.happy
    
    func getRandomMood(){
        mood = Mood.allCases.randomElement() ?? Mood.happy
    }
    
    var body: some View {
        VStack(spacing: 20.0){
            // dont show
            if(false){
                // enum picker
                Picker("Pick", selection: $mood){
                    ForEach(Mood.allCases){ moodValue in
                        Text(moodValue.description)
                            .tag(moodValue)
                    }
                }
            }
            
            Text("Today's Mood: \(mood.description)")
            
            mood.image
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 200)
            
            // show
            Button{
                getRandomMood()
            }label:{
                Text("Get random mood")
                
            }.buttonStyle(.borderedProminent)
        }
    }
}


#Preview {
    ExEnums()
}


