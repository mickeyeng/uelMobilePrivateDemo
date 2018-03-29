//
//  Task.swift
//  Task Burner
//
//  Created by Andrei Nagy on 10/18/16.
//  Copyright © 2016 weheartswift.com. All rights reserved.
//

import Foundation
import Firebase

/* Have keys as constants to prevent spelling errors
 * and avoid confusion. eg. "title" can be found in
 * ViewControllers too, so places can exist where the
 * particular string is used for something else.
 */
let kTaskTitleKey = "title"
let kTaskCompletedKey = "completed"
let kTaskUserKey = "user"

struct Task {
    let title: String
    let user: String
    let firebaseReference: FIRDatabaseReference?
    var completed: Bool
    
    /* Constructor for instantiating a new object in code.
    */
    init(title: String, user: String, completed: Bool, id: String = "") {
        self.title = title
        self.user = user
        self.completed = completed
        self.firebaseReference = nil
    }
    
    /* Constructor for instantiating an object received from Firebase.
    */
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.title = snapshotValue[kTaskTitleKey] as! String
        self.user = snapshotValue[kTaskUserKey] as! String
        self.completed = snapshotValue[kTaskCompletedKey] as! Bool
        self.firebaseReference = snapshot.ref
    }
    
    /* Member to help updating values of an existing object.
    */
    func toDictionary() -> Any {
        return [
            kTaskTitleKey: self.title,
            kTaskUserKey: self.user,
            kTaskCompletedKey: self.completed
        ]
    }
}
