//
//  NotificationsHandler.swift
//  PlainSwiftFramework
//
//  Created by apple on 12/13/15.
//  Copyright © 2015 maheshbabu.somineni. All rights reserved.
//

import UIKit

class NotificationsHandler: NSObject {

    class func addNotification(dictionary:AnyObject) {
     
        let localNotification = UILocalNotification() // Creating an instance of the notification.
        localNotification.alertTitle = GlobalVariables.appName
        
        if let body = dictionary.valueForKey("note"){
            localNotification.alertBody = body as? String
        }
        localNotification.alertAction = "ShowDetails"
        localNotification.fireDate = NSDate().dateByAddingTimeInterval(60*1) // 5 minutes(60 sec * 5) from now
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.soundName = UILocalNotificationDefaultSoundName // Use the default notification tone/ specify a file in the application bundle
        localNotification.category = "Personal" // Category to use the specified actions
    
        //Setting primary key
        if let objectId = dictionary.objectForKey("objectId") as? String{
            
            let infoDict :  Dictionary<String,String!> = ["objectId" :objectId]
            localNotification.userInfo = infoDict;
        }
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification) // Scheduling the notification.
    }
    class func updateNotification() {
    
    }
    class func cancelNotification(objectId:String) {
    
        let app:UIApplication = UIApplication.sharedApplication()
        for event in app.scheduledLocalNotifications! {
            
            let notification = event
            var infoDict :  Dictionary = notification.userInfo as! Dictionary<String,String!>
           
            let notifcationObjectId : String = infoDict["objectId"]!
            if notifcationObjectId == objectId {
                app.cancelLocalNotification(notification)
            }
        }
    }
}
