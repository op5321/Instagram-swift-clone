//
//  AuthManager.swift
//  Instagram
//
//  Created by 박요셉 on 2021/02/06.
//

import FirebaseAuth
    
public class AuthManager{
    
    static let shared = AuthManager()
    
    //MARK: - PUBLIC
    
    public func registerNewUser(username : String, email : String, password : String, completion: @escaping (Bool)->Void) {
        /*
         - check if username is available
         - check if email is available
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate{
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard  error == nil, result != nil else {
                        //Firebase auth could not create account
                        completion(false)
                      return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username){ inserted in
                        if inserted {
                            completion(true)
                            return
                        } else{
                            // Failed to insert into database
                            completion(false)
                            return
                        }
                        
                        
                    }
                }
            }
            else {
                //either username or email does not exist
                completion(false)
            }
            
        }
    }
    
    public func loginUser(username : String?, email : String?, password : String, completion  : @escaping ((Bool) -> Void)) {
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                guard authResult != nil, error == nil else {
                    completion (false)
                    return
                }
                
                completion(true)
            }
            
        } else if let username = username {
            // username login
            print(username)
        }
    }
    
}
