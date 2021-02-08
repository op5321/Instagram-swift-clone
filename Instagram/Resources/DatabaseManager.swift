//
//  DatabaseManager.swift
//  Instagram
//
//  Created by 박요셉 on 2021/02/05.
//

import FirebaseDatabase

public class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //MARK: - PUBLIC
    
    //check if username and email is available
    //   - parameters
    //      - email : String representing email
    //      - username : String representing username

    public func canCreateNewUser(with email:String, username:String, completion: (Bool) -> Void){
        completion(true)
        
    }
    
    
    //Insert new uswer data to database
    //   - parameters
    //      - email : String representing email
    //      - username : String representing username
    //      - completion : Async callback for result if database entry succeeded

    public func insertNewUser (with email:String, username:String, completion: @escaping (Bool)->Void){
        let key = email.safeDatabaseKey()
        print(key)
        
        database.child(email.safeDatabaseKey()).setValue(["username":username]) { error, _ in
            if error == nil {
                // succeeded
                completion(true)
                return
            } else{
                // failed
                completion(false)
                return
            }
        }
    }

    
}
