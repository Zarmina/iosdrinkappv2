

import SwiftUI

struct DrinkView: View {
//    @State private var isPresented: Bool = false
    @State var selectedTab = "mug"
    @Binding var amount: Int
    var body: some View {
        VStack {
//            Button(action: {
//                print("button tapped")
//                isPresented = true
//            }, label: {
//                Text("Add drink")
//            })
//            .buttonStyle(.borderedProminent)
//            .sheet(isPresented: $isPresented) {
//                Buttons(isPresented: $isPresented)
//            }
            Buttons()
//            HStack{
//                Spacer()
//                Button(action: {}, label: {
//                    Text("Cancel")
//                })
//                .frame(width: 100, height: 50)
//                .background(Color.omringColor)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//                .padding(.top, 50)
//                Spacer()
//                Button(action: {}, label: {
//                    Text("Add Drink")
//                })
//                .frame(width: 100, height: 50)
//                .background(Color.omringColor)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//                .padding(.top, 50)
//                Spacer()
//            }
        }
//        Buttons(isPresented: .constant(false))
    }
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView(amount: .constant(0))
    }
}

struct Buttons: View {
//    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            
            HStack{
                Button(action: {
                    print("100ml button tapped")
                    logAmount(amount: 10)
                }, label: {
                    VStack {
                        Spacer()
                        Image(systemName: "mug")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 40)
                            .foregroundColor(Color.white)
                            .padding(20)
                        //                        .padding(.top, 100)
                            .font(.system(size: 20))
                        Spacer()
                        Text("100ml")
                            .padding(.top, 20)
                            .foregroundColor(Color.white)
                            .font(.system(.title, weight: .bold))
                    }
                    .frame(width: 150, height: 300)
                    .background(Color.appBlue)
                })
                .cornerRadius(20)
                Button(action: {
                    print("200ml button tapped")
                    logAmount(amount: 20)
                }, label: {
                    
                    VStack {
                        Spacer()
                        Image(systemName: "mug")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 150)
                            .foregroundColor(Color.white)
                        //                        .padding(20)
                        //                        .padding(.top, 100)
                            .font(.system(size: 20))
                        Spacer()
                        Text("200ml")
                            .padding(.top, 20)
                            .foregroundColor(Color.white)
                            .font(.system(.title, weight: .bold))
                    }
                    .frame(width: 150, height: 300)
                    .background(Color.appBlue)
                    
                })
                .cornerRadius(20)
                Button(action: {
                    print("300ml button tapped")
                    logAmount(amount: 30)
                }, label: {
                    
                    VStack {
                        Spacer()
                        Image(systemName: "mug")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 250)
                            .foregroundColor(Color.white)
                        //                        .padding(20)
                        //                        .padding(.top, 100)
                            .font(.system(size: 20))
                        Spacer()
                        Text("300ml")
                        //                        .padding(.top, 20)
                            .foregroundColor(Color.white)
                            .font(.system(.title, weight: .bold))
                    }
                    .frame(width: 150, height: 300)
                    .background(Color.appBlue)
                    
                    
                })
                .cornerRadius(20)
                
                
            }
            
        }
    }
    func logAmount(amount: Int) {
        let webService = WebService.shared
        webService.drinkAmount(amount: amount) { result in
            switch result {
            case .success(let drinkResponse):
                
                print("did it: \(drinkResponse)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
