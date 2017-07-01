//
//  ASNotifications.swift
//  NotificationCategoryDemo
//
//  Created by Akash Singh Sisodia on 6/30/17.
//  Copyright © 2017 AKASH SINGH SISODIA. All rights reserved.
//

import Foundation

import UserNotifications
import UIKit

class ASNotification:NSObject,UNUserNotificationCenterDelegate  {
    
    
    
    //MARK: Properties and outlets
    let time:TimeInterval = 10.0
    let snooze:TimeInterval = 5.0
    
    override init() {}
    
    
    
    
    
    
    
    // MARK:  --> Set Notification Categories
    
    func setCategories(){
        let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze 5 Sec", options: [])
        let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Add Comment", options: [], textInputButtonTitle: "Add", textInputPlaceholder: "Add Comment Here")
        
        
        let alarmCategory = UNNotificationCategory(identifier: "alarm.category",actions: [snoozeAction,commentAction ],intentIdentifiers: [], options: [])
        
        
        
        
        
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
    
    

    
    
    func setAlarmForAllDays(content:UNNotificationContent,dayArr:[Date] ,time:Date)  {
        

        
 
        for date in dayArr{
        
        
            let calendar = Calendar.current
            
            var dateComponents = DateComponents()
          dateComponents.hour = calendar.component(.hour, from: time)
          dateComponents.minute = calendar.component(.minute, from: time)
     //dateComponents.second =  calendar.component(.second, from: date)
     //dateComponents.weekday = calendar.component(.weekday, from: date)
          dateComponents.day = calendar.component(.day, from: date)
          dateComponents.month = calendar.component(.month, from: date)
          dateComponents.year = calendar.component(.year, from: date)
            
          //  let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            //content.sound = UNNotificationSound.init(named: "CustomSound.mp3")
     let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false	)
            
            var date = NSCalendar(identifier: NSCalendar.Identifier.gregorian)?.date(from: dateComponents)

            
            
            let since1970 = String((date?.timeIntervalSince1970)!)
            
            self.addNotification(content: content, trigger: trigger , indentifier: since1970)
        
        
        
        
        
        }
        
        
        
        
    }
    
    
    
    // MARK:  --> Add Notification
    
    
    func setNotification(forDay:[Int],time:Date){
     
        
        
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.subtitle = "First Alarm"
        content.body = "First Alarm"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "alarm.category"
        content.badge = 0
        
        var dict = ["":""]
        content.userInfo = dict
        
 
        
              //   let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false	)
      
 
        let identifier = ProcessInfo.processInfo.globallyUniqueString
         if let attachment = UNNotificationAttachment.create(identifier: identifier, image: #imageLiteral(resourceName: "Image"), options: nil) {
            // where myImage is any UIImage that follows the
            content.attachments = [attachment]
        }
       
        
             // handle error
       
        
        for day in forDay{
        
              switch day {
               case 1:
                
                self.setAlarmForAllDays(content:content,dayArr:getDaysArray(day: "Tuesday") ,time: time)
                
                break
            case 2:
                
              self.setAlarmForAllDays(content:content,dayArr:getDaysArray(day: "Wednesday") ,time: time )
                
                
                break
            case 3:
                
               self.setAlarmForAllDays(content:content,dayArr:getDaysArray(day: "Thursday") ,time: time )
                
                
                break
            case 4:
            self.setAlarmForAllDays(content:content,dayArr:getDaysArray(day: "Friday")  ,time: time)
                
                
                break
            case 5:
                
                self.setAlarmForAllDays(content:content,dayArr:getDaysArray(day: "Saturday") ,time: time )
                
                
                break
            case 6:
                
                
                self.setAlarmForAllDays(content:content,dayArr:getDaysArray(day: "Sunday")  ,time: time)
                
                break
            case 7:
                
                
               self.setAlarmForAllDays(content:content,dayArr:getDaysArray(day: "Monday")  ,time: time)
                
                break
                
                
                
            default:
                break
            }
            
 
        }
 
    }
    func getDaysArray(day:String)->[Date] {
        
        var mondays_arr = [Date]()
        var today_date = Date()
        
        for index in 1...5 {
            var newdate =  self.get(direction:.Next,date: today_date, day) as Date
            today_date = newdate
            mondays_arr.append(today_date)
        }
        
        
        
        
        return  mondays_arr
        
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
    
    //MARK: --->>  Dismiss Notification
    
    func dismissNotification(identifire:String){
    
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                
                if notification.identifier == "Alarm" {
                    identifiers.append(notification.identifier)
              
                }
                
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        } }
    
    
    
    //MARK: --->> Get Day Of Week
    
    
    
    
  /*  func getDayOfWeek(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    */
    
    
    
    
   func TestNoti(){
    
    let content = UNMutableNotificationContent()
    content.title = "Alarm"
    content.subtitle = "First Alarm"
    content.body = "First Alarm"
    content.sound = UNNotificationSound.default()
    content.categoryIdentifier = "alarm.category"
    content.badge = 0

    let date = Date()
    let calendar = Calendar.current
    
    var dateComponents = DateComponents()
    dateComponents.hour =  12
    dateComponents.minute = 22
    //dateComponents.second =  calendar.component(.second, from: date)
    //dateComponents.weekday = calendar.component(.weekday, from: date)
    dateComponents.day = 1
    dateComponents.month = 7
    dateComponents.year = calendar.component(.year, from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    //content.sound = UNNotificationSound.init(named: "CustomSound.mp3")
    self.addNotification(content: content, trigger: trigger , indentifier: "Alarm")

    
    
    
    
    
    
    
    
    
    }
    
   
    
    
    
    
        
        
        
    
    
    
    
    
   
    
    
    
    
    
    
}
extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    var startOfWeek: Date {
        return Calendar.gregorian.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    var nextSunday: Date {
        return Calendar.gregorian.date(byAdding: DateComponents(weekOfYear: 1), to: startOfWeek)!
    }
}

extension ASNotification{


    func getWeekDaysInEnglish() -> [String] {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        calendar.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return calendar.weekdaySymbols
    }
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarOptions: NSCalendar.Options {
            switch self {
            case .Next:
                return .matchNextTime
            case .Previous:
                return [.searchBackwards, .matchNextTime]
            }
        }
    }
    
    func get(direction: SearchDirection,date:Date, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = NSDate()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: date as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }








}
extension ASNotification{

    class Inner {
        
        weak var parent: ASNotification! = nil
        
       
    
        init() {
        
        
        
    }
        
        
        
        
}
}
 
    extension UNNotificationAttachment {
        
        static func create(identifier: String, image: UIImage, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
            let fileManager = FileManager.default
            let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
            let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
            do {
                try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
                let imageFileIdentifier = identifier+".png"
                let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
                guard let imageData = UIImagePNGRepresentation(image) else {
                    return nil
                }
                try imageData.write(to: fileURL)
                let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: options)
                return imageAttachment
            } catch {
                print("error " + error.localizedDescription)
            }
            return nil
        }
    }

