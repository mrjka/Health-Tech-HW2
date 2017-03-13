//
//  StepCount.swift
//  ADHD
//
//  Created by Jaldeep Acharya on 2017-03-12.
//  Copyright © 2017 Jaldeep Acharya. All rights reserved.
//

import UIKit
import CoreMotion
import CoreData

class StepCountViewController: UIViewController {
    
    
    @IBOutlet weak var steps: UILabel!
   
    
    var days:[String] = []
    var stepsTaken:[Int] = []
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    
    
    override func viewDidLoad() {
        
        var cal = Calendar.current
        var comps = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = TimeZone.current
        cal.timeZone = timeZone
        
        let midnightOfToday = cal.date(from: comps)!
        
        
        // Run only in Physical Device, iOS
        
        if(CMPedometer.isStepCountingAvailable()){
            print("Step Result 1")
            self.pedoMeter.startUpdates(from: midnightOfToday) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        print("Step Result")
                        print("\(data!.numberOfSteps)")
                        self.steps.text = "\(data!.numberOfSteps)"
                        self.save(steps: "\(data!.numberOfSteps)",date: midnightOfToday)
                    }
                })
            }
        }
        
        
    }
    func save(steps:String, date:Date){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
        let entity =
            NSEntityDescription.entity(forEntityName: "StepCount",
                                       in: managedContext)!
        
        let data_values = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        
        
        
        data_values.setValue(String(describing: steps), forKeyPath: "steps")
        data_values.setValue(String(describing: date), forKeyPath: "date")
        
        do {
            try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
