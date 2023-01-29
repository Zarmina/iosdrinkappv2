

import SwiftUI

struct randomview: View {
    @State var someText: String = "some shit"
    var body: some View {
        VStack{
            Text("here is a textfield")
            TextField("Email", text: $someText)
        }
    }
}

struct randomview_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
