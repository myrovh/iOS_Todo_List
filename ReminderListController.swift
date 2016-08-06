//
//  ReminderListController.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 1/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit

class ReminderListController: UITableViewController {
    
    let dateFormatter = NSDateFormatter()
    var reminder:Reminder?
    var reminders = [Reminder]()
    
    func loadSampleData() {
        let reminder1 = Reminder(title: "Test", description: "Test Input Data", dueDate: NSDate(), isComplete: false)
        reminders += [reminder1]
    }
    
    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as?
            AddReminderController, reminder = sourceViewController.reminder {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    reminders[selectedIndexPath.row] = reminder
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                }
                else {
                    let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
                    reminders.append(reminder)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return reminders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ReminderCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReminderCell
        
        let reminder = reminders[indexPath.row]
        
        cell.titleLabel.text = reminder.title
        cell.descriptionLabel.text = reminder.reminderDescription
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        cell.dateLabel.text = dateFormatter.stringFromDate(reminder.dueDate!)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let reminderDetailViewController = segue.destinationViewController as! AddReminderController
            if let selectedReminderCell = sender as? ReminderCell {
                let indexPath = tableView.indexPathForCell(selectedReminderCell)!
                let selectedReminder = reminders[indexPath.row]
                reminderDetailViewController.reminder = selectedReminder
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding a new Reminder")
        }
    }
}
