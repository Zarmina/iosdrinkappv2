

import SwiftUI

struct ShareView: View {
    @State var selectedTab = "square.and.arrow.up"
    var body: some View {
        VStack{
            Color.white
            Text("shares").padding(50)
            Spacer()
            
            // navbar area
//            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
