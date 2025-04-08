//
//  Counter.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/4/25.
//

import SwiftUI

struct Counter: View {
    @State private var count:Int = 0
    
    func increase(){
        count += 1
    }
    
    func decrease(){
        count -= 1
    }
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.custom("AmericanTypewriter", size: 180, relativeTo: .largeTitle))
            
            HStack{
                Button{
                    increase()
                }label:{
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width:60, height:60)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                
                
                Button{
                    decrease()
                }label:{
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width:60, height:60)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
            }
            
        }
        .padding()
    }
}

#Preview {
    Counter()
}
