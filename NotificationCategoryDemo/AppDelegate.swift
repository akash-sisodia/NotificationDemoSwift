//
//  AppDelegate.swift
//  NotificationCategoryDemo
// Created by Akash Singh Sisodia on 6/29/17
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var commingFromNotification:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if(commingFromNotification){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "viewview") as! SViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = redViewController
        
        }

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
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


}

