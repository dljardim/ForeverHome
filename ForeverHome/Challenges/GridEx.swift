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
    @Environment(\.colorScheme) var colorScheme
    
    
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
            
            GradientCard(
                color1: Color.purple,
                color2: Color.red,
                colorBackground: (Color(hex:"#171718")),
                imageCurrent: Image(systemName: "swift")
            )
            
            // left to right, top to bottom
            LazyVGrid(columns:columns, spacing:10){
                ForEach(fruits){fruit in
                    Text(fruit.title)
                        .frame(height:125, alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(fruit.color)
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.white.opacity(0.5),
                                radius: 2, x: 1, y: 2)
                }
            }.padding()
            
            
        }.background(Color(hex: "#171718"))
    }
}


struct GradientCard: View {
    @State private var dragAmount = CGSize.zero
    
    @State var color1:Color
    @State var color2:Color
    @State var colorBackground:Color
    
    @State var imageCurrent:Image
    
    init(
        color1: Color,
        color2: Color,
        colorBackground: Color,
        imageCurrent:Image
    ) {
        self.color1 = color1
        self.color2 = color2
        self.colorBackground = colorBackground
        self.imageCurrent = imageCurrent
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
                .overlay(
                    Image(systemName: "heart.fill").resizable().scaledToFit().padding()
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                )
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
        .background(Color(colorBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageGradientCard:View {
    var body: some View {
        Image(systemName: "swift")
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

/*
 
 Milo is making a sticker album, but his grid doesn’t show any items! Can you help him figure out what’s wrong with his code?
 👉 Your task: Spot what’s wrong. Why isn’t anything showing on screen? How would you fix it?
 
 a) The ForEach statement either requires needs unique identification of its items.
 That can be accomplished by setting a the id to self within the ForEach loop.
 Or, convert the array into a structure which contains  "name" and "id" and mark it conforming to the  identifiable protocol.
 
 */
// start here
//
//struct MiloGrid: View {
//    let stickers = ["Dog", "Cat", "Elephant"]
//
//    var body: some View {
//        LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
//            ForEach(stickers) { sticker in
//                Text(sticker)
//                    .frame(height: 100)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//            }
//        }
//        .padding()
//    }
//}

struct MiloGridSolution1: View {
    let stickers = ["Dog", "Cat", "Elephant"]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
            ForEach(stickers, id: \.self) { sticker in
                Text(sticker)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

struct Sticker:Identifiable {
    let id = UUID()
    let name:String
}
struct MiloGridSolution2: View {
    
    let stickers:[Sticker] = [
        Sticker(name:"Dog"),
        Sticker(name:"Cat"),
        Sticker(name:"Elephant")
    ]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
            ForEach(stickers) { sticker in
                Text(sticker.name)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}


/*
 Exercise 3: "Improve this Grid!"
 You’re helping build a sticker shop app. Here’s the current grid code:
 
 
 It works, but the product manager says:
 “It looks kind of... boring. Can we make each sticker look like a card? Add some polish? Oh — and make it look decent in both dark and light mode!”
 👉 Your task: Improve this grid visually. Keep the functionality the same, but make it look like a modern app sticker picker!
 🧠 Focus on:
 Rounded corners
 Shadows
 Light/dark friendliness
 Maybe a border or color polish
 
 
 a)
 too much white space
 
 */

struct StickerShop: View {
    let stickers = ["🦄", "🐶", "🐱", "🐸", "🐷", "🦊", "🐵"]
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(stickers, id: \.self) { sticker in
                    Text(sticker)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.yellow)
                }
            }
        }
    }
}


/*
 issues with this -
 1) border.  i was not able to make a border look good when combined with a corner radius and drop shadow.
 2) overall, i felt confused on the sizing.  More specifically, i wanted equal horizontal and vertical gaps. the scaling of the text if the frame size increased, etc.
 3) font sizing  - or the scaling of the size of the emoji
 4) modifier placement - as in what order the modifiers must be. i suppose i'll eventually get better at that one
 
 */
struct StickerShopSolution: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let stickers = ["🦄", "🐶", "🐱", "🐸", "🐷", "🦊", "🐵"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                
                ForEach(stickers, id: \.self) { sticker in
                    Text(sticker)
                        .font(
                            .system(
                                size: 60,
                                weight: .bold,
                                design: .default
                            )
                        )
                        .padding()
                        .background(colorScheme == .dark ? Color.teal.opacity(0.5).gradient : Color.orange.opacity(0.5).gradient)
                        .cornerRadius(20.0)
                        .shadow(color: (colorScheme == .dark ? Color.white : Color.black),radius: 1, x: 1, y: 1)
                        .frame(width: 150)
                }
            }
        }.padding()
    }
}

/*
 issues: font scaling - change to use geometry reader
 */
struct StickerShopSolution2: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let stickers = ["🦄", "🐶", "🐱", "🐸", "🐷", "🦊", "🐵"]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(),spacing: 16),
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                
                ForEach(stickers, id: \.self) { sticker in
                    Text(sticker)
                        .font(
                            .system(
                                size: 60,
                                weight: .bold,
                                design: .default
                            )
                        )
                        .padding()
                        .background(colorScheme == .dark ? Color.teal.opacity(0.5).gradient : Color.orange.opacity(0.5).gradient)
                        .cornerRadius(20.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        )
                        .shadow(color: (colorScheme == .dark ? Color.white : Color.black),radius: 1, x: 1, y: 1)
                        .frame(width: 150, height: 150)
                }
            }
        }.padding()
    }
}

/*
 Challege - find the bug
 
 What’s wrong with this code?
 It compiles fine.
 But when run, it looks... weird and broken.
 🧠 Your job:
 Explain what’s wrong.
 Fix the bug so it displays a proper grid.
 
 */

struct EmojiGallery: View {
    //    let emojis = ["😀", "😂", "🥰", "😎", "🤓", "🤯"]
    let emojis = ["1", "2", "3", "4", "5", "6","7","8","9","10","11","12"]
    
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns, spacing: 20) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        
    }
}

/*
 
 Q: What's the key difference between LazyVGrid and a VStack + ForEach?
 
 a)
 VStack + ForEach:
 - each item on a new line
 - grows top to bottom
 - renders everything - even offscreen items
 
 LazyVGrid:
 - must be placed in a ScrollView
 - add items left to right and top to bottom
 - has the potential to use more than one column
 - lazy loading  - will not render offscreen Views
 */


struct ChallengeVStack: View {
    let items:[String] = ["1", "2", "3", "4", "5", "6","7","8","9","10","11","12"]
    
    var body: some View {
        VStack {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding()
                    .background(Color.green)
            }
        }
    }
}

struct ChallengeLazyVGrid: View {
    let items:[String] = ["1", "2", "3", "4", "5", "6","7","8","9"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: columns){
                ForEach(items, id: \.self) { item in
                    Rectangle()
                        .foregroundStyle(Color.green)
                        .frame(height: 100)
                        .overlay(Text("\(item)").foregroundStyle(.white))
                }
            }
            .padding(.all, 10)
        }
        .padding()
    }
}

struct ConvertToLazyVGrid : View {
    let items = ["😀", "😂", "🥰", "😎", "🤓", "🤯"]
    
    var body: some View{
        VStack {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding()
                    .background(Color.green)
            }
        }
    }
}


struct ConvertToLazyVGridSolution : View {
    let items = ["😀", "😂", "🥰", "😎", "🤓", "🤯"]
    
    var body: some View{
      
        let columns = [
            GridItem(.flexible())
        ]

        ScrollView([.vertical]){
            LazyVGrid(columns: columns){
                
                ForEach(items, id: \.self){ item in
                    Text(item)
                        .padding()
                        .background(Color.green)
                }
            }
        }
    }
}

struct ConvertToLazyVGridCorrectSolution : View {
    let items = ["😀", "😂", "🥰", "😎", "🤓", "🤯"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.largeTitle)
                        .frame(width: 80, height: 80)
                        .background(Color.green)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

/*
 
 Your turn! Build a LazyHGrid that scrolls horizontally with 2 rows. Each cell should show a different fruit emoji 🍎🍇🍌🍓 and look like a little card.
 
 Let’s see what you’ve got!
 
 a)
 getRandom is a performance hit, but i use it for ease of use in demos
 b)
 i'm confused on
 
 
 */

struct ConvertToLazyHGridTwoRows: View {
    
    let items:[String] = ["🍎","🍇","🍌","🍓"]
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
            ScrollView(.horizontal){
                LazyHGrid(rows: rows, spacing: 10){
                    ForEach(items, id: \.self){item in
                        Text(item)
                            .frame(width: 100, height:100)
                            .background(Color.getRandom())
                            .cornerRadius(10)
                            .shadow(radius:1, x:1, y:1)
                    }
                }.padding(20)
            }
        
    }
}


struct ConvertToLazyHGridTwoRowsSolution: View {
    
    let items:[String] = ["🍎","🍇","🍌","🍓"]
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .background(Color.getRandom())
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 2, y: 2)
                }
            }
            .padding(20)
        }
    }
}

/*
 why the large vertical gap?
 
 .flexible() will use the max size of the container that it can
 
 */

struct ConvertToLazyHGridTwoRowsSolution_NoVerticalGap: View {
    
    let items:[String] = ["🍎","🍇","🍌","🍓"]
    
    let rows = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .background(Color.getRandom())
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 2, y: 2)
                }.border(.yellow)
            }.border(.red)
            
        }.border(.green)
    }
}


struct DynamicLazyHGrid: View {
    let items = ["🍎","🍇","🍌","🍓","🍍","🥝","🍑","🍒","🍉","🥥","🍈","🍋","🍊","🥭","🍏"]
    
    var body: some View {
        GeometryReader { geometry in
            let rowHeight: CGFloat = 100
            let spacing: CGFloat = 10
            let totalAvailableHeight = geometry.size.height - 40 // padding
            let numberOfRows = max(1, Int((totalAvailableHeight + spacing) / (rowHeight + spacing)))
            let rows = Array(repeating: GridItem(.fixed(rowHeight)), count: numberOfRows)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: spacing) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .font(.largeTitle)
                            .frame(width: 100, height: rowHeight)
                            .background(Color.getRandom())
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 2, y: 2)
                    }
                }
                .padding(20)
            }
        } // geometry
    }
}




#Preview{

//    ConvertToLazyHGridTwoRows()
//    ConvertToLazyHGridTwoRowsSolution()
//    ConvertToLazyHGridTwoRowsSolution_NoVerticalGap()
//    DynamicLazyHGridBreakDown()
}
