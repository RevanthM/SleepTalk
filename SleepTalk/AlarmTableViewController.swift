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

    
    var classAlarmTimer = AlarmTimer()
    var audio:[Audio]? = nil
    @IBOutlet var alarmTableView: UITableView!
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let todo = timerLabelArray {
            
            return todo.count
            
        } else {
            
            return 0
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alarmTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "customAlarmCell") as! CustomAlarmTableViewCell
        
        cell.alarmNameLabel.text = addAlarmTextFieldArray![indexPath.row]
        
        cell.timeLabel.text = timerLabelArray![indexPath.row]
        
        //here is programatically switch make to the table view
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        
        
        
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        
        return cell
        
        
    }
    
    // tutorial? https://stackoverflow.com/questions/47038673/add-switch-in-uitableview-cell-in-swift
    
    
    
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        
            if sender.isOn == true {
            
                alarmONOFF![sender.tag] = true
            
        } else {
            
                       alarmONOFF![sender.tag] = false
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //alarmTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         alarmTableView.delegate = self
         alarmTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        //starts timer
        classAlarmTimer.alarmTimerFunction()
        
        
        
        if (CoreDataHandler.saveObject(audioName: "Test"))
        {
            audio = CoreDataHandler.fetchObject()
            
            for i in audio! {
                print(i.audioName!)
            }
        }
        
        if (CoreDataHandler.deleteObject(audio: audio![1]))
        {
            audio = CoreDataHandler.fetchObject()
            print("Deleted object")
            for i in audio! {
                print(i.audioName!)
            }
            print(audio?.count)
        }
        
        if CoreDataHandler.cleanDelete() {
            audio = CoreDataHandler.fetchObject()
            print(audio?.count)
        }
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
