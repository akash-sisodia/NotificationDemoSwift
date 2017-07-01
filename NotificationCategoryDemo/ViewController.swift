//
//  ViewController.swift
//  NotificationCategoryDemo
//
// Created by Akash Singh Sisodia on 6/29/17
//

import UIKit
import UserNotifications


class ViewController: UIViewController  {
    
    //MARK: Properties and outlets
    let time:TimeInterval = 10.0
    let snooze:TimeInterval = 5.0
    var isGrantedAccess = false
    @IBOutlet weak var commentsLabel: UILabel!
 
    //MARK: - Actions
    @IBAction func startButton(_ sender: UIButton) {
        
        
        
        
        
        ASNotification.init().setNotification( forDay: [1,2,3,4,5,6],time: Date())
        
        
   // ASNotification.init().TestNoti()
        
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print(request)
            }
        })
        
        
        
 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
}
}


    
   
    




















