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
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().resignFirstResponder()
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
}
extension AppDelegate {
    func navigateToRespectivePage(){
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
            
                if let dict = remoteNotification as? [String:Any] {
                   if let dataDictstr = dict["gcm.notification.data"] as? String {
                       //ChatNotificationData
                       do {
                          let alertstr = try? JSONDecoder().decode([ChatNotificationData].self,from:dataDictstr.data(using:.utf8)!)
    
                           //MARK: - Messages
                           if let ride = alertstr?[0].ride as? String, ride == "newusermessage" {
                          if let message = alertstr?[0].message as? String,
                             let userid = alertstr?[0].userid as? String,
                             let driver_id = alertstr?[0].driver_id as? String
                              {
                              print(message,userid,driver_id,ride)
                              self.MoveChatScreen(DriverId: driver_id)
    
                         }
                           //MARK: - Notification FOR CHAT.........
                           } else if let userNotification = alertstr?[0].user as? String, userNotification == "future complete" || userNotification == "complete" {
                               if let str_RideIDr = alertstr?[0].str_RideIDr as? String,
                                  let str_UserIDr = alertstr?[0].str_UserIDr as? String,
                                  let str_SelectedDriverFirstNameget = alertstr?[0].str_SelectedDriverFirstNameget as? String,
                                   let str_SelectedDriverLastNameget = alertstr?[0].str_SelectedDriverLastNameget as? String,
                                  let str_SelectedDriverProfilepicget = alertstr?[0].str_SelectedDriverProfilepicget as? String
                                  
                                   {
                               self.goToUserFeedBackPage(str_RideIDr:str_RideIDr,str_UserIDr: str_UserIDr,str_SelectedDriverFirstNameget: str_SelectedDriverFirstNameget , str_SelectedDriverLastNameget: str_SelectedDriverLastNameget,str_SelectedDriverProfilepicget: str_SelectedDriverProfilepicget)
                               }
                            }
                           //MARK: - Accepted New Future.........
                           else if let userNotification = alertstr?[0].user as? String, userNotification == "newfutureride" || userNotification == "nodriver" || userNotification == "newride" {
                               self.goToUserRideHistory()
                           }
                           //MARK: - Rich Notifications.........
                           else if let userNotification = alertstr?[0].user as? String, userNotification == "richnotification" {
                               self.goToUserRichNotifications()
                           }

                      } catch  {
                          print("")
                      }
                   }
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
        
        print("tap on on forground app",userInfo)
        
        let result = userInfo as! Dictionary<String,AnyObject>
        
        print(result)
        
        let state = UIApplication.shared.applicationState
         if let dict = userInfo as? [String:Any] {
            if let dataDictstr = dict["gcm.notification.data"] as? String {
                //ChatNotificationData
                 do {
                    let alertstr = try? JSONDecoder().decode([ChatNotificationData].self,from:dataDictstr.data(using:.utf8)!)
                    
                     if let ride = alertstr?[0].ride as? String, ride == "newusermessage" {
                    if let message = alertstr?[0].message as? String,
                       let userid = alertstr?[0].userid as? String,
                       let driver_id = alertstr?[0].driver_id as? String
                        {
                     print(message,userid,driver_id,ride)
                        self.MoveChatScreen(DriverId: driver_id)
                   }
                     } else if let userNotification = alertstr?[0].user as? String, userNotification == "richnotification" {
                         print("richNotification")
                         self.goToUserRichNotifications()
                     }

                } catch  {
                    print("")
                }
            }
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
        
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
        print(UIApplication.shared.applicationState)
        let state = UIApplication.shared.applicationState
        
        if state == .background  || state == .inactive {
            
            if let dict = content.userInfo as? [String:Any] {
               if let dataDictstr = dict["gcm.notification.data"] as? String {
                   //ChatNotificationData
                    do {
                       let alertstr = try? JSONDecoder().decode([ChatNotificationData].self,from:dataDictstr.data(using:.utf8)!)
 
                        //MARK: - Messages
                        if let ride = alertstr?[0].ride as? String, ride == "newusermessage" {
                       if let message = alertstr?[0].message as? String,
                          let userid = alertstr?[0].userid as? String,
                          let driver_id = alertstr?[0].driver_id as? String
                           {
                           print(message,userid,driver_id,ride)
                           self.MoveChatScreen(DriverId: driver_id)
 
                      }
                        //MARK: - Notification FOR CHAT.........
                        } else if let userNotification = alertstr?[0].user as? String, userNotification == "future complete" || userNotification == "complete" {
                            if let str_RideIDr = alertstr?[0].str_RideIDr as? String,
                               let str_UserIDr = alertstr?[0].str_UserIDr as? String,
                               let str_SelectedDriverFirstNameget = alertstr?[0].str_SelectedDriverFirstNameget as? String,
                                let str_SelectedDriverLastNameget = alertstr?[0].str_SelectedDriverLastNameget as? String,
                               let str_SelectedDriverProfilepicget = alertstr?[0].str_SelectedDriverProfilepicget as? String
                               
                                {
                            self.goToUserFeedBackPage(str_RideIDr:str_RideIDr,str_UserIDr: str_UserIDr,str_SelectedDriverFirstNameget: str_SelectedDriverFirstNameget , str_SelectedDriverLastNameget: str_SelectedDriverLastNameget,str_SelectedDriverProfilepicget: str_SelectedDriverProfilepicget)
                            }
                         }
                        //MARK: - Accepted New Future.........
                        else if let userNotification = alertstr?[0].user as? String, userNotification == "newfutureride" || userNotification == "nodriver" || userNotification == "newride" {
                            self.goToUserRideHistory()
                        }
                        //MARK: - Rich Notifications.........
                        else if let userNotification = alertstr?[0].user as? String, userNotification == "richnotification" {
                            self.goToUserRichNotifications()
                        }

                   } catch  {
                       print("")
                   }
               }
           }
            
        }else if state == .active {


        }

        if self.window?.rootViewController?.topMostViewController() is ChatViewController {
            completionHandler([])
        } else {
            completionHandler([.alert, .badge, .sound])
        }
        
        completionHandler([.alert, .sound])
        
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


//[AnyHashable("gcm.notification.data"): [{
//"message":"bbbh",
//"userid":"701",
//"driver_id":"255",
//"ride":"newusermessage"}], AnyHashable("google.c.a.e"): 1, AnyHashable("google.c.sender.id"): 12677790788, AnyHashable("google.c.fid"): eHQT-ozhfkLDg9jW0xWaan, AnyHashable("gcm.notification.text"): bbbh, AnyHashable("gcm.message_id"): 1665204998615448, AnyHashable("aps"): {
//alert =     {
//title = "New Message";
//};
//sound = default;
//}]
func convertStringToDictionary(text: String) -> [String:AnyObject]? {
    if let data = text.data(using: .utf8) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
            return json
        } catch {
            print("Something went wrong")
        }
    }
    return nil
}

// Extension
extension AppDelegate {
    // Move to Chat Screen
    func MoveChatScreen(DriverId: String){
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let initialViewControlleripad : ChatViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        initialViewControlleripad.str_DriverID = DriverId
        initialViewControlleripad.vcCmgFrom = "AppDelegate"
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: initialViewControlleripad)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()

    }
    
    // Move to ride history
    func goToUserRideHistory() {
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let initialViewControlleripad : RideHistoryViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "RideHistoryViewController") as! RideHistoryViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: initialViewControlleripad)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }
    
    // Move to rich Notifications
    func goToUserRichNotifications() {
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let initialViewControlleripad : NotificationViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        initialViewControlleripad.vcCmgFrom = "AppDelegate"
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: initialViewControlleripad)
       
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()

    }
    
    // Move to Feed back Page
    func goToUserFeedBackPage(str_RideIDr:String,str_UserIDr: String,str_SelectedDriverFirstNameget: String , str_SelectedDriverLastNameget: String,str_SelectedDriverProfilepicget: String) {
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let nxtVC : RiseHistoryFeedBackViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "RiseHistoryFeedBackViewController") as! RiseHistoryFeedBackViewController
        nxtVC.str_ComingFrom = "RideHistory"
        nxtVC.str_RideIDr = str_RideIDr
        nxtVC.str_UserIDr = str_UserIDr
        nxtVC.str_SelectedDriverFirstNameget = str_SelectedDriverFirstNameget
        nxtVC.str_SelectedDriverLastNameget = str_SelectedDriverLastNameget
        nxtVC.str_SelectedDriverProfilepicget = str_SelectedDriverProfilepicget
        nxtVC.vcCmgFrom = "AppDelegate"
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: nxtVC)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()

    }
}
/*
 
 ["gcm.notification.text": hi, "aps": {
     alert =     {
         title = "New Message";
     };
     sound = default;
 }, "google.c.fid": e69zGq0T1UaWl0Pdi2HYLr, "google.c.sender.id": 12677790788, "google.c.a.e": 1, "gcm.message_id": 1667643059788532, "gcm.notification.data": [{
                     "message":"hi",
                     "userid":"701",
                     "driver_id":"24",
                     "ride":"newusermessage"}]]
 */
