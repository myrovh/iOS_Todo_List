//
//  DateViewController.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 6/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var datePicker: UIDatePicker!
    var dateStore:NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dateStore = dateStore {
            datePicker.date = dateStore
            print("date set from segue")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let reminderDetailViewController = segue.destinationViewController as! AddReminderController
        reminderDetailViewController.reminder?.dueDate = datePicker.date
    }
}
