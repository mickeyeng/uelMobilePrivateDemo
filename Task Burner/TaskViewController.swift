//
//  ViewController.swift
//  myMovie2
//
//  Created by Mickey English on 26/03/2018.
//  Copyright © 2018 Mickey English. All rights reserved.
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
    
    
    func updateValues() {
        self.taskTitle = self.titleField.text
        self.taskCompleted = self.completedSwitch.isOn
    }
    
    
    @IBAction func backToMovieListButton(_ sender: UIButton) {
        performSegue(withIdentifier:  "backToMovieList", sender: self)
    }
    
}
