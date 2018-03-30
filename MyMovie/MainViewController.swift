//
//  MainViewController.swift
//  myMovie2
//
//  Created by Mickey English on 26/03/2018.
//  Copyright © 2018 Mickey English. All rights reserved.
//

import UIKit
import Firebase

let userLoggedIn = "userLoggedIn"

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var InputEmail: UITextField!
    @IBOutlet weak var InputPassword: UITextField!
    
    
    /* Have a reference to the last signed in user to compare
     changes
     */
    weak var currentUser: FIRUser?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let auth = FIRAuth.auth() {
        
        // tap screen to hide keyboard
        self.InputEmail.delegate = self
        self.InputPassword.delegate = self
            
            
            /* Add a state change listener to firebase
             to get a notification if the user signed in.
            */
            auth.addStateDidChangeListener({ (auth, user) in
                if user != nil && user != self.currentUser {
                    self.currentUser = user
                    self.performSegue(withIdentifier: userLoggedIn,
                                      sender: self)
                }
            })
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let auth = FIRAuth.auth() {
            
             //Stop listening to user state changes while not on screen.
          
            auth.removeStateDidChangeListener(self)
        }
    }
    
    // hide the keyboard when the user presses away from the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // hide the keyboard when the user presses return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
    // register function
    
    @IBAction func registerButton(_ sender: UIButton) {
        if let email = self.InputEmail.text,
            let password = self.InputPassword.text,
            let auth = FIRAuth.auth() {
            /* Note: creating a user automatically signs in.
             */
            auth.createUser(withEmail: email,
                            password: password) { user, error in
                                if error != nil {
                                    self.present(UIAlertController.withError(error: error as! NSError),
                                                 animated: true,
                                                 completion: nil)
                                }
            }
        }
    }

        // login function
    @IBAction func loginButton(_ sender: UIButton) {
        if let email = self.InputEmail.text,
            let password = self.InputPassword.text,
            let auth = FIRAuth.auth() {
            
            /* If both email and password fields are not empty,
             call firebase signin
             */
            auth.signIn(withEmail: email,
                        password: password)
        }
    }
    
    
    
    @IBAction func signOut(segue: UIStoryboardSegue) {
        /* When Sign out is pressed, and the task list controller closes,
         call Firebase sign out.
        */
        if let auth = FIRAuth.auth() {
            do {
                try auth.signOut()
            } catch {
                self.present(UIAlertController.withError(error: error as NSError),
                             animated: true,
                             completion: nil)
            }
        }
    }
}

