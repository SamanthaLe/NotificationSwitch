//
//  ViewController.swift
//  NotificationSwitch
//
//  Created by Samantha Le on 24/08/16.
//  Copyright © 2016 Samantha Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var notificationsLeftLabel: UILabel!
    
    @IBOutlet weak var waterImage1: UIImageView!
    @IBOutlet weak var waterImage2: UIImageView!
    @IBOutlet weak var waterImage3: UIImageView!
    @IBOutlet weak var waterImage4: UIImageView!
    @IBOutlet weak var waterImage5: UIImageView!
    
    var timeOption = 0
    var totalTimeOption = 0
    var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textLabel.text = String(1)
        switchLabel.text = "Switch is OFF"
        notificationsLeftLabel.text = String(timeOption)
        hideInitialWaterImages()
        
        mySwitch.addTarget(self, action: #selector(ViewController.switchChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            timeOption = 1
        case 1:
            timeOption = 2
            waterImage2.hidden = false
            waterImage3.hidden = true
            waterImage4.hidden = true
            waterImage5.hidden = true
        case 2:
            timeOption = 3
            waterImage2.hidden = false
            waterImage3.hidden = false
            waterImage4.hidden = true
            waterImage5.hidden = true
        case 3:
            timeOption = 4
            waterImage2.hidden = false
            waterImage3.hidden = false
            waterImage4.hidden = false
            waterImage5.hidden = true
        case 4:
            timeOption = 5
            waterImage2.hidden = false
            waterImage3.hidden = false
            waterImage4.hidden = false
            waterImage5.hidden = false
        default:
            break;
        }
        textLabel.text = String(timeOption)
    }
    
    func switchChanged(switchState: UISwitch) {
        if switchState.on {
            switchLabel.text = "Switch is ON"
            totalTimeOption = timeOption
            timer.invalidate()
        
            if timeOption == 0 {
                timeOption = 1
            }
            
            registerNotifications()
            notificationsLeftLabel.text = String(timeOption)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(createNotifications), userInfo: nil, repeats: true)
            
        } else {
            switchLabel.text = "Switch is OFF"
            notificationsLeftLabel.text = String(0)
        }
    }
    
    func registerNotifications() {
        // Notification Permission
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    func createNotifications() {
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 0)
        notification.alertBody = "HEY, go drink some water now! Reminder \(totalTimeOption - timeOption + 1) / \(totalTimeOption)."
        notification.alertAction = "dismiss (drink water before you swipe this yoo)"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        timeOption = timeOption - 1
        
        notificationsLeftLabel.text = String(timeOption)
        
        if timeOption == 0 {
            timer.invalidate()
            mySwitch.setOn(false, animated: true)
            switchLabel.text = "Switch is OFF"
        }
    }
    
    func hideInitialWaterImages() {
        waterImage2.hidden = true
        waterImage3.hidden = true
        waterImage4.hidden = true
        waterImage5.hidden = true
    }
}