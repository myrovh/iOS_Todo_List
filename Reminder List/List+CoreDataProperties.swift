import Foundation
import CoreData

extension List {

    @NSManaged var members: NSSet?

    func addReminder(value: ReminderData) {
        let reminder = self.mutableSetValueForKey("members")
        reminder.addObject(value)
    }
}
