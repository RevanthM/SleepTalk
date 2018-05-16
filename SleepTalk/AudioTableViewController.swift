//
//  AudioTableViewController.swift
//  SleepTalk
//
//  Created by Revanth Matha on 5/14/18.
//  Copyright © 2018 Revanth Matha. All rights reserved.
//

import Foundation
import UIKit

class AudioTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var audioTableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let audiocell = tableView.dequeueReusableCell(withIdentifier: "audiocell") as! CustomAudioTableViewCell
        
        return audiocell
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {



            return 1
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        audioTableView.delegate = self
        audioTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AudioTableViewController.audioAddTapped))
        
        
    }
    
    
    @objc func audioAddTapped() {
        alarmclicked = ""
        
        
        print("audio clickedaudio clickedaudio clickedaudio clickedaudio clickedaudio clickedaudio clickedaudio clickedaudio clickedaudio clickedaudio clicked")
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddRecording") as! NewRecordingViewController
        
        self.navigationController?.pushViewController(loginVC, animated: true)
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       audioTableView.reloadData()
    }

    }


    
    
    
    
    
    

