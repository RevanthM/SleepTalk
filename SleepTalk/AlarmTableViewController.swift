//
//  AlarmTableViewController.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/25/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import UIKit

var tableTimer: Timer! //checks alarmOnOFF to see if anythign has changed
// I followed https://www.youtube.com/watch?v=kYmZ-4l0Yy4 this tutorial

// this tutorial establishes memory persistance https://www.youtube.com/watch?v=V9kgI0ebUZ0 

class AlarmTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    var classAlarmTimer = AlarmTimer()
    var audio:[Audio]? = nil
    var cellArray = [CustomAlarmTableViewCell]()
    @IBOutlet var alarmTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let todo = timerLabelArray {
            
            return todo.count
            
        } else {
            
            return 0
        }
        
        
    }
    
    
    @IBAction func tapEdit(_ sender: Any) {
        print("ya")
        alarmTableView.isEditing = !alarmTableView.isEditing
        switch alarmTableView.isEditing {
        case true:
            editButton.setTitle("Done", for: UIControlState .normal)
        case false:
            editButton.setTitle("Edit", for: UIControlState .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alarmTableView.reloadData()
        
        alarmTableView.backgroundColor = UIColor.black
        
        tableTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(runTableTimer), userInfo: nil, repeats: true)
    }
    
    @objc func runTableTimer()
    {
        print("ONOFF: ", alarmONOFF!.count)
        print("CELLARRAY: ", cellArray.count)
        if (alarmONOFF!.count > 0) {
            for i in 0 ... alarmONOFF!.count-1 {
                if (alarmONOFF![i] == false) {
                    cellArray[i].alarmSwitchOutlet.setOn(false, animated: true)
                }
            }
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        var didAddAlarm = UserDefaults.standard.bool(forKey: "didAddAlarm")
        
        if (didAddAlarm == true)
        {
            didAddAlarm = false
            UserDefaults.standard.set(didAddAlarm, forKey: "didAddAlarm")
            cellArray.removeAll()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customAlarmCell") as! CustomAlarmTableViewCell
        
        
        cell.alarmNameLabel.text = addAlarmTextFieldArray![indexPath.row]
        
        cell.timeLabel.text = timerLabelArray![indexPath.row]
        
        cell.alarmSwitchOutlet.tag = indexPath.row
        
        cell.alarmSwitchOutlet.isOn = alarmONOFF![indexPath.row]
        
        
        cellArray.append(cell)
        
//        //here is programatically switch make to the table view
//        let switchView = UISwitch(frame: .zero)
//        switchView.setOn(false, animated: true)
//
//
//
//        switchView.tag = indexPath.row // for detect which row switch Changed
//        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
//        cell.accessoryView = switchView
        
        
        return cell
        
        
    }
    
    // tutorial? https://stackoverflow.com/questions/47038673/add-switch-in-uitableview-cell-in-swift
    
    
    
//    @objc func switchChanged(_ sender : UISwitch!){
//
//        print("table row switch Changed \(sender.tag)")
//        print("The switch is \(sender.isOn ? "ON" : "OFF")")
//
//            if sender.isOn == true {
//
//                alarmONOFF![sender.tag] = true
//
//        } else {
//
//                       alarmONOFF![sender.tag] = false
//
//        }
//
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //alarmTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         alarmTableView.delegate = self
         alarmTableView.dataSource = self
        cellArray.removeAll()
        // Do any additional setup after loading the view.
        
        //starts timer
        classAlarmTimer.alarmTimerFunction()
        
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.isTranslucent = false
        
        /*if (CoreDataHandler.saveObject(audioName: "Test"))
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
        }*/
        
  //  navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",style: .plain, target: self, action: #selector(addTapped))
        
       // plusButton.action: #selector(addTapped())
        
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AlarmTableViewController.addTapped))
        
        
    //    let newViewController = AddAlarmViewController()
       // self.navigationController?.pushViewController(AddAlarmViewController, animated: true)
    }
    
//    @objc func addTapped() {
//        alarmclicked = ""
//
//        self.performSegue(withIdentifier: "AddAlarmViewController", sender: AnyObject)
//        print("alarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclicked")
//    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = timerLabelArray![sourceIndexPath.row]
        timerLabelArray?.remove(at: sourceIndexPath.row)
        timerLabelArray?.insert(item, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        alarmclicked = String(indexPath.row)
        performSegue(withIdentifier: "alarmSegue", sender: self)
    //   navigationController?.pushViewController(AddAlarmViewController(), animated: false)
       
      //  present(AddAlarmViewController(), animated: false, completion: nil)

        
    }
    
    @objc func addTapped() {
                alarmclicked = ""
        
      
                print("alarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclicked")
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddAlarmViewController") as! AddAlarmViewController
        
        self.navigationController?.pushViewController(loginVC, animated: true)

        
            }

    
    @IBAction func addAlarmButton(_ sender: Any) {
    //    addpressed()
        print("alarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclickedalarmclicked")
        
        
    }
    

    
    
    
    
    
    
    
    
    
    // select a row and transition view tutorial  https://www.youtube.com/watch?v=5js6nwDcedE start from 8:00 minutes

    
    

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
