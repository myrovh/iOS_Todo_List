import Foundation
import CoreData

extension ReminderData {

    @NSManaged var dComplete: NSNumber?
    @NSManaged var dDate: NSDate?
    @NSManaged var dDescription: String?
    @NSManaged var dTitle: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var owner: List?

}
