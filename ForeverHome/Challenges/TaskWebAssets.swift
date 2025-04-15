/*
 
 Let’s say we’re loading an image from the web (pretend function below):
 
 func loadImageFromWeb() async -> UIImage? {
 // Pretend slow async download
 }
 ❓You want to call loadImageFromWeb() when a view appears and update the UI with the image.
 What would that SwiftUI code look like?
 
 */

import SwiftUI

//
struct TaskWebAssets: View {
    
    @State private var imageFromWeb:Image? = nil

    func loadImageFromWeb() async {
        let url = URL(string: "https://via.placeholder.com/150")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                let swiftUIImage = Image(uiImage: uiImage)
                imageFromWeb = swiftUIImage
            }
        } catch {
            print("❌ Failed to load image: \(error)")
        }
    }
    
    var body: some View {
        VStack{
            Text("TaskWebAssets")
            
        }.onAppear{
            Task {
                // use await when calling a func called async !!!
                await loadImageFromWeb()
            }
        }
        
    }

}

struct TaskWebAssetsTest1: View {
    var body: some View {
        Button("Run"){
            let urlString = "https://www.apple.com"
            
            if let urlLet = URL(string: urlString){
                print("urlLet: \(urlLet)")
            }
            
            guard let urlGuard = URL(string:urlString) else {return}
            print("urlGuard: \(urlGuard)")
        }
    }
}


#Preview {
    TaskWebAssetsTest1()
}


/*
 
 can you create a mini lesson on each of these questions with a few exercises to reinforce my knowledge.
  
i've not sseen URL before.  What does it do? how is it different from a string.
 
coming from c# i am used to seeing try / catch / finally.  Why do we need a do {...} ?
 
 let (data, _) =  // is this a tuple?
 
 While I have seen _ be used in a function definition for the purpose of not having to type the parameter name.  I dont now what  is the _ means in this case.
 
 what is URLSession?  what is it used for?
 
 what is the difference between UIImage and Image ?
 
 do i always need to use task and await when calling a async function.
 
 Where did the \(error) come from ? is that a global variable?
 
 
 
 }
 
 

 w
 */
