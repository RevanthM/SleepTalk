//
//  DataHolder.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/26/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import Foundation

class DataHolder {
    
    // setting up arrays screen by screen
    // alarmTableView
    
    var timerLabelArray = [String]()
    
    var alarmNameArray = [String]()
    
    var audioNameArray = [String]()
    
    var audioAlarmNameDictionary = [String : String]() // each alarm is associated with a specific audio filename
    
    var alarmONOFF = [String]()
    
    // Add AlarmViewControllers - I realized some arrays repeat and are reused once saved in coredata.
    
    // Add recordingViewController
    
    var audioDurationArray = [String]()
    
    var audioNameDurationDictionary = [String : Int]()
    
    
}
