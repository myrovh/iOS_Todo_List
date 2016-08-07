import UIKit
import CoreData

class ReminderListController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext
    var databaseReminderList: NSMutableArray
    var currentList: List?
    
    let dateFormatter = NSDateFormatter()
    var reminder:Reminder?
    var reminders = [Reminder]()
    var sortMode: String?
    
    required init?(coder aDecoder: NSCoder) {
        self.databaseReminderList = NSMutableArray()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        super.init(coder: aDecoder)
    }
    
    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //let entity = NSEntityDescription.entityForName("ReminderData", inManagedObjectContext: managedContext)
        //let reminder = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        if let sourceViewController = sender.sourceViewController as? AddReminderController, reminder = sourceViewController.reminder {
            let convertedReminder: ReminderData = (NSEntityDescription.insertNewObjectForEntityForName("ReminderData", inManagedObjectContext: self.managedObjectContext) as? ReminderData)!
            convertedReminder.dTitle = reminder.title
            convertedReminder.dDescription = reminder.reminderDescription
            convertedReminder.dDate = reminder.dueDate
            convertedReminder.dComplete = reminder.isComplete
            convertedReminder.latitude = reminder.latitude
            convertedReminder.longitude = reminder.longitude
            //reminder.setValue(reminderInsert.title, forKey: "dTitle")
            //reminder.setValue(reminderInsert.reminderDescription, forKey: "dDescription")
            //reminder.setValue(reminderInsert.dueDate, forKey: "dDate")
            //reminder.setValue(reminderInsert.isComplete, forKey: "dComplete")
            currentList?.addReminder(convertedReminder)
            self.databaseReminderList = NSMutableArray(array: (currentList!.members?.allObjects as! [ReminderData]))
            self.tableView.reloadData()
            
            do{
                try managedContext.save()
                
            } catch let error as NSError {
                print("Error \(error)")
            }
        }
        /*
        if let sourceViewController = sender.sourceViewController as? AddReminderController, reminder = sourceViewController.reminder {
            let convertedReminder: ReminderData = (NSEntityDescription.insertNewObjectForEntityForName("ReminderData", inManagedObjectContext: self.managedObjectContext) as? ReminderData)!
            convertedReminder.dTitle = reminder.title
            convertedReminder.dDescription = reminder.reminderDescription
            convertedReminder.dDate = reminder.dueDate
            convertedReminder.dComplete = reminder.isComplete
            self.addReminder(convertedReminder)
            /*
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    reminders[selectedIndexPath.row] = reminder
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                }
                else {
                    let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
                    reminders.append(reminder)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                }
            */
        }
*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortMode = "Day"
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("List", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entityDescription
        
        var result = NSArray?()
        do {
            result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            if result!.count == 0 {
                self.currentList = List.init(entity: NSEntityDescription.entityForName("List", inManagedObjectContext: self.managedObjectContext)!, insertIntoManagedObjectContext: self.managedObjectContext)
            }
            else {
                self.currentList = result![0] as? List
                self.databaseReminderList = NSMutableArray(array: currentList!.members?.allObjects as! [ReminderData])
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //loadSampleData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.databaseReminderList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ReminderCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReminderCell
        
        let reminder = self.databaseReminderList[indexPath.row] as! ReminderData
        
        cell.titleLabel.text = reminder.dTitle
        cell.descriptionLabel.text = reminder.dDescription
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        cell.dateLabel.text = dateFormatter.stringFromDate(reminder.dDate!)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            managedObjectContext.deleteObject(databaseReminderList.objectAtIndex(indexPath.row) as! NSManagedObject)
            self.databaseReminderList.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            //self.tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Fade)
        }
        
        do {
            try self.managedObjectContext.save()
        }
        catch let error {
            print("Could not save deletion \(error)")
        }
    }
    
    @IBAction func switchSort(sender: UIBarButtonItem) {
        if sortMode == "Day" {
            sortMode = "Week"
        }
        else if sortMode == "Week" {
            sortMode = "Month"
        }
        else if sortMode == "Month" {
            sortMode = "Day"
        }
        print("Sort Mode switched to \(sortMode)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let reminderDetailViewController = segue.destinationViewController as! AddReminderController
            if let selectedReminderCell = sender as? ReminderCell {
                let indexPath = tableView.indexPathForCell(selectedReminderCell)!
                let selectedReminder = self.databaseReminderList[indexPath.row] as! ReminderData
                let convertedReminder: Reminder = Reminder(title: selectedReminder.dTitle!, description: selectedReminder.dDescription!, dueDate: selectedReminder.dDate!, isComplete: selectedReminder.dComplete as! Bool, latitude: selectedReminder.latitude as! Double, longitude: selectedReminder.longitude as! Double)
                reminderDetailViewController.reminder = convertedReminder
            }
        }
        else if segue.identifier == "ShowFullMap" {
            let controller: MapViewController = segue.destinationViewController as! MapViewController
            controller.managedObjectContext = self.managedObjectContext
            //controller.delegate = self
        }
        else if segue.identifier == "AddItem" {
            print("Adding a new Reminder")
        }
    }
    
    func addReminder(reminder: ReminderData) {
        self.currentList!.addReminder(reminder)
        self.databaseReminderList = NSMutableArray(array: (currentList!.members?.allObjects as! [ReminderData]))
        self.tableView.reloadData()
        do {
            try self.managedObjectContext.save()
        } catch let error {
            print("Could not save addition \(error)")
        }
    }
    
    /*
    func fetchReminder(titleString: String, descriptionString: String) -> ReminderData? {
        let fetchRequest = NSFetchRequest(entityName: "ReminderData")
        let predicate = NSPredicate(format: "(\(titleString) like dTitle) AND (\(descriptionString) like dDescription)", argumentArray: nil)
        var error = NSErrorPointer()
        
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchBatchSize = 1
        
        let fetchedResults = try managedObjectContext.executeFetchRequest(fetchRequest, error: error)

        
        if fetchedResults?.count != 0 {
            if let fetchedReminder: ReminderData = fetchedResults![0] as? ReminderData {
                return fetchedReminder
            }
        }
        return nil
    }
    */
}
