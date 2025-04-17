//
//  ColorPickerEx.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/13/25.
//

import SwiftUI

struct ColorPickerEx: View {
    @State private var selectedColor = Color.red
    
    var body: some View {
        VStack{
            ColorPicker("", selection: $selectedColor)
            
            Circle()
                .fill(selectedColor)
                .frame(width: 100, height: 100)
        }
    }
    
}

/*
 challenge:
 
 The app is for kids. Make this color picker more fun and usable. Think:
 Bigger tap targets
 Visually clear color preview
 Labels that are more engaging for kids
 Any layout ideas?
 
 🛠️ Your task: Rewrite this view to be more kid-friendly.
 
 */
struct DrawingSettingsView: View {
    @State private var brushColor = Color.black
    
    var body: some View {
        VStack {
            Text("Brush Color")
            ColorPicker("Color", selection: $brushColor)
        }
    }
}

struct DrawingSettingsViewSolution: View {
    
    @State private var brushColor = Color.gray
    @State private var brushColorHistory:[Color] = [Color.gray]
    
    var body: some View {
        VStack {
            Text("Brush Color")
            
            RoundedRectangle(
                cornerRadius: 30.0,
                style: RoundedCornerStyle.continuous
            ).fill(brushColor)
            
            HStack(alignment: .center){
                Button{
                    
                }label:{
                    ColorPicker("", selection: $brushColor)
                    
                }
            }
        }
        .padding()
    }
}

class Utilities {
    static func getRandomColor() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&int)
        
        let r, g, b: Double
        let a: Double
        
        switch hexSanitized.count {
            case 6: // RGB (no alpha)
                r = Double((int >> 16) & 0xFF) / 255
                g = Double((int >> 8) & 0xFF) / 255
                b = Double(int & 0xFF) / 255
                a = 1.0
            case 8: // RGBA
                r = Double((int >> 24) & 0xFF) / 255
                g = Double((int >> 16) & 0xFF) / 255
                b = Double((int >> 8) & 0xFF) / 255
                a = Double(int & 0xFF) / 255
            default:
                r = 0; g = 0; b = 0; a = 1
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    static func getRandomColor() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

struct ColorPickerView1: View {
    @State private var colorTop = Utilities.getRandomColor()
    @State private var colorBottom = Utilities.getRandomColor()
 
    var body: some View {
        
        ZStack{
            LinearGradient(
                colors: [colorTop, colorBottom],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            List{
                Section("Choose your color"){
                    ColorPicker("Top Color", selection: $colorTop)
                    ColorPicker("Bottom Color", selection: $colorBottom)
                }
            }
            .foregroundStyle(.white)
            .background(Color.clear)
            .scrollContentBackground(.hidden)
            
//            ColorGrid()
            
            VStack{
                Spacer()
                Button{
                    // save and
                }label:{
                    Text("Save").frame(width: 50.0)
                }.buttonStyle(.bordered).foregroundStyle(.white)
       
            }

        }
    }
}

struct ColorCombination {
    var colorTop:Color
    var colorBottom:Color
}



struct ColorGrid : View {
    
    @State var items:[ColorCombination] = []
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
        
        
        Grid{
            GridRow{
              
            }
            GridRow{
                Text("row 1, col 1")
                Text("row 1, col 2")
            }
        }
    }
}

/*
 
 challenge - convert VStack to LazyVGrid with 3 columns using the same data
 
 VStack {
 ForEach(items, id: \.self) { item in
 Text(item)
 .padding()
 .background(Color.green)
 }
 }
 */




#Preview {
    //    ColorPickerEx()
    //    DrawingSettingsView()
    //    DrawingSettingsViewSolution()
    //        ColorPickerView1().preferredColorScheme(.dark)
//    ColorPickerView1().preferredColorScheme(.dark)
    ConvertToLazyVGrid()
    
}
