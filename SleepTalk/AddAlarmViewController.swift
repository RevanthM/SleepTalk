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
        
        if  (addAlarmTextField.text != nil) && addAlarmTextField.text != "" {
            
            addAlarmTextFieldArray?.append(addAlarmTextField.text!)
            
            addAlarmTextField.text = ""
            
            addAlarmTextField.placeholder = "Add More ?"
        } else if addAlarmTextField.text == ""
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
    
        if  (selectedMinute != "") {
            
            selectedMinuteArray?.append(Int(selectedMinute)!)
            
        }
        
        if  (selectedHour != "") {
            
            selectedHourArray?.append(Int(selectedHour)!)
            
        }
        
        if  (selectedHour != "") {
            
            selectedHourArray?.append(Int(selectedHour)!)
            
        }
        
        if  selectedAMPM != "" {
            
            selectedAMPM.append(selectedAMPM)
            
        }
        
        alarmONOFF?.append(true)
        
        
    self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
//        // resign keyboard
//        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
//        //create left side empty space so that done button set on right side
//        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
//        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: Selector(("doneButtonAction")))
//        toolbar.setItems([flexSpace, doneBtn], animated: false)
//        toolbar.sizeToFit()
//
//        self.alarmNameLabel.inputAccessoryView = toolbar
        // seriously wtf apple this is way more complicated then it has to be.
        // tutorial used https://stackoverflow.com/questions/30983516/add-uitoolbar-to-all-keyboards-swift
        let numAlarms = timerLabelArray?.count
        addAlarmTextField.text = "Alarm \(numAlarms!+1)"//Default text in case user forgets to assign custom name
        addToolBar(textField: addAlarmTextField)
//        //
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDefaultPickerValues()
    }
    
    func setDefaultPickerValues() //sets picker time to current time
    {
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        if (hour > 12) {
            timePickerView.selectRow(2, inComponent:2, animated:false)
            hour = hour-12
        }
        timePickerView.selectRow(hour-1, inComponent: 0, animated: false)
        timePickerView.selectRow(minutes, inComponent: 1, animated: false)
        
        selectedHour = String(timePickerView.selectedRow(inComponent: 0)+1)
        selectedMinute = String(timePickerView.selectedRow(inComponent: 1))
        selectedAMPM = String(timePickerView.selectedRow(inComponent: 2))
        
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

