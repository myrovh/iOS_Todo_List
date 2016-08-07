import Foundation
import UIKit

class Reminder:NSObject{
    var title:String?
    var reminderDescription:String?
    var dueDate:NSDate?
    var isComplete:Bool?
    var latitude:Double?
    var longitude:Double?


override init() {
    self.title = "Unknown"
    self.reminderDescription = "Unknown"
    self.dueDate = NSDate()
    self.isComplete = false
    self.latitude = 0
    self.longitude = 0
}

    init(title:String, description:String, dueDate:NSDate, isComplete:Bool, latitude:Double, longitude:Double) {
    self.title = title
    self.reminderDescription = description
    self.dueDate = dueDate
    self.isComplete = isComplete
    self.latitude = latitude
    self.longitude = longitude
}
}