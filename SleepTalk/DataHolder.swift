//
//  DataHolder.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/26/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import Foundation


    
    // setting up arrays screen by screen
    // alarmTableView
    
    var timerLabelArray:[String]?

    // the reason why hours minutes ampm arrays exist is because its easier for the timer to work with integer values while the label is displayed on the tableview. Otherwise there would be constant parsing and adding of strings to int and vice versa

    var selectedHourArray:[Int]?

    var selectedMinuteArray:[Int]?

    var selectedAMPMArray: [Int]?
    
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
    
    UserDefaults.standard.set(selectedMinuteArray, forKey: "timerLabelArray")
    
}


func saveDataSelectedHourArray(selectedHourArray:[Int]) {
    
    UserDefaults.standard.set(selectedHourArray, forKey: "timerLabelArray")
    
}

func saveDataSelectedAMPMArray(selectedAMPMArray:[Int]) {
    
    UserDefaults.standard.set(selectedAMPMArray, forKey: "timerLabelArray")
    
}

func saveDataAddAlarmTextFieldArray(addAlarmTextFieldArray:[String]) {
    
    UserDefaults.standard.set(addAlarmTextFieldArray, forKey: "timerLabelArray")
    
}

func saveDataAlarmONOFF(alarmONOFF:[Bool]) {
    
    UserDefaults.standard.set(alarmONOFF, forKey: "timerLabelArray")
    
}

func saveDataAudioNameArray(audioNameArray:[String]) {
    
    UserDefaults.standard.set(audioNameArray, forKey: "timerLabelArray")
    
}






// fetch starts here


func fetchData() -> [String]? {
    
    if let todo = UserDefaults.standard.array(forKey: "todoList") as?  [String]
    {
        
        return todo
    } else {
        
        return nil
        
    }
    
    
    
    
    
}





