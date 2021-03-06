//
//  AppDelegate.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/19/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func alarmGoOff( iAlarm:Int?){
        var date = Date()
        var calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        
        var AMPMCheck = ""
        if hour > 12 {
            AMPMCheck = "PM"
            hour = hour - 12
            //      print(hour)
        } else {
            AMPMCheck = "AM"
        }
        var minuteString = String(minutes)
        if (minutes < 10)
        {
            minuteString = "0" + String(minutes)
        }
        let alert = UIAlertController(title: String(hour)+":"+minuteString+":"+AMPMCheck, message:"Alarm", preferredStyle: UIAlertControllerStyle.alert)
        

        // add an action (button)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: nil))
        
        alarmONOFF![iAlarm!] = false
        
        // show the alert
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // on launch access nsuserdefaults to populate arrays

        if let todoTimerLabelArray  = fetchDataTimerLabelArray() {
            
            timerLabelArray = todoTimerLabelArray
            
        } else {
            
            timerLabelArray = [String]()
            
        }
        
        if let todoSelectedMinuteArray  = fetchDataSelectedMinuteArray() {
            
           selectedMinuteArray = todoSelectedMinuteArray
            
        } else {
            
            
           selectedMinuteArray = [Int]()
            
        }
        
      
        if let todoSelectedHourArray  = fetchDataSelectedHourArray() {
            
            selectedHourArray = todoSelectedHourArray
            
        } else {
            
            
            selectedHourArray = [Int]()
            
        }
        
        if let todoSelectedAMPMArray  = fetchDataSelectedAMPMArray() {
            
            selectedAMPMArray = todoSelectedAMPMArray
            
        } else {
            
            
            selectedAMPMArray = [String]()
            
        }
        
        if let todoAddAlarmTextFieldArray  = fetchDataAddAlarmTextFieldArray() {
            
            addAlarmTextFieldArray = todoAddAlarmTextFieldArray
            
        } else {
            
            
            addAlarmTextFieldArray = [String]()
            
        }
        
        if let todoAlarmONOFF  = fetchDataAlarmONOFF() {
            
            alarmONOFF = todoAlarmONOFF
            
        } else {
            
            
            alarmONOFF = [Bool]()
            
        }
        
        if let todoAudioNameArray  = fetchDataAudioNameArray() {
            
            audioNameArray = todoAudioNameArray
            
        } else {
            
            
            audioNameArray = [String]()
            
        }
        

        if let todoAudioStringArray  = fetchAudioStringArray() {
         
            audioStringArray = todoAudioStringArray
            
        } else {
            
            
            audioStringArray = [String]()
            
        }
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // if application enters background save arrays
        
        saveDataTimerLabelArray(timerLabelArray: timerLabelArray!)
        
        saveDataSelectedMinuteArray(selectedMinuteArray: selectedMinuteArray!)
        
        saveDataSelectedHourArray(selectedHourArray: selectedHourArray!)
        
        saveDataSelectedAMPMArray(selectedAMPMArray: selectedAMPMArray!)
        
        saveDataAddAlarmTextFieldArray(addAlarmTextFieldArray: addAlarmTextFieldArray!)
        
        saveDataAlarmONOFF(alarmONOFF: alarmONOFF!)
        
        saveDataAudioNameArray(audioNameArray: audioNameArray!)
    
        
        
        
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        // if application terminates save arrays
        
        saveDataTimerLabelArray(timerLabelArray: timerLabelArray!)
        
        saveDataSelectedMinuteArray(selectedMinuteArray: selectedMinuteArray!)
        
        saveDataSelectedHourArray(selectedHourArray: selectedHourArray!)
        
        saveDataSelectedAMPMArray(selectedAMPMArray: selectedAMPMArray!)
        
        saveDataAddAlarmTextFieldArray(addAlarmTextFieldArray: addAlarmTextFieldArray!)
        
        saveDataAlarmONOFF(alarmONOFF: alarmONOFF!)
        
        saveDataAudioNameArray(audioNameArray: audioNameArray!)
        
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SleepTalk")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

