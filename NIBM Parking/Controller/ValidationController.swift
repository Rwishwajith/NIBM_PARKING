//
//  ValidationController.swift
//  NIBM Parking
//

import Foundation

class ValidationController{
    func checkValidEmail(_ email: String) -> Bool {
        let mail = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return mail.evaluate(with: email)
    }
    
    
    func checkValidPassword(_ password: String) -> Bool {
        if 8 > password.count {
            return false
        } else {
            return true;
        }
    }
}
