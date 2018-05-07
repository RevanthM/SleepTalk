//
//  CoreDataHandler.swift
//  SleepTalk
//
//  Created by Albert Kornas on 5/6/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    class func saveObject(audioName:String) -> Bool
    {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Audio", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(audioName, forKey: "alarmaudio")
        
        do{
          try context.save()
            return true
        }catch
        {
            return false
        }
        
    }
    
    class func fetchObject() ->  [Audio]?
    {
        let context = getContext()
        var audio:[Audio]? = nil
        do
        {
            audio = try context.fetch(Audio.fetchRequest())
            return audio
        }catch{
            return audio
        }
    }
    
    class func deleteObject(audio: Audio) -> Bool
    {
        let context = getContext()
        context.delete(audio)
        do{
            try context.save()
            return true
        }catch{
            return false
        }
        
    }
    
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Audio.fetchRequest())
        do{
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    class func filterData() -> [Audio]?
    {
        let context = getContext()
        let fetchRequest:NSFetchRequest<Audio> = Audio.fetchRequest()
        var audio:[Audio]? = nil
        let predicate = NSPredicate(format: "audioname contains[c] %@", "myRecording.mp4a")
        fetchRequest.predicate = predicate
        do {
            audio = try context.fetch(fetchRequest)
            return audio
        } catch {
            return audio
        }
    }
}
