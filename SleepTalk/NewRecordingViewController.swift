//
//  NewRecordingViewController.swift
//  SleepTalk
//
//  Created by Revanth Matha on 4/19/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import UIKit
import AVFoundation
import CloudKit

// i followed this tutorial https://stackoverflow.com/questions/26472747/recording-audio-in-swift to incorporate the audio recordings... There are two answers relevent to implementation of swift 3.0 code which I then modified to conform to swift 4.0 standards.



class NewRecordingViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet var audioNameTextField: UITextField!
    @IBOutlet var recordingTimeLabel: UILabel!
    @IBOutlet var record_btn_ref: UIButton!
    @IBOutlet var play_btn_ref: UIButton!
    
    //outlet that gives filename a value.
    //@IBOutlet var audioNameTF: UITextField! see audioNameTextField
    
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
    var audioData:NSData?
    var audioStringArray=[String]()
    var heldSoundURL = URL(fileURLWithPath: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        check_record_permission()
        addToolBar(textField: audioNameTextField)
        
        audioData = fetchAudioData()
       // audioStringArray = fetchAudioStringArray()!
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func check_record_permission()
    {
        switch AVAudioSession.sharedInstance().recordPermission() {
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.isAudioRecordingGranted = true
                    } else {
                        self.isAudioRecordingGranted = false
                    }
                }
            }
            break
        default:
            break
        }
    }

    //generate path where you want to save that recording as myRecording.m4a
    
    class func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getFileUrl() -> URL
    {
        let filename = "myRecording.m4a"
        let filePath = NewRecordingViewController.getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    class func getWhistleURL() -> URL {
        return
            getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
    
    func directoryURL(hold:Bool) -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let date = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddhhss"
        
        var dateString = dateFormatter.string(from: date as Date)
        dateString.append(".m4a")
        print("Date String:" + dateString)
        audioNameArray!.append(dateString)
        if (hold == true) {
            heldSoundURL = NewRecordingViewController.getDocumentsDirectory().appendingPathComponent(dateString)
        }
        return NewRecordingViewController.getDocumentsDirectory().appendingPathComponent(dateString)
    }
    
    
    
   
    
    //Setup the recorder
    
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                
                
                unowned let myself = self
                audioRecorder = try AVAudioRecorder(url: directoryURL(hold: true), settings: settings)
                audioStringArray.append(heldSoundURL.absoluteString)
                print("Appended:" + heldSoundURL.absoluteString)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                display_alert(msg_title: "Error", msg_desc: error.localizedDescription, action_title: "OK")
            }
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Don't have access to use your microphone.", action_title: "OK")
        }
    }


    
    // Start recording when button start_recording press & display seconds using updateAudioMeter, & if recording is start then finish the recording
    
    
    @IBAction func start_recording(_ sender: UIButton)
    {
        if(isRecording)
        {
            finishAudioRecording(success: true)
            record_btn_ref.setImage(UIImage(named: "Record.png"), for: UIControlState.normal)
            play_btn_ref.isEnabled = true
            isRecording = false
        }
        else
        {
            setup_recorder()
            let audioURL = heldSoundURL
            print(audioURL.absoluteString)
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            record_btn_ref.setImage(UIImage(named: "FinishRecording.png"), for: UIControlState.normal)
            play_btn_ref.isEnabled = false
            isRecording = true
        }
    }
    
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    func finishAudioRecording(success: Bool)
    {
        if success
        {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
            let tempURL = URL(string: audioStringArray[0])
            audioData = NSData(contentsOf: tempURL!)
            audioData?.write(to: tempURL!, atomically: true)
            UserDefaults.standard.set(audioData, forKey: "audioData")
            UserDefaults.standard.set(audioStringArray, forKey: "audioStringArray")
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Recording failed.", action_title: "OK")
        }
    }
    
    // Play the recording
    
    func prepare_play()
    {
        do
        {
            let tempURL = URL(string: audioStringArray[0]) //temporarily set to index 0 for testing purposes
            print("Attempting to play:" + tempURL!.absoluteString)
            audioPlayer = try AVAudioPlayer(contentsOf: tempURL!)
            
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    
    @IBAction func play_recording(_ sender: Any)
    {
        if(isPlaying)
        {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            record_btn_ref.isEnabled = true
            isPlaying = false
        }
        else
        {
            let tempURL = URL(string: audioStringArray[0])
            print("TempURL:" + tempURL!.absoluteString)
            if FileManager.default.fileExists(atPath: tempURL!.path)
            {
                record_btn_ref.isEnabled = false
                play_btn_ref.setImage(UIImage(named: "PlayGreen.png"), for: UIControlState.normal)
                play_btn_ref.sizeToFit();
                prepare_play()
                audioPlayer.play()
                isPlaying = true
           }
            else
            {
                display_alert(msg_title: "Error", msg_desc: "Audio file is missing.", action_title: "OK")
            }
        }
    }
    
    // When recording is finish enable the play button & when play is finish enable the record button
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        play_btn_ref.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        isPlaying = false
        play_btn_ref.setImage(UIImage(named: "PlayGreen.png"), for: UIControlState.normal)
        record_btn_ref.isEnabled = true
    }
    
   // Generalize function for display alert
    
    func display_alert(msg_title : String , msg_desc : String ,action_title : String)
    {
        let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action_title, style: .default)
        {
            (result : UIAlertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }

    // when save is clicked implement core data
    // tutorials for coredata used https://www.youtube.com/watch?v=cL68k-2yINY , https://www.youtube.com/watch?v=3b8P44XdwkQ , https://www.youtube.com/watch?v=Xnqk9nVeU1E
    
    @IBAction @objc func saveButton(_ sender: UIButton) {
        
        let whistleRecord = CKRecord(recordType: "Whistles")
        
        
        let audioURL = heldSoundURL
        let whistleAsset = CKAsset(fileURL: audioURL)
        whistleRecord["audio"] = whistleAsset
        
        print(audioURL.absoluteString)
        CKContainer.default().publicCloudDatabase.save(whistleRecord)
            
            
        { [unowned self] record, error in
            DispatchQueue.main.async {
                if let error = error {
print("Error")
                }
            }
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


