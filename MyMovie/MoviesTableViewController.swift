//
//  ViewController.swift
//  myMovie2
//
//  Created by Mickey English on 26/03/2018.
//  Copyright © 2018 Mickey English. All rights reserved.
//
import UIKit
import Firebase

let moviesListPath = "movies-list"
let MovieViewControllerSegueIdentifier = "MovieViewController"

class TasksTableViewController: UITableViewController {
    
    let movieReference = FIRDatabase.database().reference(withPath: moviesListPath)
    var movies = [Movie]()
    var selectedTask: Movie? = nil
    weak var currentUser = FIRAuth.auth()?.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Query tasks from firebase when this view controller is instantiated
        */
        self.movieReference.queryOrdered(byChild: movieWatched).observe(.value, with: { snapshot in
            
            /* The callback block will be executed each and every time the value changes.
            */
            var items: [Movie] = []
            
            for item in snapshot.children {
                let movie = Movie(snapshot: item as! FIRDataSnapshot)
                items.append(movie)
            }
            
            self.movies = items
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MovieViewControllerSegueIdentifier {
            /* Pass along the selected task to the particular task view controller.
            */
            if let taskViewController = segue.destination as? TaskViewController {
                taskViewController.taskTitle = self.selectedTask?.title
                taskViewController.taskCompleted = self.selectedTask?.completed
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        if let taskViewController = segue.source as? TaskViewController {
            taskViewController.updateValues()
            
            if let task = self.selectedTask {
                /* This particular task was an existing one
                    it should be updated in Firebase.
                */
                if let title = taskViewController.taskTitle,
                    let completed = taskViewController.taskCompleted,
                    let email = self.currentUser?.email {
                    
                    let taskFirebasePath = task.firebaseReference
                    taskFirebasePath?.updateChildValues([
                        movieTitle: title,
                        movieUser: email,
                        movieWatched: completed
                        ])
                }
            } else {
                /* This task is new,
                 it should be created in Firebase
                */
                if let title = taskViewController.taskTitle,
                    let completed = taskViewController.taskCompleted,
                    let email = self.currentUser?.email {
                    
                    let task = Movie(title: title, user: email, completed: completed)
                    let taskFirebasePath = self.movieReference.ref.child(title.lowercased())
                    taskFirebasePath.setValue(task.toDictionary())
                }
            }
        }
        self.selectedTask = nil
    }
    
    @IBAction func backToMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "backToMenu", sender: self)
    }
    
    @IBAction func addTask() {
        self.performSegue(withIdentifier: MovieViewControllerSegueIdentifier, sender: self)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath)
        
        if let c = cell as? TasksTableViewCell {
            let movie = self.movies[indexPath.row]
            c.titleLabel.text = movie.title
            c.completedSwitch.setOn(movie.completed, animated: true)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.movies[indexPath.row]
        
        /* Keep a reference to the task that is currently edited.
        */
        self.selectedTask = task
        self.performSegue(withIdentifier: MovieViewControllerSegueIdentifier, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = self.movies[indexPath.row]
            /* Delete this task.
             No tableview updates should be done here because a callback notification
             will be provided.
            */
            task.firebaseReference?.removeValue()
        }
    }
}
