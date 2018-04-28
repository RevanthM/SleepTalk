//
//  AlarmTableViewController.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/25/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import UIKit

// I followed https://www.youtube.com/watch?v=kYmZ-4l0Yy4 this tutorial

// this tutorial establishes memory persistance https://www.youtube.com/watch?v=V9kgI0ebUZ0 

class AlarmTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var classDataHolder = DataHolder()
    
    
    
    @IBOutlet var alarmTableView: UITableView!
    
    
    let elements = ["1","2"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if classDataHolder.timerLabelArray?.count == 0 {
            return 0
        } else {
            return classDataHolder.timerLabelArray!.count
        }
        
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "customAlarmCell") as! CustomAlarmTableViewCell
        
        cell.alarmNameLabel.text = classDataHolder.alarmNameArray![indexPath.row]
        cell.timeLabel.text = classDataHolder.timerLabelArray![indexPath.row]
        
//        if classDataHolder.alarmNameArray.count != 0 {
//        cell.alarmNameLabel.text = classDataHolder.alarmNameArray[indexPath.row]
//
//        } else {
//
//         cell.alarmNameLabel.text = elements[indexPath.row]
//
//
//        }
//
//        cell.audioNameLabel.text = elements[indexPath.row]
//
//
//        if classDataHolder.timerLabelArray.count != 0 {
//        cell.timeLabel.text = classDataHolder.timerLabelArray[indexPath.row]
//
//        } else {
//
//            cell.alarmNameLabel.text = elements[indexPath.row]
//
//
//        }
        
        //cell.timeLabel.text = elements[indexPath.row]
        
        return cell
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

         alarmTableView.delegate = self
         alarmTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
