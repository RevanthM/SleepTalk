//
//  AlarmTimer.swift
//  SleepTalk
//
//  Created by Revanth Matha on 5/5/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import Foundation
import UIKit


class AlarmTimer {
    
    func alarmTimer() {



        alarmTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(runAlarmTimer), userInfo: nil, repeats: true)





    }

    @objc func runAlarmTimer() {



        print("hi")

    }
    
    
}
