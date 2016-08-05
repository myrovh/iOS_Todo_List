//
//  ReminderListController.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 1/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit

class ReminderListController: UITableViewController {
    
    var reminder:Reminder?
    var reminders = [Reminder]()
    
    func loadSampleData() {
        let reminder1 = Reminder(title: "Test", description: "Test Input Data", dueDate: NSDate(), isComplete: false)
        reminders += [reminder1]
    }
    
    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as?
            AddReminderController, reminder = sourceViewController.reminder {
                reminders += [reminder]
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
        cell.dateLabel.text = "date"
        
        return cell
    }
}
