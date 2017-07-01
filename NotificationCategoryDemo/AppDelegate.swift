//
//  AppDelegate.swift
//  NotificationCategoryDemo
// Created by Akash Singh Sisodia on 6/29/17
import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
   
    var isGrantedAccess = false
    var window: UIWindow?
    var commingFromNotification:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     
    // MARK:  --> Register For LocalNotifications
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedAccess = granted
                if granted{
                  ASNotification.init().setCategories()
                } else {
                    let alert = UIAlertController(title: "Notification Access", message: "In order to use this application, turn on notification permissions.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.window?.rootViewController?.present(alert , animated: true, completion: nil)
                }
        })
        
        return true
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
           }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
      
    }
    
    
    
    // MARK:  --> Handle LocalNotification
     func application(application: UIApplication,

                             handleActionWithIdentifier identifier:String?,
                         forLocalNotification notification:UILocalNotification,
                         completionHandler: @escaping (() -> Void))
        {
            
            if (identifier == "FIRST_ACTION")
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "actionOnePressed"), object: nil)
            }
            else if (identifier == "SECOND_ACTION")
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "actionTwoPressed"), object: nil)
            }
            
            completionHandler()
        }
        
        func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
         //   print("MessageId: \(userInfo["gcm_message_id"])")
            print(userInfo)
        }
        
        func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
            if #available(iOS 8.2, *) {
                print("Function goes here : \(notification.alertTitle)")
            } else {
                // Fallback on earlier versions
            }
            if notification.category == "FIRST_CATEGORY" {
             
            }
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
         //   let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: snooze, repeats: false)
            
            
            //ASNotification.init().addNotification(content: newContent, trigger: , indentifier: request.identifier)
            
        }else if identifier == "comment"{
            let textResponse = response as! UNTextInputNotificationResponse
            //commentsLabel.text = textResponse.userText
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            newContent.body = textResponse.userText
            
            print("comment ---->> \(textResponse.userText)")
            
            ASNotification.init().addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
        }else{
        
        
        
        
            if(commingFromNotification){
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "viewview") as! SViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = redViewController
                
            }

        
        
        
        }
        
        completionHandler()
    }
    func didReceive(_ request: UNNotificationRequest,
                    withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void)
    {}

}


