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
var minuteBasis = false


class AlarmTimer {
    
    func alarmTimerFunction() {

// changing the time interval changes the timer fire duration, for test purposes it's at 2 seconds but it'll be 60 seconds to allow it to cycle through all the arrays.

        if (minuteBasis == false)
        {
            alarmTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(runAlarmTimer), userInfo: nil, repeats: true)
        } else if (minuteBasis == true)
        {
            alarmTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(runAlarmTimer), userInfo: nil, repeats: true)
        }

    }

    @objc func runAlarmTimer() {

        // this code here gives the current time... see console for details
        // tutorial used https://stackoverflow.com/questions/24070450/how-to-get-the-current-time-as-datetime
        var date = Date()
        var calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        var seconds = calendar.component(.second, from: date)
        var AMPMCheck = ""
        
        // uncomment the print statements to check if current time works correctly fun fact highlights all the text and then doing cmd+/ will comment out multi-line code blocks
        
        print(date)
        print(calendar)
        print(hour)
        print(minutes)
        
        // unfortunatly or fortunately the date time is in military time 24 hour clock with no am/pm so the following code is done to assign the varible AMPMCheck am/pm and turn hour to the correct hour.
        
        if hour > 12 {
           AMPMCheck = "PM"
           hour = hour - 12
      //      print(hour)
        } else {
            AMPMCheck = "AM"
        }
        
        //loop to check which alarms are on/off
        
        for i in 0 ... alarmONOFF!.count
        {
            if (i > 0)
            {
                if (alarmONOFF![i-1] == true )
                {
                    print("alarm \(i) is on")
                    //play audio
                } else {
                    print("alarm \(i) is off")
                }
            }
        }
        
        print(AMPMCheck)
        
        currentTime = String(hour)+":"+String(minutes)+":"+AMPMCheck
        
        // comment out following print statements, used to check if arrays and current time match
        
        print(AMPMCheck)
        print(currentTime)
        
        print(selectedHourArray)
        print(selectedMinuteArray)
        print(selectedAMPMArray)
        print(alarmONOFF)
        
        print("COUNT: %i", selectedHourArray?.count)
        if (selectedHourArray!.count > 0)
        {
            for i in 0 ... selectedHourArray!.count-1
            {
                if hour == selectedHourArray![i]
                {
                    if minutes == selectedMinuteArray![i]
                    {
                        if AMPMCheck == selectedAMPMArray![i]
                        {
                            print("Hit") //hits on alarm i
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.alarmGoOff(iAlarm: i)
                        }
                    }
                }
            }
        }
        print("Seconds: ", seconds)
        print("Minute Basis: ", minuteBasis)
        if (minuteBasis == false)
        {
            if (seconds >= 0 && seconds < 2)
            {
                minuteBasis = true
                alarmTimer.invalidate()
                alarmTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(runAlarmTimer), userInfo: nil, repeats: true)
            }
        }
        
        
    }
    
    
}
