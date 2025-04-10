/*
 
 _devnotes:
 
    DispatchQueue.main.async{...}
    DispatchQueue.global.async{...}
    Task {await doSomethingAsync()}
    await
 
 */
import SwiftUI




struct ConcurrencyEx: View {
    
    func makePizza() {
        DispatchQueue.global().async{
            print("🍕 Starting pizza...")
            sleep(5)
            DispatchQueue.main.async{
                print("✅ Pizza ready!")
            }
        }
    }
    
    func makePizzaIssue() {
        DispatchQueue.global().async {
            print("🍕 Starting pizza...")
            sleep(5)
            print("✅ Pizza ready!") // 😬 No main thread here!
            // updating from background thread causes - crashes , warnings, bugs, flickering
        }
    }


    
    func sayHelloOnMainThread() {
        print("Preparing greeting...")
        
        DispatchQueue.main.async {
            print("👋 Hello from the main thread!")
        }
    }
    
    func loadUsername() {
        DispatchQueue.global().async {
            let username = "Taylor Swift" // pretend this is slow work
            
            // 👇 Fill in the blank to update UI on the main thread
            DispatchQueue.main.async {
                print("Welcome, \(username)")
            }
        }
    }
    
    
    func neverOnTheMainThread(){
        print("........ long running process ....... ")
        sleep(5)
        print("returning from neverOnTheMainThread() ")
    }


    
    @State private var statusMessage = "Waiting..."
    
    
    var body: some View {
        Text("status: \(statusMessage)")
        Button("makePizza"){
            DispatchQueue.global().async{
                statusMessage = "🍕 Starting pizza..."
                sleep(5)
                statusMessage = "✅ Pizza ready!"
            }


        }.buttonStyle(.borderedProminent)
    }
}



#Preview {
    ConcurrencyEx()
    //    ConcurrencyEx()
}

/*
 
sleep(2) is called on the main thread - app becomes unresponsive until sleep(2) is complete.
 
 */
