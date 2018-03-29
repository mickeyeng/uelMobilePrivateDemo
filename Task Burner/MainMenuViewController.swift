//
//  ViewController.swift
//  myMovie2
//
//  Created by Mickey English on 26/03/2018.
//  Copyright © 2018 Mickey English. All rights reserved.
//
import UIKit
import Firebase

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutButton(_ sender: UIButton) {
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
    @IBAction func segueMainMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToMovies", sender: self)
    }
}
