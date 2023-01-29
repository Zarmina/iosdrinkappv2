

import SwiftUI

//struct ContentView: View {
//    @State var selectedTab = "house"
//    var home = HomeView()
//    var recipes = RecipesView()
//    var drinks = DrinkView()
//    init(){
//        UITabBar.appearance().isHidden = true
//    }
//
//    var body: some View {
//
//        VStack{
//
//            TopBar()
//            Spacer()
//            if ( selectedTab == "house" || selectedTab == "house.fill")
//            {
//                VStack{
////                    HomeView()
//                    home
//                }
//
//
//            }
//            else if ( selectedTab == "heart" || selectedTab == "heart.fill")
//            {
//                VStack{
//                    RecipesView()
//                }
//
//            }
//            else if ( selectedTab == "mug" || selectedTab == "mug.fill")
//            {
//                VStack{
//                    DrinkView()
//                }
//
//            }
//            else if ( selectedTab == "square.and.arrow.up" || selectedTab == "square.and.arrow.up.fill")
//            {
//                VStack{
//                    ShareView()
//                }
//
//            }
//            VStack {
//                Spacer()
//                CustomTabBar(selectedTab: $selectedTab)
//            }
//        }
//    }
//}

struct ContentView: View{
    @AppStorage("status") var loggedIn = false
    init(loggedIn: Bool = false) {
        self.loggedIn = loggedIn
    }
    @State var selectedTab = "house"
    var body: some View{
        
        NavigationView{
//            Login()
            VStack{
                if !loggedIn {
                    Login()

                        .navigationBarHidden(true)
                }
                else {
                    Dashboard()

                }

            }


        }
        .navigationViewStyle(.stack)
    }
        
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


