

import SwiftUI

struct view: View {
    @State var pass: String = "new"
    var body: some View {
        VStack {
            TextField("mail", text: $pass)
            Button("tap me") {
                print("tapped")
            }
        }
        
    }
}

struct view_Previews: PreviewProvider {
    
    static var previews: some View {
        view()
    }
}
