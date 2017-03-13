//
//  ViewController.swift
//  ADHD
//
//  Created by Jaldeep Acharya on 2017-03-12.
//  Copyright © 2017 Jaldeep Acharya. All rights reserved.
//

import UIKit
import CoreData
import ResearchKit

class ViewController: UIViewController {

    let people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func SpatialMemory(_ sender: Any) {
        let taskViewController = ORKTaskViewController(task: SpatialMemoryTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String, isDirectory: true) as URL
        present(taskViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func consentTapped(_ sender: AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    

}

func save(name: String) {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    // 1
    let managedContext = appDelegate.persistentContainer.viewContext
    
    // 2
    let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
    
    let person = NSManagedObject(entity: entity, insertInto: managedContext)
    
    // 3
    person.setValue(name, forKeyPath: "name")
    
    // 4
    do {
        try managedContext.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

extension ViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
}

