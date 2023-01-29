

import Foundation
import SwiftUI

protocol UserManagerDelegate {
    
}

class WebService {
    static let shared = WebService()
    let authUrl = ""
    let loginUrl = "https://da-authentication.azurewebsites.net/api/v1/login"
    private var user: UserModel?
    @AppStorage("user") private var storedUser: Data = Data()
    @AppStorage("token") private var token: String = ""
    private var userInfo: UserInfo?
    
    private init() {
        
    }
    
    
    func getUser() -> UserInfo? {
        setUserInfo()
        if let info = user {
            print(info)
        }
        else {
            print("this shit is null \(user)")
        }
        return userInfo
    }
    
    func loginUser(userName: String, password: String) -> String {
        let url = "https://da-authentication.azurewebsites.net/api/v1/login"
        //        return performLogin(withUrl: url)
        return ""
    }

    func performLogin(userName: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: loginUrl) else {
            completion(.failure(.custom(errorMessage: "URL is wrong")))
            return
        }
        let body = LoginDTO(phoneNumber: userName, password: password)
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.accessToken else {
                
                completion(.failure(.invalidCredentials))
                return
            }
            DispatchQueue.main.async {
                self.parseJson(data)
            }
            
            self.token = token
            completion(.success(token))
            
        }.resume()
        
    }
    func parseJson(_ userData: Data) {
        DispatchQueue.main.async {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(UserModel.self, from: userData)
                
                self.user = decodedData
                self.storedUser = userData
                self.setUserInfo()
            } catch {
                print(error.localizedDescription)
                
            }
        }
    }
    func setUserInfo() {
        
        //        DispatchQueue.main.async {
        self.getToday { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                
                //                    self.userInfo.amountLeftToLimit = response.amountLeftToLimit!
                //                    self.userInfo.achieved = response.achieved!
                self.userInfo = UserInfo(id: self.user!.id , firstName: self.user!.firstName, lastName: self.user!.lastName , email: self.user!.email , phoneNumber: self.user!.phoneNumber , dailyLimit: self.user!.dailyLimit , dailyGoal: self.user!.dailyGoal , achieved: response.achieved ?? -2, amountLeftToLimit: response.amountLeftToLimit ?? -5)
            }
        }
        
        //        }
        
    }
    func getToday(completion: @escaping (Result<LogDrinkResponse, AuthenticationError>) -> Void) {
        if let user = self.user {

            let urlString = "https://da-users.azurewebsites.net/api/v1/patients/drinks/today/\(user.id)"
            guard let url = URL(string: urlString) else {
                completion(.failure(.custom(errorMessage: "URL is wrong")))
                return
            }
            
            var req = URLRequest(url: url)
            req.httpMethod = "GET"
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            req.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: req) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(.custom(errorMessage: "No data")))
                    print(":? is it?")
                    return
                }
                guard let ldResponse = try? JSONDecoder().decode(LogDrinkResponse.self, from: data) else {
                    completion(.failure(.invalidCredentials))
                    print(":? or no?")
                    return
                }

    //            self.userInfo.amountLeftToLimit = ldResponse.amountLeftToLimit ?? -1
    //            self.userInfo.achieved = ldResponse.achieved ?? -1
                completion(.success(ldResponse))
                
            }.resume()
        }
        
    }

    func drinkAmount(amount: Int, completion: @escaping (Result<LogDrinkResponse, AuthenticationError>) -> Void) {
        let urlString = "https://da-users.azurewebsites.net/api/v1/patients/logdrink?amount=\(amount)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.custom(errorMessage: "URL is wrong")))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))

                return
            }
            guard let ldResponse = try? JSONDecoder().decode(LogDrinkResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))

                print(data)
                return
            }
  
//            self.user?.amountLeftToLimit = ldResponse.amountLeftToLimit ?? -1
//            self.user?.achieved = ldResponse.achieved ?? -1
            completion(.success(ldResponse))
            
        }.resume()
        
    }
//
//    func login(userName: String, password: String) async -> Result<String, AuthenticationError> {
//        // call with checked continuation
//        return await withCheckedContinuation { continuation in
//            // call the original function
//            performLogin(userName: userName, password: password) { result in
//                continuation.resume(returning: result)
//            }
//        }
//    }
    
    
    //    func performLogin(userName: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
    //        guard let url = URL(string: url) else {
    //            completion(.failure(.custom(errorMessage: "URL is wrong")))
    //            return
    //        }
    //        let body = LoginDTO(phoneNumber: userName, password: password)
    //        var req = URLRequest(url: url)
    //        req.httpMethod = "POST"
    //        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //        req.httpBody = try? JSONEncoder().encode(body)
    //
    //        URLSession.shared.dataTask(with: req) { data, response, error in
    //            guard let data = data, error == nil else {
    //                completion(.failure(.custom(errorMessage: "No data")))
    //                return
    //            }
    //            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
    //                completion(.failure(.invalidCredentials))
    //                return
    //            }
    //
    //            guard let token = loginResponse.accessToken else {
    //
    //                completion(.failure(.invalidCredentials))
    //                return
    //            }
    //            self.parseJson(data)
    //            completion(.success(token))
    //
    //        }.resume()
    //
    //    }
}


enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LogDrinkResponse: Codable {
    let dailyGoal: Int?
    var achieved: Int?
    let dailyLimit: Int?
    var drankNow: Int?
    var amountLeftToLimit: Int?
}

struct LoginDTO: Codable {
    let phoneNumber: String
    let password: String
}
struct LoginResponse: Codable {
    let accessToken: String?
    let tokenType: String?
    let expiresIn: Double?
}

//struct User: Hashable, Codable {
//    let id: UUID
//    let firstName: String
//    let lastName: String
//    let phoneNumber: String
//    let dailyLimit: Int
//    let dailyGoal: Int
//    let likedRecipes: [RecipeModel]
//
//}
