//
//  ReminderListController.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 1/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit
import CoreData

class ReminderListController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext
    var databaseReminderList: NSMutableArray
    var currentList: List?
    
    let dateFormatter = NSDateFormatter()
    var reminder:Reminder?
    var reminders = [Reminder]()
    
    required init?(coder aDecoder: NSCoder) {
        self.databaseReminderList = NSMutableArray()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        super.init(coder: aDecoder)
    }
    
    func loadSampleData() {
        let reminder1 = Reminder(title: "Test", description: "Test Input Data", dueDate: NSDate(), isComplete: false)
        reminders += [reminder1]
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let reminderDetailViewController = segue.destinationViewController as! AddReminderController
            if let selectedReminderCell = sender as? ReminderCell {
                let indexPath = tableView.indexPathForCell(selectedReminderCell)!
                let selectedReminder = self.databaseReminderList[indexPath.row] as! ReminderData
                let convertedReminder: Reminder = Reminder(title: selectedReminder.dTitle!, description: selectedReminder.dDescription!, dueDate: selectedReminder.dDate!, isComplete: selectedReminder.dComplete as! Bool)
                reminderDetailViewController.reminder = convertedReminder
            }
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
}
