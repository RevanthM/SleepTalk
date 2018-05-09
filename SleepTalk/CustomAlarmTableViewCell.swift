//
//  CustomAlarmTableViewCell.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/26/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import UIKit

// I followed this tutorial https://www.youtube.com/watch?v=kYmZ-4l0Yy4

class CustomAlarmTableViewCell: UITableViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var alarmNameLabel: UILabel!
    @IBOutlet var audioNameLabel: UILabel!
    @IBOutlet var alarmSwitchOutlet: UISwitch!
    
    
    // turns alarm on and off
    
    @IBAction func addAlarmButton(_ sender: UIBarButtonItem) {
        alarmclicked = ""
        print(alarmclicked)
    }
    
    
    @IBAction func alarmSwitch(_ sender: UISwitch) {
        
        print(alarmSwitchOutlet.tag)
        
        if alarmSwitchOutlet.isOn == true {
            
                            alarmONOFF![alarmSwitchOutlet.tag] = true
            
                    } else {
            
                                   alarmONOFF![alarmSwitchOutlet.tag] = false
            
                    }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
