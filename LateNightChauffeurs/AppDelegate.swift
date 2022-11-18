//
//  AppDelegate.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 07/09/22.
// com.AnaadITSolutions.LateNightChauffeurs

import UIKit
import CoreData
import GooglePlaces
import GoogleMaps
import FirebaseCore
import Firebase
import FirebaseMessaging
import SideMenu
var LognedUserType = ""
var newDeviceId = ""
var inServerSavedDeviceId = ""
var GOOGLE_API_KEY = "AIzaSyAK7N4kOTSAWpSlzoOQk9_dKp9Sci2sshY"
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0);
    lazy var viewModel = {
        DashBoardViewModel()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppUpdater.shared.showUpdate(withConfirmation: false)
        setupIQKeyboardManager()
        FirebaseApp.configure()
        self.FireBaseAppDelegateDidFineshMethod(application : application, launchOptions: launchOptions)
 
        navigateToRespectivePage()
        if let GoogleKey = UserDefaults.standard.string(forKey: "Googlekeyvalue") as? String {
            GOOGLE_API_KEY = GoogleKey
        } else {
            self.getgooglekeyListAPI()
        }
        
        if GOOGLE_API_KEY != "" {
            GMSServices.provideAPIKey(GOOGLE_API_KEY)
            GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppUpdater.shared.showUpdate(withConfirmation: false)
    }
    

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentCloudKitContainer(name: "LateNightChauffeurs")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension AppDelegate {
    //MARk: -- API REQUEST CLASS DELEGATE
    //MARK: - request for Google Key
    func getgooglekeyListAPI() {
        indicator.showActivityIndicator()
        self.viewModel.requestForgetgooglekeyListAPIServices(perams: ["":""]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        UserDefaults.standard.set(UserData.data?.key ?? "", forKey: "Googlekeyvalue")
                        GOOGLE_API_KEY = UserData.data?.key ?? ""
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                   // self.showToast(message: error ?? "no record found.", font: .systemFont(ofSize: 12.0))
                }
            }
        }
    }
}


