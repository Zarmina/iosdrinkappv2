

import SwiftUI

struct TopBar: View {
    @State var selectedTab = "house"
    var body: some View {
        
        
        HStack(spacing: 0){
            HStack{
                Spacer()
            }
            Spacer()
            Image("MonaProf")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .foregroundColor(.blue)
                .shadow(radius: 10)
                
//            Spacer()
            
        }
        .frame(maxWidth: UIScreen.screenWidth - 10, maxHeight: UIScreen.screenHeight / 14)
        .background(Color.pulsatingColor)
        .cornerRadius(30)
        
        
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
