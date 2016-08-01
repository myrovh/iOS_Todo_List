import Foundation
import UIKit

class Reminder:NSObject{
    var title:String?
    var reminderDescription:String?
    var dueDate:NSDate?
    var isComplete:Bool?


override init() {
    self.title = "Unknown"
    self.reminderDescription = "Unknown"
    self.dueDate = NSDate()
    self.isComplete = false
}

init(title:String, description:String, dueDate:NSDate, isComplete:Bool) {
    self.title = title
    self.reminderDescription = description
    self.dueDate = dueDate
    self.isComplete = isComplete
}
}