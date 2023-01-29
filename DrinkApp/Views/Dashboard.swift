

import SwiftUI

struct Dashboard: View {
    @State var selectedTab = "house"
//    private var homeView: HomeView
    init() {
        UITabBar.appearance().isHidden = true
//        self.homeView = HomeView(selectedTab: $selectedTab)
    }
    
    // location for each curve
    @State var xAxis: CGFloat = 0
    
    @Namespace var animation
    
    private var recipesView = RecipesView()
    private var drinkView = DrinkView(amount: .constant(0))
    
    
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            VStack {
                TopBar()
                TabView(selection: $selectedTab) {
                    HomeView(selectedTab: $selectedTab)
//                        .ignoresSafeArea(.all, edges: .all)
                        .padding(.bottom, 150)
                        .padding(.top, 50)
                        .tag("house")
                    recipesView
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("heart")
                    drinkView
//                    Color(.cyan)
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("mug")
                    Color(.systemPink)
                        .ignoresSafeArea(.all, edges: .all)
                 }
            }
            
            // custom tab bar
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self){image in
                    GeometryReader {reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedTab = image
                                xAxis = reader.frame(in: .global).minX

                            }
                        }, label: {
                            Image(systemName: image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
//                                .foregroundColor(selectedTab == image ? getColor(image: image) : Color.white)
                                .foregroundColor(Color.white)
                                .padding(selectedTab == image ? 15 : 0)
                                .font(selectedTab == image ? .system(size: 30, weight: .bold) : .system(size: 20))
                                .background(Color.appBlue.opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedTab == image ? -60 : 0)
                            
                        })
                        .onAppear {
                            if image == tabs.first{
                                xAxis = reader.frame(in: .global).minX
                            }

                        }
                    }
                    .frame(width: 50, height: 50)
                    if image != tabs.last{Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal, 60)
            .padding(.vertical)
            .background(Color.appBlue.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(24))
            
            .padding(.horizontal)
            // bottom edge
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
    // getting the image color
    func getColor(image: String) -> Color {
        switch image {
        case "house":
            return Color.purple
        case "heart":
            return Color.mint
        case "mug":
            return Color.purple
        case "square.and.arrow.up":
            return Color.mint
        default:
            return Color.omringColor
        }
    }
}

var tabs = ["house", "heart", "mug", "square.and.arrow.up"]


// Curve
struct CustomShape: Shape {
    var xAxis: CGFloat

    // animating path
    var animatableData: CGFloat{
        get{return xAxis}
        set{xAxis = newValue}
    }
    
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x:0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            path.move(to: CGPoint(x: center - 90, y: 0))
            
            let to1 = CGPoint(x: center, y: 60)
            let control1 = CGPoint(x: center - 50, y: 0)
            let control2 = CGPoint(x: center - 50, y: 60)
            
            let to2 = CGPoint(x: center + 90, y: 0)
            let control3 = CGPoint(x: center + 50, y: 60)
            let control4 = CGPoint(x: center + 50, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
