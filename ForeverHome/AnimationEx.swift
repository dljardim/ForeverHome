//
//  AnimationEx.swift
//  ForeverHome
//
//  Created by Damian Jardim on 4/5/25.
//

import SwiftUI

struct AnimationEx: View {
    @State private var isBig = false

    var body: some View {
        Button{
            isBig.toggle()
        }label:{
            Text("\(isBig ? "Big" : "Small")")
                .frame(width: isBig ? 200 : 100, height: isBig ? 200 : 100)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        
    }
}

struct MagicButtonView: View {
    @State private var isBig = false
    
    var body: some View {
        Button("Tap Me!") {
            isBig.toggle()
        }
        .frame(width: isBig ? 200 : 100, height: isBig ? 200 : 100)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}


struct MagicButtonViewSolution: View {
    @State private var isBig = false
    
    var body: some View {
        Button("Tap Me!") {
            withAnimation(.easeInOut){
                isBig.toggle()
            }
        }
        .frame(width: isBig ? 200 : 100, height: isBig ? 200 : 100)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}

/*
 //
 What you changed.
 - added animation modifiers
 
 Why it works.
 - added an animation modifier and value.  When the value changes, the frame animates the alteration
 
 what kind of animation behavior is the default
 - easeInOut is the default
 How you could make it feel more fun.?
 - alter other properties to change:  color, text, typeOfAnimation .easein / linear / bounce, make it repeat
 
 - i've made it more fun with a sequence humorous messages, a hidden image, and a reset event to start again.
 
 
 */
struct MagicButtonViewSolution2: View {
    @State private var isBig = false
    @State private var messageIndex = 0
    
    var messages = ["Don't touch me!", "I said don't touch me", "Can't you read?", "Why are you doing this", "STOP!!!!!", "That's it, I Quit", ""]
    
    var displayMessage:String {
        if messageIndex < messages.count {
            return messages[messageIndex]
        }else {
            return ""
        }
    }
   
    
    var body: some View {
        VStack{
            Button(displayMessage) {
//                isBig.toggle()
                withAnimation {
                    isBig.toggle()
                }
                if messageIndex < messages.count - 1 {
                    messageIndex += 1
                }
            }
            .frame(width: isBig ? 300: 200, height: isBig ?  400: 400)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
//            .animation(.easeInOut(duration: 0.4), value: isBig) // 🎯 animate size changes

            Spacer()
            
            Image("outOfOrder")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .opacity((messageIndex == messages.count - 1) ? 1 : 0)
//                .animation(.easeInOut(duration: 0.5), value: messageIndex)
                .onTapGesture {
                    messageIndex = 0
                }
        }
        .padding()
    }
}

struct MagicButtonViewSolution3: View {
    @State private var isBig = false
    @State private var degrees = Double.zero
    
    
    var body: some View {
        Button("Tap Me!") {
//            isBig.toggle()
            degrees = (degrees == .zero) ? 360 : .zero
        }
        .frame(width: isBig ? 400 : 300, height: isBig ? 200 : 300)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotationEffect(.degrees(degrees))
    }
}

struct AnimationEx2: View {
    @State private var size:Double = 0.0
    
    var body: some View {
        Circle()
            .frame(width: size)
//            .animation(.easeInOut(duration: 0.3), value: size)
        
        Button("Grow"){
            withAnimation{
                size += 50
            }
        }
    }
}


struct FlyingCatzilla: View {
    @State private var fly = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("dragon")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            // 🧙 Add animation modifiers here
            
            Spacer()
            
            Button("Summon Catzilla") {
                // 🧙‍♂️ Animate the dragon’s flight across the screen!
            }
            .padding()
        }
    
    }
}

struct RotationAnimationView: View {
    @State private var rotation: Double = 0
    
    var body: some View{
        VStack(spacing:40){
            Rectangle()
                .fill(Color.green)
                .frame(width:100, height:100)
                .rotationEffect(.degrees(rotation))
                .animation(.easeIn(duration: 1.0), value: rotation)
            Button{rotation += 45}label:{Text("Rotate")}
                .buttonStyle(.borderedProminent)
        }
        .padding()
        
    }
}

struct SpringAnimation: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack{
            Circle()
                .fill(Color.blue)
                .frame(width:100, height: 100)
                .scaleEffect(scale)
                .animation(
                    .spring(
                        response: 0.5,
                        dampingFraction: 0.3,
                        blendDuration: 0
                    ),
                    value: scale
                    )
            
            Button{scale = scale == 1.0 ? 1.5: 1.0}
                label:{Text("Spring Animation")
            }
                
        }
    }
}

struct CustomTiming: View {
//    @State private var scale: CGFloat = 1.0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.orange)
                .frame(width: 100, height: 100)
                .offset(x: offset)
                .animation(Animation.timingCurve(0.2, 0.8, 0.2, 1.0, duration: 2.0), value: offset)
            
            Button("Move") {
                offset = offset == 0 ? 200 : 0
            }
            .padding()
        }
    }
}

struct MultiplePropertiesAnimationView: View {
    
    // The state that is controling the animation does not have to be
    // tied to a change of a ui element like offset or size
    // but rather just use a toggle property
    // multiple animations below
    @State private var change = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: change ? 50 : 0)
                .fill(change ? Color.purple : Color.yellow)
                .frame(width: change ? 200 : 100, height: change ? 200 : 100)
                .rotationEffect(.degrees(change ? 45 : 0))
                .animation(.easeInOut(duration: 1.0), value: change)
            
            Button("Animate") {
                change.toggle()
            }
            .padding()
        }
    }
}


#Preview {
//    MagicButtonViewSolution()
//    MagicButtonViewSolution2()
//    MagicButtonViewSolution3()

//    AnimationEx2()
//    FlyingCatsView()
    RotationAnimationView()
    SpringAnimation()
    CustomTiming()
    MultiplePropertiesAnimationView()

}
