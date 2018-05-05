//
//  DataHolder.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/26/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import Foundation


    var currentTime = ""
    // setting up arrays screen by screen
    // alarmTableView



    var timerLabelArray:[String]?

    // the reason why hours minutes ampm arrays exist is because its easier for the timer to work with values that aren't concatenated, while the label is displayed on the tableview is concatenated . Otherwise there would be constant parsing and adding of strings to int and vice versa

    var selectedHourArray:[Int]?

    var selectedMinuteArray:[Int]?

    var selectedAMPMArray: [String]?
    
    var addAlarmTextFieldArray:[String]?
    
    var audioNameArray:[String]?
    
    var audioAlarmNameDictionary:[String : String]? // each alarm is associated with a specific audio filename
    
    var alarmONOFF:[Bool]?
    
    // Add AlarmViewControllers - I realized some arrays repeat and are reused once saved in coredata.
    
    // Add recordingViewController
    
    var audioDurationArray:[String]?
    
    var audioNameDurationDictionary:[String : Int]?






    
func saveDataTimerLabelArray(timerLabelArray:[String]) {
    
    UserDefaults.standard.set(timerLabelArray, forKey: "timerLabelArray")
    
}

func saveDataSelectedMinuteArray(selectedMinuteArray:[Int]) {
    
    UserDefaults.standard.set(selectedMinuteArray, forKey: "selectedMinuteArray")
    
}


func saveDataSelectedHourArray(selectedHourArray:[Int]) {
    
    UserDefaults.standard.set(selectedHourArray, forKey: "selectedHourArray")
    
}

func saveDataSelectedAMPMArray(selectedAMPMArray:[String]) {
    
    UserDefaults.standard.set(selectedAMPMArray, forKey: "selectedAMPMArray")
    
}

func saveDataAddAlarmTextFieldArray(addAlarmTextFieldArray:[String]) {
    
    UserDefaults.standard.set(addAlarmTextFieldArray, forKey: "addAlarmTextFieldArray")
    
}

func saveDataAlarmONOFF(alarmONOFF:[Bool]) {
    
    UserDefaults.standard.set(alarmONOFF, forKey: "alarmONOFF")
    
}

func saveDataAudioNameArray(audioNameArray:[String]) {
    
    UserDefaults.standard.set(audioNameArray, forKey: "audioNameArray")
    
}






// fetch starts here


func fetchDataTimerLabelArray() -> [String]? {
    
    if let todoTimerLabelArray = UserDefaults.standard.array(forKey: "timerLabelArray") as?  [String]
    {
        
        return todoTimerLabelArray
    } else {
        
        return nil
        
    }
    
}

func fetchDataSelectedMinuteArray() -> [Int]? {
    
    if let todoSelectedMinuteArray = UserDefaults.standard.array(forKey: "selectedMinuteArray") as?  [Int]
    {
        
        return todoSelectedMinuteArray
    } else {
        
        return nil
        
    }
    
}

func fetchDataSelectedHourArray() -> [Int]? {
    
    if let todoSelectedHourArray = UserDefaults.standard.array(forKey: "selectedHourArray") as?  [Int]
    {
        
        return todoSelectedHourArray
    } else {
        
        return nil
        
    }
    
}

func fetchDataSelectedAMPMArray() -> [String]? {
    
    if let todoSelectedAMPMArray = UserDefaults.standard.array(forKey: "selectedAMPMArray") as?  [String]
    {
        
        return todoSelectedAMPMArray
    } else {
        
        return nil
        
    }
    
}

func fetchDataAddAlarmTextFieldArray() -> [String]? {
    
    if let todoAddAlarmTextFieldArray = UserDefaults.standard.array(forKey: "addAlarmTextFieldArray") as?  [String]
    {
        
        return todoAddAlarmTextFieldArray
    } else {
        
        return nil
        
    }
    
}

func fetchDataAlarmONOFF() -> [Bool]? {
    
    if let todoAlarmONOFF = UserDefaults.standard.array(forKey: "alarmONOFF") as?  [Bool]
    {
        
        return todoAlarmONOFF
    } else {
        
        return nil
        
    }
    
}

func fetchDataAudioNameArray() -> [String]? {
    
    if let todoAudioNameArray = UserDefaults.standard.array(forKey: "audioNameArray") as?  [String]
    {
        
        return todoAudioNameArray
    } else {
        
        return nil
        
    }
    
}





