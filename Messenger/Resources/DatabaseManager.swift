//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Andrey on 2/12/23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    
    private let database = Database.database().reference()
    
    static func safeEmail(emailAddress: String) -> String {
            var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            return safeEmail
        }
     
}

//MARK: - account managment

extension DatabaseManager {
//
//    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
//
//        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
//        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
//
//        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
//            guard snapshot.value as? String != nil else {
//                completion(false)
//                return
//            }
//            completion(true)
//        }
//    }
    
    public func userExists(with email: String,
                               completion: @escaping ((Bool) -> Void)) {

            let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
            database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
                guard snapshot.value as? [String: Any] != nil else {
                    completion(false)
                    return
                }

                completion(true)
            })

        }
    
    ///inserts a new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name" : user.firstName,
            "second_name" : user.secondName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let secondName: String
    let emailAddress: String
    var safeEmail:  String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
//    let profilePicture: URL
}
