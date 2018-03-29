//
//  ViewController.swift
//  myMovie2
//
//  Created by Mickey English on 26/03/2018.
//  Copyright © 2018 Mickey English. All rights reserved.
//
import Foundation
import Firebase

/* Have keys as constants to prevent spelling errors
 * and avoid confusion. eg. "title" can be found in
 * ViewControllers too, so places can exist where the
 * particular string is used for something else.
 */
let movieTitle = "title"
let movieWatched = "completed"
let movieUser = "user"

struct Movie {
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
        self.title = snapshotValue[movieTitle] as! String
        self.user = snapshotValue[movieUser] as! String
        self.completed = snapshotValue[movieWatched] as! Bool
        self.firebaseReference = snapshot.ref
    }
    
    /* Member to help updating values of an existing object.
    */
    func toDictionary() -> Any {
        return [
            movieTitle: self.title,
            movieUser: self.user,
            movieWatched: self.completed
        ]
    }
}
