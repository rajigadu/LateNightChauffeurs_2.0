//
//  AppDelegateExtension.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 05/10/22.
//

import Foundation
import UIKit
import IQKeyboardManager
import FirebaseCore
import Firebase
import FirebaseMessaging


extension AppDelegate {
    func setupIQKeyboardManager(){
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().resignFirstResponder()
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
}
extension AppDelegate {
    func navigateToRespectivePage(){
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

        if UserDefaults.standard.bool(forKey: "IsUserLogined") {
            moveToDashBoard()
        }else {
            MoveToLogin()
        }
    }
    
    func MoveToLogin(){
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: initialViewControlleripad)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
    }
    
    func moveToDashBoard(){
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
        
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: initialViewControlleripad)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
    }
}

extension AppDelegate : MessagingDelegate{
    
    func FireBaseAppDelegateDidFineshMethod(application : UIApplication,launchOptions : [UIApplication.LaunchOptionsKey: Any]?){
        
        // Override point for customization after application launch.
       
        Messaging.messaging().delegate = self
        
        
        handleNotificationWhenAppIsKilled(launchOptions)
         //remote Notifications
        if #available(iOS 10.0, *) {
             UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
                if err != nil {
                    //Something bad happend
                } else {
                    UNUserNotificationCenter.current().delegate = self
                    //  Messaging.messaging().delegate = self
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
         if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert], completionHandler: { (granted, error) in
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            })
        }else{
            let notificationSettings = UIUserNotificationSettings(types: [.badge,.sound,.alert], categories: nil)
            DispatchQueue.main.async {
                UIApplication.shared.registerUserNotificationSettings(notificationSettings)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    func handleNotificationWhenAppIsKilled(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        // Check if launched from the remote notification and application is close
        
        if let remoteNotification = launchOptions?[.remoteNotification] as?  [AnyHashable : Any] {
            
            let result = remoteNotification as! Dictionary<String,AnyObject>
            
            print(result)
            
            if let alert = result["type"] as? String {
                
            
        }
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    // Push Notification
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("\n\n\n\n\n ==== FCM Token:  ",fcmToken)
        UserDefaults.standard.set(fcmToken, forKey: "FCMDeviceToken")
        connectToFcm()
    }
    
   
    
    // Push Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        Messaging.messaging().delegate = self
        Messaging.messaging().appDidReceiveMessage(userInfo)
//        if userInfo[gcmMessageIDKey] {
//            print("Message ID: \(userInfo[gcmMessageIDKey])")
//        }
        
        completionHandler(UIBackgroundFetchResult.newData)
        if UIApplication.shared.applicationState == .inactive {
            completionHandler(UIBackgroundFetchResult.newData)
        } else if UIApplication.shared.applicationState == .background {
            completionHandler(UIBackgroundFetchResult.newData)
        } else if UIApplication.shared.applicationState == .active {
            completionHandler(UIBackgroundFetchResult.newData)
        } else {
            completionHandler(UIBackgroundFetchResult.newData)
        }
        
        
        let aps = userInfo["aps"] as? [AnyHashable : Any]
//        let bodyMessage = (aps?["alert"] as? NSObject)?.value(forKey: "body") as? String
//        let str_NotificationTitle = (aps?["alert"] as? NSObject)?.value(forKey: "title") as? String
//        let jsonString = userInfo.value(forKey: "gcm.notification.data") as? String
//        var aryNotificationResponse: [AnyHashable]? = nil
//        do {
//            if let JsonData = jsonString?.data(using: .utf8) {
//                aryNotificationResponse = try JSONSerialization.jsonObject(with: JsonData, options: []) as? [AnyHashable]
//            }
//        } catch {
//        }
//        let str_RideType = (aryNotificationResponse?[0] as? NSObject).value(forKey: "ride") as? String
        
//        print("tap on on forground app",userInfo)
//
//        let result = userInfo as! Dictionary<String,AnyObject>
//
//        print(result)
//
//        let state = UIApplication.shared.applicationState
//
//        if state == .background{
//
//
//        }else if state == .active {
//
//
//        }
        
       // completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
    
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print(error.localizedDescription)
        print("Not registered notification")
    }
    
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        if let refreshedToken = Messaging.messaging().fcmToken {
            print("InstanceID token: \(refreshedToken)")
            newDeviceId = refreshedToken
            print(newDeviceId)
            Messaging.messaging().apnsToken = deviceToken
            print("Token generated: ", refreshedToken)
        }
        UserDefaults.standard.set(newDeviceId, forKey:"FCMDeviceToken")
        UserDefaults.standard.synchronize()
        //        connectToFcm()
    }
    
    func connectToFcm() {
        Messaging.messaging().isAutoInitEnabled = true
      //  Messaging.messaging().shouldEstablishDirectChannel = false

        //messaging().shouldEstablishDirectChannel = true
        if let token = Messaging.messaging().fcmToken {
            print("\n\n\n\n\n\n\n\n\n\n ====== TOKEN DCS: " + token)
        }
    }
    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//
//    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

//      let dataDict:[String: String] = ["token": fcmToken ?? ""]
//      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        
        print("Firebase registration token: \(fcmToken)")
        if let fcmTokenstr = fcmToken {
        newDeviceId = fcmTokenstr
        UserDefaults.standard.set(newDeviceId, forKey:"device_id")
        UserDefaults.standard.synchronize()
        let devicetoken : String!
        devicetoken = UserDefaults.standard.string(forKey:"device_id") as String?
        print(devicetoken)
        }
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Received data message: \(remoteMessage.appData)")
//    }
    
    @available(iOS 10.0, *)
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let content = notification.request.content
        
        print("\(content.userInfo)")
        
        
        
        print("GOT A NOTIFICATION")
        
        
        let result = content.userInfo as! Dictionary<String,AnyObject>
        
        print(result)
        
        let state = UIApplication.shared.applicationState
        
        if state == .background{
            
          
            
        }else if state == .active {
            
        
        }
        
        
//        if self.window?.rootViewController?.topViewController is ConversationVC {
//            completionHandler([])
//        } else {
            completionHandler([.alert, .badge, .sound])
       // }
        
        //completionHandler([.alert, .sound])
        
    }
    
    func saveChatIDS(ChatID : String){
        let chatdata = UserDefaults.standard.value(forKey: "ChatIDArray") as? [String]
        print(chatdata)
        if chatdata?.count ?? 0 <= 0{
            var dataArray = [String]()
            dataArray.append(ChatID)
            UserDefaults.standard.setValue(dataArray, forKey: "ChatIDArray")
        }else{
            print(chatdata)
            var chatlistIds = [String]()
            chatlistIds = chatdata ?? []
            chatlistIds.append(ChatID)
            UserDefaults.standard.setValue(chatlistIds, forKey: "ChatIDArray")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "IGotChatMSG"), object: nil,userInfo: ["ChatID" : ChatID])
    }
  
  
    
    
    func alerfunc(msg : String){
        let alert = UIAlertController(title: kApptitle, message:msg, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
