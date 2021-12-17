//
//  HomeController.swift
//  NIBM Parking
//

import Foundation
import FirebaseDatabase


class HomeController{
    var db: DatabaseReference!
    func getAll(completionBlock: @escaping (_ success: [DataSnapshot]) -> Void) {
         var all: [DataSnapshot] = [];
        db = Database.database().reference()
        var dataset = db.child("normal")
        
        dataset.observe(.value, with:{ (snapshot) in
            all.append(contentsOf: snapshot.children.allObjects as! [DataSnapshot])
        })
        
        dataset = db.child("vip")
        dataset.observe(.value, with:{ (snapshot) in
            all.append(contentsOf: snapshot.children.allObjects as! [DataSnapshot])
            completionBlock(all);
        })
    }
}
