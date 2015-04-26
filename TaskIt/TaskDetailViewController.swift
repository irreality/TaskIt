//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Sami on 30/01/15.
//  Copyright (c) 2015 Sami Paju. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    
//    var mainVC: ViewController!
    

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
        // This tells the navigation controller to exit the current viewcontroller with animation.
        // Tätä metodia käytetään, koska TaskDetail on osa samaa navigation stackia Main ViewControllerin kanssa.
        
    }
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subtaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        appDelegate.saveContext()
        
        // ALLA OLEVA ENNEN CORE DATAA
        
//        var task = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
//        
//        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task
        // Tämä hakee mainVC ViewControllerista taskArrayn ja siihen kuuluvan oikean indexpathin, ja päivittää sen uusilla TaskModel arvoilla Done-nappia painettaessa.
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    
}
