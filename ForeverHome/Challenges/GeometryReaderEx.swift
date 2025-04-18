//
//  GeometryReaderEx.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/16/25.
//

import SwiftUI

struct GeometryReaderEx: View {
    var body: some View {
        Text("GeometryReaderEx")
    }
}


/*
 
 Challenge 1: Half-Height Box
 Goal:
 Use GeometryReader to create a colored box that is exactly half the screen’s height.
 
 Requirements:
 
 The box should stretch the full width.
 The height should be exactly 50% of the view's height.
 Add a label centered in the box that says "Half Height".
 
 - summarizing ai feedback

 what does top of the screen mean?
 that depends,
 the top of GeometryReader will be to the devices screen edge.
 the top of a vstack will be below the safe area.  it will not include the menu bar and island.
 
 */


struct HalfHeightBox: View {

    var body: some View {
        GeometryReader { geometry in
            
            let halfHeight = geometry.size.height / 2
            let fullWidth = geometry.size.width
            
            Text("height: \(halfHeight) - width: \(fullWidth) height: \(halfHeight) - width: \(fullWidth) height: \(halfHeight) - width: \(fullWidth)")
                .frame(width:fullWidth, height: halfHeight, alignment: .center)
                .background(.red.opacity(0.4))
                .multilineTextAlignment(.center)
        }
    }
}

struct HalfHeightBoxAlternate: View {
    var body: some View {
        GeometryReader { geometry in
            let halfHeight = geometry.size.height / 2
            let fullWidth = geometry.size.width
            
            VStack {
                Spacer()
                Text("Half Height")
                    .frame(width: fullWidth, height: halfHeight)
                    .background(Color.red.opacity(0.4))
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

/*
 
challenge - grid of resizing squares
 
Use GeometryReader to create a 2x2 grid of squares that:
Fills the available space evenly
Adjusts responsively on screen size change
Each square has a different color
 
 🧠 Questions to Think About After:
 What happens if you change the spacing between items?
 What if you replace a Color with a Text or Image — how do you keep it centered inside the square?
 Try using .border() or .padding() — how does it affect the layout?
 
*/

struct GridWithGeometryReaderStart: View {
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width / 2
            let height = geometry.size.height / 2
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Color.red
                        .frame(width: width, height: height)
                    Color.green
                        .frame(width: width, height: height)
                }
                HStack(spacing: 0) {
                    Color.blue
                        .frame(width: width, height: height)
                    Color.orange
                        .frame(width: width, height: height)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct GridWithGeometryReaderSolution: View {
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width / 2
            let height = geometry.size.height / 2
            
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Color.red
                        .frame(width: width, height: height)
                    Color.green
                        .frame(width: width, height: height)
                }
                HStack(spacing: 10) {
                    Color.blue
                        .frame(width: width, height: height)
                    Color.orange
                        .frame(width: width, height: height)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct GridWithGeometryReaderSolution2: View {
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width / 2
            let height = geometry.size.height / 2
            
            VStack(spacing: 0) {
                Text("width: \(width)")
                Text("height: \(height)")
            }
//            .ignoresSafeArea()
        }
    }
}

struct PositionEx: View {
    var body: some View {
        Text("PositionEx")
            .background(.red)
            .position(x:100, y:100)
    }
}

struct ResizingFourSquars: View {
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0){
                Color.getRandom()
                Color.getRandom()
            }
            HStack(spacing:0){
                Color.getRandom()
                Color.getRandom()
            }
        }
    }
}

struct GridWithGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width / 2
            let height = geometry.size.height / 2
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Color.red
                        .frame(width: width, height: height)
                    Color.green
                        .frame(width: width, height: height)
                }
                HStack(spacing: 0) {
                    Color.blue
                        .frame(width: width, height: height)
                    Color.orange
                        .frame(width: width, height: height)
                }
            }
            .ignoresSafeArea()
        }
    }
}


/*
 
 
 
 understand that the parents asks the child how much space they need.
 this repeats to the next view
 and finally ends at the last view
 then.. it reverses.
 the last view modifier --> next to last --> next next to last
 the parent gets how much space the child needs
 then the parents decides how much space to actally give their child
 the content view starts with the full size point sizing
 
 this can occur starting from body --> Text --> modifiers
 
 */




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        GridWithGeometryReader()
      

    }
}
