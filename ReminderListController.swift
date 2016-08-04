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
    
    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as?
            AddReminderController, _ = sourceViewController.reminder {
                
        }
    }
}
