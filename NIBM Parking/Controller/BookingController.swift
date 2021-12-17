//
//  BookingController.swift
//  NIBM Parking
//

import Foundation
import FirebaseDatabase

class BookingController{
    var db: DatabaseReference!
    
    func findAvailableSlots(completionBlock: @escaping (_ success: [String]) -> Void) {
        var slots :[String] = []
        db = Database.database().reference()
        
        var dataset = db.child("vip").queryOrdered(byChild: "status").queryEqual(toValue : "AVAILABLE")
        dataset.observe(.value, with:{ (snapshot) in
            for snap in snapshot.children {
                slots.append((snap as! DataSnapshot).key)
            }
        })
        
        dataset = db.child("normal").queryOrdered(byChild: "status").queryEqual(toValue : "AVAILABLE")
        dataset.observe(.value, with:{ (snapshot) in
            for snap in snapshot.children {
                slots.append((snap as! DataSnapshot).key)
                completionBlock(slots);
            }
        })
        
    }
    
    func reserveSlot(type: String,id: String,user: Any,time: String,timeid: Int, completionBlock: @escaping (_ success: Bool) -> Void) {
        db = Database.database().reference()
        db.child(type).child(id).child("date_time").setValue(time)
        db.child(type).child(id).child("timeid").setValue(timeid)
        db.child(type).child(id).child("user").setValue(user)
        let child = db.child(type).child(id)
        child.updateChildValues(["status":"RESERVED"])
        completionBlock(true)
        
    }
}
