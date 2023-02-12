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
     
}

//MARK: - account managment

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
            
        }
    }
    
    ///inserts a new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name" : user.firstName,
            "second_name" : user.secondName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let secondName: String
    let emailAddress: String
//    let profilePicture: URL
}
