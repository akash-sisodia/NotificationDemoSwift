//
//  ViewController.swift
//  NotificationCategoryDemo
//
// Created by Akash Singh Sisodia on 6/29/17
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate {
    
    //MARK: Properties and outlets
    let time:TimeInterval = 10.0
    let snooze:TimeInterval = 5.0
    var isGrantedAccess = false
    @IBOutlet weak var commentsLabel: UILabel!
    //MARK: - Functions
    func setCategories(){
        let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze 5 Sec", options: [])
         let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Add Comment", options: [], textInputButtonTitle: "Add", textInputPlaceholder: "Add Comment Here")
       
        
        let alarmCategory = UNNotificationCategory(identifier: "alarm.category",actions: [snoozeAction,commentAction ],intentIdentifiers: [], options: [])
        
       

        
        
          UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
    func addNotification(content:UNNotificationContent,trigger:UNNotificationTrigger?, indentifier:String) {
        let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            (errorObject) in
            if let error = errorObject{
                print("Error \(error.localizedDescription) in notification \(indentifier)")
            }
        })
    }
    
    //MARK: - Actions
    @IBAction func startButton(_ sender: UIButton) {
        if isGrantedAccess{
            
            let content = UNMutableNotificationContent()
            content.title = "Alarm"
            content.subtitle = "First Alarm"
            content.body = "First Alarm"
            content.sound = UNNotificationSound.default()
            content.categoryIdentifier = "alarm.category"
            content.badge = 10

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
           
            
            
            let contenst = UNMutableNotificationContent()

            
            
            
            
 
            
            
            
            
            addNotification(content: content, trigger: trigger , indentifier: "Alarm")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedAccess = granted
                if granted{
                    self.setCategories()
                } else {
                    let alert = UIAlertController(title: "Notification Access", message: "In order to use this application, turn on notification permissions.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert , animated: true, completion: nil)
                }
        })
    }
    
    // MARK: - Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
        
           }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        let request = response.notification.request
        
                       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.commingFromNotification = true
        
        
        if identifier == "snooze"{
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            newContent.body = "Snooze 5 Seconds"
            newContent.subtitle = "Snooze 5 Seconds"
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: snooze, repeats: false)
            addNotification(content: newContent, trigger: newTrigger, indentifier: request.identifier)
            
        }
        
        if identifier == "comment"{
            let textResponse = response as! UNTextInputNotificationResponse
            commentsLabel.text = textResponse.userText
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            newContent.body = textResponse.userText
            addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
        }
        
        completionHandler()
    }
}



















