

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    @State var percentage: CGFloat = 0
    @State var toggle = false
    @AppStorage("user") private var storedUser: Data = Data()
    @AppStorage("status") var loggedIn = false

    var drinkView = DrinkView(amount: .constant(0))

    
    var body: some View {
        // the main container for the whole page
        VStack{
            
            Spacer(minLength: 0)
            // the daily goal text
            Text("Today's Goal: \(WebService.shared.getUser()?.dailyGoal ?? -1 )").font(.system(size: 40, weight: .bold))
                .bold()

            // the Hstack for the top of the page and the rain drop
            HStack(alignment: .center){
                

                VStack {
                    IntakeBar(percentage: $percentage)
                        .padding(.leading, 50)
 
                }
                
                VStack {
                    // z stack for the motivation text
                    ZStack{
                        Image("Bubble").padding(.top).scaledToFit()
                        Text("this is it: \(WebService.shared.getUser()?.achieved ?? -7)").foregroundColor(.black).fontWeight(.semibold)
//                        Text("some shit").foregroundColor(.black).fontWeight(.semibold)
                    }
                    
                    Image("RainDrop").padding(.bottom).scaledToFit()
                    Spacer()
                }.padding(.vertical).frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight / 3 - 20)
                
                
            }.frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight / 3)
            // end of h stack for top of page
            
            // middle of the page aka the buttons
            // hstack for the buttons
            
            HStack {
//                Button(action: {percentage = 85}) {
//                    Image("fluidIntke")
//                }
                Button(action: {
                    selectedTab = "mug"
                    percentage = 85
                    
                }) {
                    Image("fluidIntke")
                }
                Button(action: {
                    selectedTab = "heart"
                    
                }) {
                    Image("recipes")
                }
                
            }
            // end of middle of the page hstack
            
            
            Spacer(minLength: 0)
        }

        .frame(maxWidth: UIScreen.screenWidth - 20, maxHeight: UIScreen.screenHeight - 20)
            
        
        
    }
        
//    func getUser() -> UserInfo? {
//        let decoder = JSONDecoder()
//        do {
//
////            let decodedData = try decoder.decode(UserModel.self, from: storedUser)
//            let user = WebService.shared.getUser()
////            return decodedData
//            return user
//
//        } catch {
//            print(error.localizedDescription)
//
//        }
//        return nil
//    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedTab: .constant("house"))
    }
}

struct IntakeBar: View {
    
    @Binding var percentage: CGFloat
    
    var body: some View {
        
        // z stack for the prgoress view
        ZStack{
            // the pulsation effect
//            Pulsation()
            // Tracking circle
            Track()
            // the percentage label
            Label(percentage: percentage)
            // the outline of the circle
            Outline(percentage: percentage).rotationEffect(.degrees(270))
            
            
        }
        
    }
    
}

struct Label: View {
    var percentage : CGFloat = 0
    var body: some View {
        ZStack{
            Text(String(format: "%.0f", percentage)).font(.system(size: 65)).fontWeight(.heavy).foregroundColor(.black)
        }
    }
}
struct Outline: View {
    var percentage : CGFloat = 0
    var colors: [Color] = [Color.omringColor]
    
    var body: some View {
        // theres gonna be an animation with layersso we'll use a zstack
        ZStack{
            // the circle for the animation
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height: 250)
                .overlay {
                    Circle()
                        .trim(from: 0, to: percentage * 0.01)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
                }.animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
        }
    }
    
}

struct Track: View {
    var colors: [Color] = [Color.trackColor]
    var body: some View {
        ZStack{
            Circle() // same as background color to hide the pulsating layer
                .fill(Color.white)
                .frame(width: 250, height: 250) // same as outline
                .overlay (
                    Circle() // same stroke size as the outline
                        .stroke(style: StrokeStyle(lineWidth: 20))
                    // gradient same as the track stroke color
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center))
                )
        }
    }
}

struct Pulsation: View {
    
    @State private var pulsate = false
    var colors: [Color] = [Color.pulsatingColor]
    @State private var toggle = false
    
    var body: some View {
        
        ZStack{
            // the pulsating circle
            Circle()
                .fill(Color.pulsatingColor)
                .frame(width: 245, height: 245) // less than the other layer so it can disappear behind the other layer
                .scaleEffect(pulsate ? 1.3 : 1.1)
                .animation(Animation.easeInOut(duration: 1.1).repeatForever(autoreverses: true))
//                    .repeatCount(toggle ? 3 : 0)
                    .onAppear{
                    self.pulsate.toggle()
                }
        }
    }
    
}
