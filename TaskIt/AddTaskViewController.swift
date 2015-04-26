//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Sami on 19/03/15.
//  Copyright (c) 2015 Sami Paju. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
//    var mainVC: ViewController!
    // "We want to actually add a task of our own instead of relying on our pre-filled tasks. The main issue you will face in accomplishing this, is figuring out how to add a task to your ViewController array from the AddTaskViewController. Our approach will be to add a reference to the ViewController object in the AddTaskViewController, so we have access to it."
    
    // Eli tämä pitää luoda, jotta ViewController.swift:ssä olevaan TaskArray propertyyn pääsee käsiksi.
    
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Alla vanha funktio ennen Core Datan lisäämistä:
//    
//    @IBAction func addTaskButtonTapped(sender: UIButton) {
//        
//        var task = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
//        // Täähän on makee, kun tällä tavalla saadaan kaapattua se tieto mikä UI kenttiin on syötetty. Ja nämä UI kentät on liitetty tähän viewcontrolleriin tuolla ylhäällä.
//        
//        mainVC.baseArray[0].append(task)
//        
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        // UIApplication presents the whole application. Here we are accessing the instance of our AppDelegate swift file. Now we can access the managedObjectContext in AppDelegate.swift.
        
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext:managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.completed = false
        
        appDelegate.saveContext()
        // this automatic function is to used to save our stuff to the entity.
        
        var request = NSFetchRequest(entityName: "TaskModel")
        // "I want to request all entities of TaskModel."
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        // &error means "write error to this memory address" and is an optimisation thing that prevents error from being recorded when there is no error.
        // ! in the end of the whole thing above is because it's optional. There may be nothing to fetch.
        
        for res in results {
            println(res)
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
}
