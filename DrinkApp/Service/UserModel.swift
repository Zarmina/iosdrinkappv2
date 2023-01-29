

import Foundation

struct UserModel: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let id: UUID
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let dailyLimit: Int
    let dailyGoal: Int
//    var achieved: Int
//    var amountLeftToLimit: Int
    //    var password: String = ""
    
    
}

struct UserInfo {
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var dailyLimit: Int
    var dailyGoal: Int
    var achieved: Int
    var amountLeftToLimit: Int
}
