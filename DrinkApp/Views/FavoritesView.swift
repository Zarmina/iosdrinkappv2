

import SwiftUI

struct FavoritesView: View {
    @State var selectedTab = "heart"
    var body: some View {
        VStack{
            Color.white
            Text("favorites").padding(50)
            Spacer()
            
            // navbar area
//            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
