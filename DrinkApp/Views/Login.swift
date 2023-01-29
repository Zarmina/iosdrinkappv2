

import SwiftUI
import LocalAuthentication

struct Login: View {
    // 6c19a1fc-b3f3-40e3-b24f-9a56a9d9478d
    @State var userName = "+31612312312"
    @State var password = "Mona12345!"
//    @StateObject private var vieModle = UserInfo()
    @AppStorage("stored_User") var user = "+31612312312"
    @AppStorage("user") private var storedUser: Data = Data()
    @AppStorage("status") var loggedIn = false

    
    var body: some View {
        
        VStack{
            Spacer(minLength: 0)
            Image("DrinkImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
//                            .frame(width: 250)
            // dynamic frame
                .padding(.horizontal, 200)
                .padding(.vertical)
            
            // the login and please login hstack
            HStack {
                
                VStack(alignment: .leading, spacing: 12, content: {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign in to continue")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                
                Spacer(minLength: 0)
            }
                        .padding(.leading, 200)
                        .padding(.trailing, 200)
            
            // the username hstack
            HStack {
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                
                
                TextField("EMAIL", text: $userName)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
                        .padding(.leading, 200)
                        .padding(.trailing, 200)
            
            
            // the password hstack
            HStack {
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                TextField("PASSWORD", text: $password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
                        .padding(.leading, 200)
                        .padding(.trailing, 200)
            .padding(.top)
            
            // buttons hstack
            HStack (spacing: 15){
                // login button
                Button {
                    print("button tapped")
                    loginUser()
                } label: {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 500)
                        .background(Color.omringColor)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                }
                
                .opacity(userName == "" && password == "" ? 0.5 : 1)
                .disabled(userName == "" && password == "")
                
                if getBioMetricStatus() {
                    // biometric
                    Button {
                        print("biometrics tapped")
                        authenticateBiometrics()
                    } label: {
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.omringColor)
                            .clipShape(Circle())
                    }
                }
                
                
            }
            .padding(.top)
            
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Dont have an account yet?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: {
                    
                }, label: {
                    Text("Signup")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.omringColor)
                })
            }
            .padding(.vertical)
            
        }
        .background(Color.appBlue.ignoresSafeArea(.all, edges: .all))
        .animation(.easeOut)
        
        
    }
    
    func loginUser() {
        let webService = WebService.shared

        print("method is called")
        webService.performLogin(userName: userName, password: password) { result in
            switch result {
            case .success(let token):
                loggedIn = true
                print("this is the user: \(webService.getUser())")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        let user = webService.getUser()
//        print(user?.firstName)


    }
    func authenticateBiometrics() {
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(userName)") { status, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            // setting loggedin status as true
            withAnimation(.easeOut) {loggedIn = true}
        }
    }
    
    // Getting biometric type
    func getBioMetricStatus() -> Bool {
        let scanner = LAContext()
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

