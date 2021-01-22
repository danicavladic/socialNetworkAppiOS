//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Danica Vladić on 17/09/2020.
//  Copyright © 2020 Danica Vladić. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    private let database = Database.database().reference()
    
    static let shared = DatabaseManager()
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func createNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username" : username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
        
    }
    
  
}
