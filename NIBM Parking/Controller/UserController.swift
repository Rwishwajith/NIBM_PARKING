//
//  UserController.swift
//  NIBM Parking
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserController{
    var db: DatabaseReference!
    
    func signUp(email: String, password: String,name:String,mobile:String,vehicalid:String,nic:String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(res, error) in
            if let user = res?.user {
                let id=Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
                let data    =  ["registerid":id,
                                "name":name,
                                "mobile":mobile,
                                "vehicle_no":vehicalid,
                                "nic":nic] as [String : Any]
                self.db = Database.database().reference()
                self.db.child("users").child(user.uid).setValue(data)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func login(mail: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: mail, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func resetPassword(email: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func logOut(){
        try! Auth.auth().signOut();
    }
    
    func getUserData(completionBlock: @escaping (_ success: [String: Any]) -> Void) {
        
        db = Database.database().reference()
        guard let id = Auth.auth().currentUser?.uid else {
            return
        }
        db.child("users").child(id).observeSingleEvent(of: .value, with: { (data) in
            let user = data.value as! [String: Any]
            completionBlock(user);
        })
    }
    
    func loginCheck(completionBlock: @escaping (_ success: Bool) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completionBlock(false);
            return
        }
        db = Database.database().reference()
        db.child("users").child(id).observeSingleEvent(of: .value, with: { (data) in
            completionBlock(true);
        })
    }
}
