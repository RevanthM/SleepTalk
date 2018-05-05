//
//  AlarmTimer.swift
//  SleepTalk
//
//  Created by Revanth Matha on 5/5/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import Foundation
import UIKit

var alarmTimer: Timer!



class AlarmTimer {
    
    func alarmTimerFunction() {



        alarmTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(runAlarmTimer), userInfo: nil, repeats: true)





    }

    @objc func runAlarmTimer() {



        print("hi")

        var date = Date()
        var calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        var AMPMCheck = ""
        
        print(date)
        print(calendar)
        print(hour)
        print(minutes)
        
        if hour > 12 {
           AMPMCheck = "PM"
           hour = hour - 12
            print(hour)
        } else {
            AMPMCheck = "AM"
        }
        
        currentTime = String(hour)+":"+String(minutes)+":"+AMPMCheck
        print(currentTime)
        
        
    }
    
    
}
