//
//  AddAlarmViewController.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/22/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import UIKit


// will want to integrate this later https://www.youtube.com/watch?v=QBuYmP2p3AY as better picker view... save screen space and have entire app as 1 screen?


// https://www.youtube.com/watch?v=MhQGOdHjVAg , https://www.youtube.com/watch?v=U7d7K1_Uivw for tutorial on picker view

// So when the save button is clicked. The CoreData + the arrays are updated.

class AddAlarmViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var alarmNameLabel: UITextField!
    var audioSelected = ""
    @IBOutlet var timePickerView: UIPickerView!
    @IBOutlet var timeLabel: UILabel!
    
    
    var selectedHour = ""
    var selectedMinute = ""
    var selectedAMPM = ""
    
    var hours = ["1",
                 "2",
                 "3",
                 "4",
                 "5",
                 "6",
                 "7",
                 "8",
                 "9",
                 "10",
                 "11",
                 "12"]
    
    // dont worry i didn't type all of this, i wrote a loop and printed it to console and just cut and pasted it here.
    
    var minutes = ["00",
                   "01",
                   "02",
                   "03",
                   "04",
                   "05",
                   "06",
                   "07",
                   "08",
                   "09",
                   "10",
                   "11",
                   "12",
                   "13",
                   "14",
                   "15",
                   "16",
                   "17",
                   "18",
                   "19",
                   "20",
                   "21",
                   "22",
                   "23",
                   "24",
                   "25",
                   "26",
                   "27",
                   "28",
                   "29",
                   "30",
                   "31",
                   "32",
                   "33",
                   "34",
                   "35",
                   "36",
                   "37",
                   "38",
                   "39",
                   "40",
                   "41",
                   "42",
                   "43",
                   "44",
                   "45",
                   "46",
                   "47",
                   "48",
                   "49",
                   "50",
                   "51",
                   "52",
                   "53",
                   "54",
                   "55",
                   "56",
                   "57",
                   "58",
                   "59"]
    
    var ampm = ["AM", "PM"]
    
    
    @IBAction func selectAudioButton(_ sender: UIButton) {
        
        
        
    }
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        
        

        
        timePickerView.delegate = self
        timePickerView.dataSource = self 
        
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if component == 0 {
          return  hours.count
        }
        else if component == 1 {
         return   minutes.count
        }
        else {
          return   ampm.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return  String(hours[row])
        }
        else if component == 1 {
            return   String(minutes[row])
        }
        else {
            return   String(ampm[row])
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        
        selectedHour = String(pickerView.selectedRow(inComponent: 0))
        selectedMinute = String(pickerView.selectedRow(inComponent: 1))
        selectedAMPM = String(pickerView.selectedRow(inComponent: 2))
        
        
        
        if selectedHour == selectedHour {
            // extremely convoluted statement, wtf am i doing...
            selectedHour =  String(Int(selectedHour)! + 1)
            
        }
        
        
        if Int(selectedAMPM) == 0 {
            selectedAMPM = "AM"
            
        } else {
            selectedAMPM = "PM"
        }
        
        timeLabel.text = "Time: \(selectedHour) : \(selectedMinute) : \(selectedAMPM) "
        
        
        
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

