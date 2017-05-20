//
//  AppDelegate.swift
//  TaxiApp Driver
//
//  Created by Rakesh kumar on 19/12/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import IQKeyboardManagerSwift
import AVFoundation
import Fabric
import Crashlytics
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , CLLocationManagerDelegate,ParsingStates{

    var window: UIWindow?
    var part1: String = ""
    var part2: String = ""
    var part3: String = ""
    
    var driversyncdata: DriverSyncModel!
    
    var storyboard: UIStoryboard = UIStoryboard()
    
     var deviceTokenValue = "7eba6f12589ea1d618359dc10d5633e031aae26a50023e531f712659975a7013"
    
    var locationManager = CLLocationManager()
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            // If status has not yet been determied, ask for authorization
            self.getCurrentAddress()
            manager.requestWhenInUseAuthorization()
            break
        case .AuthorizedWhenInUse:
            // If authorized when in use
            self.getCurrentAddress()
            manager.startUpdatingLocation()
            break
        case .AuthorizedAlways:
            // If always authorized
            self.getCurrentAddress()
            manager.startUpdatingLocation()
            break
        case .Restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .Denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        
        }
    }
    
    func getCurrentAddress()
    {
        
        
        let locManager = CLLocationManager()
        // var currentLocation = CLLocation()
        
        // locManager.requestWhenInUseAuthorization()
        
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            
            if let   currentLocation = locManager.location
            {
                
                
                reverseGeocodeCoordinate(currentLocation.coordinate)
                
            }
            
        }
    }
    
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D)  {
        
        // 1
        
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                
                //  print(address.lines)
               // let lines = address.lines! as! [String]
                
                
                if let city = address.locality{
                    GlobalVariables.city  = String(city)
                    
                }
                else{
                    GlobalVariables.city = ""
                    
                }
                
                
            }
        }
    }
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyA076UOAlIl7s4QoI_KBUPBhoN7wmYHAeI")
        IQKeyboardManager.sharedManager().enable = true
        
        Fabric.with([Crashlytics.self])
        
        let langId = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
        
        print("Preferred language: \(langId)")
        
        NSUserDefaults.standardUserDefaults().setObject(langId, forKey: "PreferredLanguage")
        
         FIRApp.configure()
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        return true
        
    }
    


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
     let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        let  driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!

        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.goOnline(driverid, onlineOffline: "2",driverToken: defaultdrivertoken)
        
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Apporio.TaxiApp_Driver" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("TaxiApp_Driver", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        // print("Notifications status: \(notificationSettings)")
        
        if notificationSettings.types == UIUserNotificationType(rawValue: 0){
            print(notificationSettings.types)
            
            
            self.showalert2("Please first turn on Notification from Settings.")
            
            
        }else{
            print(notificationSettings.types)
            
        }
        
        
    }
    
    


    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("DEVICE TOKEN = \(deviceToken)")
        
        if let  deviceTokenValue1: String?  = deviceToken.description.componentsSeparatedByCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet).joinWithSeparator("") {
            deviceTokenValue = deviceTokenValue1!
            print(deviceTokenValue1!)
        }
        
        
        print("DEVICE TOKEN new = \(deviceTokenValue)")
        GlobalVariables.deviceid = deviceTokenValue
        
        print(deviceTokenValue)
        
        NSUserDefaults.standardUserDefaults().setValue(deviceTokenValue, forKey:"device_key")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    

    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
        
       NSUserDefaults.standardUserDefaults().setValue("sjyiu454vfgdddg2465", forKey:"device_key")
        
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("grabing notification message inside app delegate \(userInfo)" )
        
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let message = alert["message"] as? NSString {
                    //Do stuff
                    print(message)
                }
            } else if let alert = aps["alert"] as? NSString {
                //Do stuff
                print(alert)
                
                print(aps["ride_id"])
                print(aps["ride_status"])
                
                part1 = alert as String
                print("Part 1: \(part1)")
              // let part4 = aps["ride_id"] as! Int
                
               //  part2 = String(part4)
              part2 = aps["ride_id"] as! String
                print("Part 2: \(part2)")
                
                part3 = aps["ride_status"] as! String
                print("Part 3: \(part3)")
                
                
                
               
                if ( application.applicationState == UIApplicationState.Inactive || application.applicationState == UIApplicationState.Background  || application.applicationState == UIApplicationState.Active )
                {
                    //opened from a push notification when the app was on background
                    
                      AudioServicesPlaySystemSound(1005);
                    
                    if(part3 == "1"){
                        
                       let driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
                        
                        GlobalVariables.rideid = part2
                        
                        APIManager.sharedInstance.delegate = self
                        APIManager.sharedInstance.DriverSync(part2, DriverId: driverid)
                        
                        
                        
                    }
                    
                    if(part3 == "2"){
                        GlobalVariables.rideid = part2
                        
                         let driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
                        
                        APIManager.sharedInstance.delegate = self
                        APIManager.sharedInstance.DriverSync(part2, DriverId: driverid)

                        
                      //  self.showalert("Ride has been cancelled by user")
                    }
                    
                    
                    if(part3 == "8"){
                        
                        let driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
                        
                        GlobalVariables.rideid = part2
                        
                        APIManager.sharedInstance.delegate = self
                        APIManager.sharedInstance.DriverSync(part2, DriverId: driverid)
                        
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        
    }
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "Cancelled", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "ok", style: .Default) { (action) in
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: OnLineController = storyboard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
                var presentedVC = self.window?.rootViewController
                while (presentedVC!.presentedViewController != nil)  {
                    presentedVC = presentedVC!.presentedViewController
                }
                presentedVC!.presentViewController(nextController, animated: true, completion: nil)
                
            }
            alertController.addAction(OKAction)
            var presentedVC = self.window?.rootViewController
            while (presentedVC!.presentedViewController != nil)  {
                presentedVC = presentedVC!.presentedViewController
            }
            presentedVC!.presentViewController(alertController, animated: true){
                
                
                //self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
        
        
    }
    
    
    
    func showalert1(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "Alert", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "ok", style: .Default) { (action) in
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: OnLineController = storyboard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
                var presentedVC = self.window?.rootViewController
                while (presentedVC!.presentedViewController != nil)  {
                    presentedVC = presentedVC!.presentedViewController
                }
                presentedVC!.presentViewController(nextController, animated: true, completion: nil)
                
                
                
            }
            alertController.addAction(OKAction)
            
            var presentedVC = self.window?.rootViewController
            
            while (presentedVC!.presentedViewController != nil)  {
                presentedVC = presentedVC!.presentedViewController
            }
            
            presentedVC!.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    func showalert2(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "Allow Notification", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
            }
            alertController.addAction(OKAction)
            
            var presentedVC = self.window?.rootViewController
            
            while (presentedVC!.presentedViewController != nil)  {
                presentedVC = presentedVC!.presentedViewController
            }
            
            presentedVC!.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    

    

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
    
        if resultCode == 2006 {
            
            driversyncdata = data as! DriverSyncModel
            
            if(driversyncdata.result == 0){
                
                self.showalert1("Your Notification has been expired!!")
                
                
            }else
            {
                if(driversyncdata.details?.rideStatus == "1"){
                    
                    print("Ride Id \(GlobalVariables.rideid)")
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: ReceivePassengerController = storyboard.instantiateViewControllerWithIdentifier("ReceivePassengerController") as! ReceivePassengerController
                    var presentedVC = self.window?.rootViewController
                    while (presentedVC!.presentedViewController != nil)  {
                        presentedVC = presentedVC!.presentedViewController
                    }
                    presentedVC!.presentViewController(nextController, animated: true, completion: nil)
                    

                }
                
                if(driversyncdata.details?.rideStatus == "8"){
                    
                    print("Ride Id \(GlobalVariables.rideid)")
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: ReceivePassengerController = storyboard.instantiateViewControllerWithIdentifier("ReceivePassengerController") as! ReceivePassengerController
                    var presentedVC = self.window?.rootViewController
                    while (presentedVC!.presentedViewController != nil)  {
                        presentedVC = presentedVC!.presentedViewController
                    }
                    presentedVC!.presentViewController(nextController, animated: true, completion: nil)
                    
                    
                }

                
              if(driversyncdata.details?.rideStatus == "2"){
                
                self.showalert("Ride has been cancelled by user")
                }
                
                

            }
        
        
        }
    
    }

}

