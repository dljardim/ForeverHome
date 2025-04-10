/*
 
 challenge
 
 When the button is tapped:
 The dragon flies in from the left (use .offset)   // changed image to cat
 While flying, the dragon fades in (opacity)
 Then spins and disappears (rotationEffect, then fade out)
 All animations must happen smoothly in sequence.
 Bonus: Make it repeatable or reset so the user can summon the dragon again.
 
 _dev notes:
 
 4/9/2025
 I could not solve this one.  I had trouble taking removing the x axis movement
 and the flip effect I assumed the challenge needed.
 
 Scale effect was used in flip effect
 .scaleEffect(x: isFlipped ? -1 : 1, y: 1) // face left/right
 
 and the dispatch queue was used to seperate the movement from the flip actions

 
 */
import SwiftUI


struct FlyingCatView: View {
    // changed from fly to hasFlown - change in naming convention
    // stopping point
    @State private var flyIsComplete =  false
        
    let cgSizeStart = CGSize(width: -150.0, height: 0.0)
    let cgSizeEnd = CGSize(width: 150.0, height: 0.0)
    @State private var catImage = Image(systemName: "cat")
    
    
    var body: some View {
        VStack {
            Spacer()
            
            catImage
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .offset(flyIsComplete == false ? cgSizeStart : cgSizeEnd)
                .opacity(flyIsComplete == false ? 0 : 1)
                
            
//                .rotationEffect(
//                    .degrees(180.0),
//                    anchor: .center
//                ) /// rotation is causing issues -


            Spacer()
            
            Button("Meow") {
                withAnimation{
                    flyIsComplete.toggle()
                }
                

            }
            .padding()
        }
    }
}


struct FlyingCatViewSolution: View {
    @State private var flyIsComplete = false
    @State private var rotationAngle = 0.0
    
    let cgSizeStart = CGSize(width: -150.0, height: 0.0)
    let cgSizeEnd = CGSize(width: 150.0, height: 0.0)
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "cat")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .offset(flyIsComplete ? cgSizeEnd : cgSizeStart)
                .opacity(flyIsComplete ? 0 : 1)
                .rotationEffect(.degrees(rotationAngle))
            
            Spacer()
            
            Button("Meow") {
                withAnimation {
                    flyIsComplete.toggle()
                    rotationAngle += 360
                }
            }
            .padding()
        }
    }
}

struct BoomerangCatView: View {
    @State private var isOnRight = false
    @State private var isFlipped = false
    
    let offsetAmount: CGFloat = 150
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "cat")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .scaleEffect(x: isFlipped ? -1 : 1, y: 1) // face left/right
                .offset(x: isOnRight ? offsetAmount : -offsetAmount)
                .animation(.easeInOut(duration: 1.0), value: isOnRight)
                .animation(.easeInOut(duration: 0.3), value: isFlipped)
            
            Spacer()
            
            Button("Meow") {
                launchAndReturn()
            }
            .padding()
        }
    }
    
    func launchAndReturn() {
        // Step 1: Launch right
        withAnimation {
            isOnRight = true
        }
        
        // Step 2: After arriving, FLIP first...
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                isFlipped = true
            }
            
            // Step 3: THEN fly back left
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    isOnRight = false
                }
                
                // Step 4: FLIP back to original direction
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isFlipped = false
                    }
                }
            }
        }
    }
}



#Preview {
//    FlyingCatViewSolution()
    BoomerangCatView()
}
