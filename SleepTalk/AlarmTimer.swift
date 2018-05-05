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

    }
    
    
}
