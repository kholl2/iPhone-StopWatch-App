//
//  ViewController.swift
//  Holla1
//
//  Created by Kruthika Holla on 9/10/15.
//  Copyright (c) 2015 Kruthika Holla. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, DataSourceTimer  {

    var model = TimerModelObjC()
    private var startButtonIsActive: Bool = true
    
    @IBOutlet weak var displayTimer: UILabel!
    
    @IBOutlet weak var displayLap: UILabel!

    
    @IBOutlet weak var tableOutlet: UITableView!
    
    @IBOutlet weak var startOutlet: UIButton!
    
    
    //MARK: start button of the timer
    @IBAction func startButton(sender: AnyObject) {
        if (startButtonIsActive){
            startButtonIsActive = !startButtonIsActive
            startOutlet.setTitle("Stop", forState: UIControlState())
            startOutlet.setTitleColor(UIColor.redColor(), forState: UIControlState())
            startOutlet.backgroundColor = UIColor.whiteColor()
            lapOutlet.enabled = true
            lapOutlet.setTitle("Lap", forState: UIControlState())
            lapOutlet.setTitleColor(UIColor.blackColor(), forState: UIControlState())
            
            //starts the timer
            
            if (!model.timerIsActive){
                model.fireTimer()
                model.timerIsActive = true
            }
            
            //resumes the timer
           else{
                model.resumeTimer()
            }
        }
        
        //pauses the timer
        else{
            startButtonIsActive = !startButtonIsActive
            model.timerIsActive = true
            startOutlet.setTitle("Start", forState: UIControlState())
            startOutlet.setTitleColor(UIColor.greenColor(), forState: UIControlState())
            startOutlet.backgroundColor = UIColor.whiteColor()

            lapOutlet.setTitle("Reset", forState: UIControlState())
            lapOutlet.setTitleColor(UIColor.blackColor(), forState: UIControlState())
            lapOutlet.backgroundColor = UIColor.whiteColor()
            
            model.stopTimer()
        }
    }
    
    
    @IBOutlet weak var lapOutlet: UIButton! //Outlet for the lap button
    
    
    //MARK: lap button of the timer
    @IBAction func lapButton(sender: AnyObject) {
        //MARK:if lap button is pressed
        if (!startButtonIsActive){
            model.lapButtonPressed(displayLap.text)
            self.displayLap.text = "00:00:00"
            
            //MARK: update the table
            var indPath:[NSIndexPath] = [NSIndexPath]()
            indPath.append(NSIndexPath(forRow:0,inSection:0))
            self.tableOutlet.beginUpdates()
            self.tableOutlet.insertRowsAtIndexPaths(indPath, withRowAnimation: UITableViewRowAnimation.Top)
            self.tableOutlet.endUpdates()
        }
            
          //MARK: if reset button is pressed
        else{
            model.resetTimer()
            
            displayLap.text = "00:00:00"
            displayTimer.text = "00:00:00"
            
            tableOutlet.reloadData() //reload the table

            model.timerIsActive = false
            
            lapOutlet.setTitle("Lap", forState: UIControlState())
            lapOutlet.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState())
            lapOutlet.backgroundColor = UIColor.whiteColor()
            lapOutlet.enabled = false
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
        model.delegate = self
        
        startOutlet.setTitleColor(UIColor.greenColor(), forState: UIControlState())
        startOutlet.backgroundColor = UIColor.whiteColor()
        startOutlet.layer.cornerRadius = startOutlet.frame.size.width/2
        lapOutlet.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState())
        lapOutlet.backgroundColor = UIColor.whiteColor()
        lapOutlet.layer.cornerRadius = startOutlet.frame.size.width/2
        lapOutlet.enabled = false
    }

    //MARK: timer display
    func timerDataUpdate(timerData: [NSObject : AnyObject]!) {
        let timerMinutes: Int = timerData["timerMinutes"] as! NSInteger
        let minutesDisplay = String (format: "%02d", timerMinutes)
        let timerSeconds: Int = timerData["timerSeconds"] as! NSInteger
        let secondsDisplay = String (format: "%02d",timerSeconds)
        let timerMilliSeconds: Int = timerData["timerMilliSeconds"] as! NSInteger
        let milliSecondsDisplay = String (format: "%02d",timerMilliSeconds)
        self.displayTimer.text =  "\(minutesDisplay):\(secondsDisplay):\(milliSecondsDisplay)"
    }
    
    //MARK: lap timer display
    func lapTimerDataUpdate(lapTimerData: [NSObject : AnyObject]!) {
        let lapTimerMinutes: Int = lapTimerData["lapTimerMinutes"] as! NSInteger
        let lapMinutesDisplay = String (format: "%02d", lapTimerMinutes)
        let lapTimerSeconds: Int = lapTimerData["lapTimerSeconds"] as! NSInteger
        let lapSecondsDisplay = String (format: "%02d",lapTimerSeconds)
        let lapTimerMilliSeconds: Int = lapTimerData["lapTimerMilliSeconds"] as! NSInteger
        let lapMilliSecondsDisplay = String (format: "%02d",lapTimerMilliSeconds)
        self.displayLap.text =  "\(lapMinutesDisplay):\(lapSecondsDisplay):\(lapMilliSecondsDisplay)"
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return model.lapArray.count
        
    }
    
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        let lapNumber = model.lapArray.count - indexPath.row
        cell.textLabel?.text = "Lap \(lapNumber)"
        cell.textLabel?.textColor = UIColor.lightGrayColor()
        cell.detailTextLabel!.text = model.lapArray.objectAtIndex(indexPath.row) as? String
        cell.detailTextLabel?.textColor = UIColor.blackColor()
        cell.detailTextLabel?.textAlignment = NSTextAlignment.Left
        return cell
    }
}

