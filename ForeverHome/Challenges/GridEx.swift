//
//  GridEx.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/14/25.
//

import SwiftUI

struct GridEx: View {
    let dogs = ["Buddy", "Charlie", "Max", "Belle", "Luna", "Daisy"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20){
                ForEach(dogs, id: \.self) {dog in
                    Text(dog)
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .foregroundStyle(.white)
                        .font(.title)
                }
            }
            .padding()
        }
    }
}

/*
 Exercise 1 (revised): Write a SwiftUI view that shows a 2-column grid with the names of 4 fruits: 🍎 “Apple”, 🍌 “Banana”, 🍇 “Grape”, 🍊 “Orange”.
 Make each fruit name show in a colorful box, centered.
 */

extension Color {
    static func getRandom() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

struct GridEx1: View {
    
    let fruits:[String] = ["Apple", "Banana", "Grape", "Orange"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View{
        ScrollView(){
            
            // left to right, top to bottom
            LazyVGrid(columns:columns, spacing:20){
                ForEach(fruits, id: \.self){fruit in
                    Text(fruit)
                        .frame(height:150, alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.getRandom())
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                }
            }.padding()
        }
    }
}

/*
 challenge:
 
 change fruits string array into array a structure array
 add identifiable
 add property id  - UUID
 and color - get random
 
 .overlay {
 Circle().stroke(.white, lineWidth: 4)
 }
 .shadow(radius: 7)
 
 
 */
struct GridEx2: View {
    
    
    struct Fruit:Identifiable {
        let id = UUID()
        let title:String
        let color:Color
    }
    
    let fruits:[Fruit] = [
        Fruit(title:"Apple", color: Color.red),
        Fruit(title:"Banana", color: Color.yellow),
        Fruit(title:"Grape", color: Color.purple),
        Fruit(title:"Orange", color: Color.orange)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
        ScrollView(){
            
            GradientCard(color1: Color.purple, color2: Color.red)
            
            // left to right, top to bottom
            LazyVGrid(columns:columns, spacing:10){
                ForEach(fruits){fruit in
                    Text(fruit.title)
                        .frame(height:150, alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(fruit.color)
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 1, x: 1, y: 1)
                    

                }
            }.padding()
            
            
        }
    }
}


struct GradientCard: View {
    @State private var dragAmount = CGSize.zero
    
    @State var color1:Color
    @State var color2:Color
    
    init(
        color1: Color,
        color2: Color
    ) {
        self.color1 = color1
        self.color2 = color2
    }
    
    var body: some View {
        let maxRotationY: CGFloat = 0
        let maxRotationX:CGFloat = 180
        let width = UIScreen.main.bounds.width
        
        let rotationX = Double(-dragAmount.height / width * maxRotationX)
        let rotationY = Double(dragAmount.width / width * maxRotationY)
        
        return VStack {
            
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [color1, color2]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .frame(width: 250, height: 350)
                .shadow(color: .black.opacity(0.3), radius: 20, x: 10, y: 10)
                .rotation3DEffect(
                    .degrees(rotationX),
                    axis: (x: 1, y: 0, z: 0),
                    perspective: 0.5
                )
                .rotation3DEffect(
                    .degrees(rotationY),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragAmount = value.translation
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                dragAmount = .zero
                            }
                        }
                )
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}


struct NeumorphicButton: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.4250512375, green: 0.945, blue: 0.5463139668, alpha: 1)) // Soft gray background
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color(#colorLiteral(red: 0.925, green: 0.933, blue: 0.945, alpha: 1)))
                .frame(width: 150, height: 150)
//                .shadow(color: .white, radius: 10, x: -10, y: -10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 3, y: 3)
                .overlay(
                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                )
        }
    }
}


struct GlassmorphicCard: View {
    var body: some View {
        ZStack {
            // Background
            Image("yourBackgroundImage") // Replace with an actual image asset
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Glass card
            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
                .frame(width: 300, height: 200)
                .overlay(
                    VStack(spacing: 30) {
                        Text("Glassmorphism")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                        
                        Text("Beautiful frosted glass effect")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 20)
        }
    }
}




#Preview {
//    GlassmorphicCard().preferredColorScheme(.dark)
//    GradientCard()
//    NeumorphicButton().preferredColorScheme(.dark)
//    GridEx3()
    GridEx2().preferredColorScheme(.dark)
}
