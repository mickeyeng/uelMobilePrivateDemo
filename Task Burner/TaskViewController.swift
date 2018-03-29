//
//  CreateTaskViewController.swift
//  Task Burner
//
//  Created by Andrei Nagy on 10/18/16.
//  Copyright © 2016 weheartswift.com. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    var taskTitle: String?
    var taskCompleted: Bool?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var completedSwitch: UISwitch!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.titleField.text = self.taskTitle ?? ""
        self.completedSwitch.setOn(taskCompleted ?? false, animated:false)
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
    
    func updateValues() {
        self.taskTitle = self.titleField.text
        self.taskCompleted = self.completedSwitch.isOn
    }
    
    
    @IBAction func backToMovieListButton(_ sender: UIButton) {
        performSegue(withIdentifier:  "backToMovieList", sender: self)
    }
    
}
