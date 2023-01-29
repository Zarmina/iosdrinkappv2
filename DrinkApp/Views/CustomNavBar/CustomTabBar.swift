

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: String
    // store each tap midpoint to animate it in the future
    @State var tabPoints : [CGFloat] = []
    
    var body: some View {
        
        HStack(spacing: 0){
            
            // Tab Bar Buttons
            TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "heart", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "mug", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "square.and.arrow.up", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(Color("Blue")
            .clipShape(TabCurve(tabPoint: getCurvePoint() - 15)))
        .overlay(
        Circle()
            .fill(Color("Blue"))
            .frame(width: 10, height: 10)
            .offset(x: getCurvePoint() - 20)
        ,alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
        
    }
    
    // extract the point
    func getCurvePoint()->CGFloat{
        // if the tap point is empty
        if tabPoints.isEmpty{
            return 10
        }
        else{
            switch selectedTab{
            case "house":
                return tabPoints[0]
            case "heart":
                return tabPoints[1]
            case "mug":
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
        
        
    }
    
}

struct CustomTabBar_Previews: PreviewProvider {
    
    static var previews: some View {
        
//        CustomTabBar(selectedTab: "house")
        HomeView(selectedTab: .constant("house"))

    }
}
struct TabBarButton: View{
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints : [CGFloat]
    
    var body: some View{
        
        // for getting mid point of each button for the curve animation
        GeometryReader{reader -> AnyView in
            
            // extractin mid point and storing it
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                // avoid junk data
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: {
                    // change tab
                    // spring animation
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
                        selectedTab = image
                        
                    }
                }, label: {
                    // fill the color if its selected

                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color.white)
                    // lifting view if its selected
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                // max frame
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            )
            
            
        }
        // max height
        .frame(height: 50)
    }
}
