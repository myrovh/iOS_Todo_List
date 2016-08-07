import UIKit
import MapKit
import CoreData
import Foundation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var allReminders: NSArray?
    //var delegate: MapViewDelegate?
    var managedObjectContext: NSManagedObjectContext
    
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("ReminderData", inManagedObjectContext: self.managedObjectContext)
        
        fetchRequest.entity = entityDescription
        do {
            self.allReminders = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            if self.allReminders!.count > 0 {
                for val in allReminders! {
                    let reminder = val as! ReminderData
                    if reminder.latitude != 0 && reminder.longitude != 0 {
                        let loc: LocationAnnotation = LocationAnnotation(inputTitle: reminder.dTitle!, inputSubtitle: reminder.dDescription!, inputLat: reminder.latitude as! Double, inputLon: reminder.longitude as! Double)
                        addAnnotation(loc)
                    }
                }
            }
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addAnnotation(annotation: LocationAnnotation) {
        self.mapView.addAnnotation(annotation)
    }
    
    func focusOn(annotation: LocationAnnotation) {
        self.mapView.centerCoordinate = annotation.coordinate
        self.mapView.selectAnnotation(annotation, animated: true)
    }
}
