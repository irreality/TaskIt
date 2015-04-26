//
//  ViewController.swift
//  TaskIt
//
//  Created by Sami Paju on 16/12/14.
//  Copyright (c) 2014 Sami Paju. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
// As it is, the UITableViewDataSource and UITableViewDelegate protocols have no idea that ViewController exists, so those need to be linked in Storyboard. Vastaava juttu jos tänne kirjoittaisi viewDidLoadin sisälle jotta self.tableView.dataSource = self ja self.tableView.delegate = self.
    
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    // Same thing that was done in AddTaskViewController using two constants: First to get AppDelegate and the second to get managedObjectContext. Here the same thing is done using only one constant.
    
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    // "To populate our table we are going to use NSFetchedResultsViewController. NSFetchedResultsControllers are super optimized for synchronizing views with CoreData."
    
    
    // OLD: var taskArray:[Dictionary<String,String>] = []
    // Refactored from using Dictionaries into using structs, as below:
    
    // Multi-dimensional Array. There will be one for completed tasks and one for not completed tasks.
    // var baseArray:[[TaskModel]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        
        
        // EVERYTHING UNDERNEATH COMMENTED BECAUSE OF SWITCH TO CORE DATA
        
        
//        var date1 = Date.from(year: 2014, month: 05, day: 20)
//        var date2 = Date.from(year: 2014, month: 03, day: 3)
//        var date3 = Date.from(year: 2014, month: 12, day: 13)
//        
//        
//        
//        // OLD CODE, REFACTORED! *START*
//        
////        let task1:Dictionary<String, String> = ["task": "Study French", "subtask": "Verbs", "date": "01/14/2015"]
////        
////        // Dictionary looks like an array, but it's different, as we're _SETTING KEY VALUE PAIRS_. So we have always have two pairs of type String here. : is used to separate _KEY_ (e.g. "task") from _VALUE_ (e.g. "Study French").
////        // Above there are 3 Key Value Pairs specified.
////        
////        println(task1["task"])
////        println(task1["date"])
////        // This way we can retrieve a value stored in a corresponding key inside the Dictionary.
////        
////        let task2:Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01/14/2015"]
////        let task3:Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01/14/2015"]
////        
////        // So, here we have created 3 different Dictionaries, and as our taskArray variable is specified to hold String, String type dictionaries, we can add the ones created above to the array.
////        taskArray = [task1, task2, task3]
//        
//        // OLD CODE, REFACTORED! *END*
//        
//        
//        let task1 = TaskModel(task: "Study French", subtask: "Verbs", date: date1, completed: false)
//        let task2 = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: date2, completed: false)
//        
//        let taskArray = [task1, task2, TaskModel(task: "Gym", subtask: "Leg Day", date: date3, completed: false)]
//        // Note that stuff can also be created directly inside the array, as above.
//        
//        var completedArray = [TaskModel(task: "Code", subtask: "Task Project", date: date2, completed: true)]
//        
//        // taskArray for incomplete tasks, completedArray for completed tasks.
//        
//        baseArray = [taskArray, completedArray]
//        
//        
//        self.tableView.reloadData()
//        // Strictly speaking this is not needed here, but it's a cool little function that makes sure that all the stuff stays updated where it needs to be.
        
    }

    
    override func viewDidAppear(animated: Bool) {
        
        // "We are overriding the viewDidAppear function, which will be called each time the view is presented on the screen. This is different then viewDidLoad which is only called the first time a given ViewController (in this case, the main ViewController) is created."
        
        super.viewDidAppear(animated)
        
        // "Next, we call the viewDidAppear function on the keyword super, which implements the viewDidAppear functionality from the main ViewController's super classes implementation of viewDidAppear. In effect, we get access to the default functionality of viewDidAppear for free."
        
        
        // Sorting the tasks by date: METHOD 1
        
//        func sortByDate (taskOne: TaskModel, taskTwo: TaskModel) -> Bool {
//            
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//            // Is the time amount of TaskOne less than the time amount of TaskTwo" -> true or false
//        }
//        taskArray = taskArray.sorted(sortByDate)
        
                // "Closures allow us to refactor this code. Instead of having to write a function and then pass that function in as a parameter we can write the necessary code inside of the parameter."
        
        // Sorting the tasks by date: METHOD 2 - this is better because it does not require an embedded function to work
        
        // ALLA OLEVA ENNEN CORE DATAA
        
//        baseArray[0] = baseArray[0].sorted{
//            (taskOne: TaskModel, taskTwo: TaskModel) -> Bool in
//            // 'in' keyword allows to add the comparison logic here:
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        
//        self.tableView.reloadData()
        
        // "Finally, we call the function reloadData on the the tableView. This function causes the tableView to recall it's dataSource functions and repopulate the tableView with the updated array."
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // The whole thing here is about gaining access to the destination ViewController before it loads, and to do stuff with it. More specifically, we are sending information that can then be used inside the viewDidLoad() function in the destination ViewController.
        
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            // 'as' keyword is used to specify that segue.destinationViewController is a TaskDetailViewController instance.
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            // Specifies that indexPath corresponds to the row currently selected in the TableView.
            
            // let thisTask = baseArray[indexPath!.section] [indexPath!.row]
            
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as! TaskModel
            
            
            detailVC.detailTaskModel = thisTask
//            detailVC.mainVC = self
            // Tässä kohtaa määritetään, että ViewController johon ollaan siirtymässä tajuaa, että thisTask on se detailTaskModel mitä siellä halutaan näyttää.
            // Eli detailVC on TaskDetailViewController instanssi, jossa on määritetty detailTaskModel variable, joka on luokkaa TaskModel, kuten myös tässä VC:ssä oleva taskArray.
            // Ja taas siirretään self eteenpäin seuraavalla viewcontrollerille.
            
        }
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            
            // addTaskVC.mainVC = self (((Core Data, no longer needed)))
            // We are confirming going from main ViewController to AddTaskViewController. 'let addTaskVC' gives access to the specified viewcontroller.
            // 'self' presents the current ViewController instance we are in.
            // Eli tällä sanotaan, että addTaskVC:ssä oleva mainVC -variable viittaa tähän kyseiseen viewcontrolleriin.
            // "Remember, classes represent objects, they are not referencing specific objects unless you make them. So, we need to pass our ViewController instance to the AddTaskVC in our segue."
            
        }
        
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        // Helppoa kuin heinänteko. Määritetään, että tätä nappulaa kun painaa niin tämän niminen segue käynnistyy. Oooh. Aaaah.
        // Tätä metodia käytetään koska addTask on "Presented Modally" eli se ei ole osa Navigation Controller stackia.
    }
    
    
    // UITableViewDataSource:
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // This is a built-in function that divides tableview into different sections.
        
        return fetchedResultsController.sections!.count
        // returns the number of sections from fetchedResultsController
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return baseArray[section].count
        // Specifies the number of rows to be equal to the number of entries of a specific section of baseArray.
        
        return fetchedResultsController.sections![section].numberOfObjects
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // OLD CODE, REFACTORED! *START*
        
// let taskDict:Dictionary = taskArray[indexPath.row]
        // With this each line of the to-do list updates with a corresponding index path, i.e. with the one that matches the row in question, so that the same task does not repeat itself in all the rows.

// cell.taskLabel.text = taskDict["task"]
// cell.descriptionLabel.text = taskDict["subtask"]
// cell.dateLabel.text = taskDict["date"]
        // Toimii näin koska cell variaabeli on luokkaa TaskCell, ja nämä UI variaabelit on laitettu osaksi TaskCell custom classia.
        
        // OLD CODE, REFACTORED! *END*
        
        // let thisTask = baseArray[indexPath.section] [indexPath.row]
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        // "as TaskModel" specifies we are using TaskModel type instance
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        // "We know that the class of cell we are going to get back from Storyboard is TaskCell, so we need to specify here that tableView.dequeueBlaBlaBla is TaskCell.
        // TaskCell -filussa on määritetty, että TaskCell class on tyyppiä UITableViewCell. Tai oikeammin sen subclass. Anyway.
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    // "IndexPath is a way to encapsulate both a row and a cell."
    
    
    
    // UITableViewDelegate:
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        // Does transition between ViewController and TaskDetailViewController. The name of the segue is spefied as showTaskDetail in Storyboard.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // Aika magiaa, että tämä headerInSection juttu on ilmeisesti osa TableView:tä vakiona. Ei tartte tehdä storyboardiin mitään säätöjä.
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        } else {
            return "Completed"
        }
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // "...with the commitEditingStyle we're getting the swipe left functionality for free. If we want to add more buttons or swipe right, etc we have to do that ourselves."
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        // "We use the indexPath parameter to determine which cell was selected. Then, we use an if statement to determine which section is being selected. If it is the first section, we'll add the taskModel to the second array in the baseArray. If it is is the secondArray, we'll add a new TaskModel instance to the first section. Finally, we'll remove the selected TaskModel from the baseArray. We reload the information in the tableView to reflect the changes made to the baseArray."
        
        
        // ALLA ENNEN KUIN OTETTIIN CORE DATA KÄYTTÖÖN
        
//        if indexPath.section == 0 {
//            
//            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: true)
//            
//            baseArray[1].append(newTask)
//            
//        } else {
//            
//            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: false)
//            
//            baseArray[0].append(newTask)
//        }
//        
//        baseArray[indexPath.section].removeAtIndex(indexPath.row)
//        tableView.reloadData()
        
        if indexPath.section == 0 {
            thisTask.completed = true
        } else {
            thisTask.completed = false
        }
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()

        // "Once again we'll use the FetchedResultsController to access the TaskModel instance. We can then, make updates to this instance. Finally, we must call the function saveContext() to save our changes."
    }
    
    
    // From the above function, Apple adds 'Delete' text automatically to the swipe left function. Here's how to change it:
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        if indexPath.section == 0 {
            return "Complete"
        } else {
            return "Uncomplete"
        }
    }
    
    
    // NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    //HELPER
    
    func taskFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        // key is what will be used to sort the thing. Date is used here, as it is in TaskModel.
        
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        // Array is used here, because there can by default be multiple sortDescriptors.
        // This sorts the items first by "completed" true/false, and then by date, as specified in the two descriptors.
        
        return fetchRequest
    }
    
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController (fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        // What we're doing here is passing a fetch request, which will return us all TaskModel instances, sorted by date, as specified in the above taskFetchRequest helper function.
        // SectionNameKeyPath lets us specify based on which thing how many sections will there be
        
        return fetchedResultsController
    }
    
    

}

