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
    
    var reminder = Reminder?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.delegate = self
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

}
