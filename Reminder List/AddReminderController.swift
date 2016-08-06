//
//  AddReminderController.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 1/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit

class AddReminderController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var completeSwitch: UISwitch!
    
    let dateFormatter = NSDateFormatter()
    var reminder = Reminder?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.delegate = self
        
        if let reminder = reminder {
            titleText.text = reminder.title
            descriptionText.text = reminder.reminderDescription
            completeSwitch.on = reminder.isComplete!
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dueDateLabel.text = dateFormatter.stringFromDate(reminder.dueDate!)
        }
        else {
            dueDateLabel.text = dateFormatter.stringFromDate(NSDate())
        }
        
        checkValidReminderTitle()
    }
    
    func textFieldDidBegininEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidReminderTitle() {
        let text = titleText.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidReminderTitle()
        navigationItem.title = textField.text
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if saveButton === sender {
            reminder = Reminder(title: titleText.text!, description: descriptionText.text ?? "", dueDate: NSDate(), isComplete: completeSwitch.on)
        }
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddReminderMode = presentingViewController is UINavigationController
        if isPresentingInAddReminderMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
}
