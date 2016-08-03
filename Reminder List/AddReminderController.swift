//
//  AddReminderController.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 1/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit

class AddReminderController: UIViewController {
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var rTitle: String?
    var rDescription: String?
    var reminder: Reminder?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            rTitle = titleText.text
            rDescription = titleText.text ?? ""
            reminder = Reminder(title: rTitle!, description: rDescription!, dueDate: NSDate(), isComplete: false)
        }
    }

}
