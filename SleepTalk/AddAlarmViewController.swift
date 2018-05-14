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

    // initiating declaring dataholder class
    
    
    

    var audioSelected = ""
    @IBOutlet var timePickerView: UIPickerView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var addAlarmTextField: UITextField!
    
    
    
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
        
        // this doesn't do anything???
        
        if alarmclicked == "" {
        
        if  (addAlarmTextField.text != nil) && addAlarmTextField.text != "" {
            
            addAlarmTextFieldArray?.append(addAlarmTextField.text!)
            
            addAlarmTextField.text = ""
            
            addAlarmTextField.placeholder = "Add More ?"
        }
        
        else if addAlarmTextField.text == ""
            
            // alerts user to assign a name to alarm name
        {
            let alert = UIAlertController(title: "Error", message: "Please assign a name to this alarm.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if  (timeLabel.text != nil) && timeLabel.text != "" {
            
            timerLabelArray?.append(timeLabel.text!)
            
        }
        // changed minutesarray to type string to allow appending of var minutes from this class to get 00,01,02 etc vs 0,1,2... maybe it was easier to convert string to int... fk.. also i had to wait a whole half hour to see how the current date time got the minutes if they were below 10, were they 00,01,02,03 etc or were they 0,1,2,3... so I waited they appear as 0,1,2,3,4 etc
        if  (selectedMinute != "") {
            
            selectedMinuteArray?.append(Int(selectedMinute)!)
            
        }
        
        if  (selectedHour != "") {
            
            selectedHourArray?.append(Int(selectedHour)!)
            
        }
        
        
        if  selectedAMPM == "0" {
            
            selectedAMPMArray?.append("AM")
            // fixes bug that assigns zero value to AMPM global variable
        } else {
            
            selectedAMPMArray?.append(selectedAMPM)
        }
        
        alarmONOFF?.append(true)
        
        // navigates back to previous screen
    self.navigationController?.popViewController(animated: true)
        } else {
            
            timerLabelArray![Int(alarmclicked)!] = timeLabel.text!
            
            selectedMinuteArray![Int(alarmclicked)!] = Int(selectedMinute)!
            
            selectedHourArray![Int(alarmclicked)!] = Int(selectedHour)!
            
            if  selectedAMPM == "0" {
                
                selectedAMPMArray![Int(alarmclicked)!] = "AM"
                // fixes bug that assigns zero value to AMPM global variable
            } else {
                
                selectedAMPMArray![Int(alarmclicked)!] = selectedAMPM
            }
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        
        let numAlarms = timerLabelArray?.count
        
        //     addAlarmTextField.text = "Alarm \(numAlarms!+1)"//Default text in case user forgets to assign custom name
        addToolBar(textField: addAlarmTextField)
        //        //
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if alarmclicked == "" {
            addAlarmTextField.text = "Alarm \(numAlarms!+1)"//Default text in case user forgets to assign custom name
            setDefaultPickerValues()
            
            
        } else {  addAlarmTextField.text = "Alarm \(Int(alarmclicked)!+1)"
        
        
        
        timePickerView.selectRow((selectedHourArray![(Int(alarmclicked)!)]-1) , inComponent: 0, animated: true)
        timePickerView.selectRow(selectedMinuteArray![Int(alarmclicked)!] , inComponent: 1, animated: true)
        
        if selectedAMPMArray![Int(alarmclicked)!] == "AM" {
            timePickerView.selectRow(0 , inComponent: 2, animated: true)
            
        } else {
            timePickerView.selectRow(1 , inComponent: 2, animated: true)
        }
        if alarmclicked != "" {
            selectedMinute = minutes[selectedMinuteArray![Int(alarmclicked)!]]
            
                            selectedHour = hours[selectedHourArray![Int(alarmclicked)!]-1]
        }
                if Int(selectedAMPM) == 0 {
                        selectedAMPM = "AM"
                
                    } else {
                        selectedAMPM = "PM"
                    }
        
               timeLabel.text = "Time: \(selectedHour) : \(selectedMinute) : \(selectedAMPM) "
    
        
        
        
        
        
        
        
    }
    }
    
    
    func setDefaultPickerValues() //sets picker time to current time
    {
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        let minutes2 = calendar.component(.minute, from: date)
        
        if (hour > 12) {
            selectedAMPM = "PM"
            timePickerView.selectRow(2, inComponent:2, animated:false)
            // what does this the above line do? in component 2 you selected row 2 by default?
            // w/e it works, I can't figure out the purpose of the first 2
            hour = hour-12
        }
        timePickerView.selectRow(hour-1, inComponent: 0, animated: false)
        timePickerView.selectRow(minutes2, inComponent: 1, animated: false)
        
        selectedHour = String(timePickerView.selectedRow(inComponent: 0)+1)
        
     //   selectedMinute = String(timePickerView.selectedRow(inComponent: 1))
        // the above commented out code shows 1,2,3. The below code shows 01,02,03 etc.
        selectedMinute = minutes[timePickerView.selectedRow(inComponent: 1)]
        
        
        
        
        // the below is different because the default value is 0 instead am/pm
  //      selectedAMPM = String(timePickerView.selectedRow(inComponent: 2))
        
        selectedAMPM = "AM"
        
        timeLabel.text = "Time: \(selectedHour) : \(selectedMinute) : \(selectedAMPM) "
    }
    
    
    
    
    
//    func doneButtonAction() {
//        self.view.endEditing(true)
//    }
    
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
        selectedMinute = minutes[pickerView.selectedRow(inComponent: 1)]
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

// textfield has done and cancel buttons
// seriously wtf apple this is way more complicated then it has to be.
// tutorial used https://stackoverflow.com/questions/30983516/add-uitoolbar-to-all-keyboards-swift
extension UIViewController: UITextFieldDelegate {
    func addToolBar(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76 / 255, green: 217 / 255, blue: 100 / 255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    @objc func cancelPressed() {
        view.endEditing(true) // or do something
    }
}

