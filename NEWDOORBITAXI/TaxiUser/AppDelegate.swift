//
//  AppDelegate.swift
//  TaxiApp
//
//  Created by AppOrio on 17/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import Stripe
import Fabric
import DigitsKit
import Crashlytics
import Firebase





@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate,MainCategoryProtocol {

    var window: UIWindow?
    var part1: String = ""
    var part2: String = ""
    var part3: String = ""
    var mydata: DriverInfo!
    
    var customersyncdata: CustomerSyncModel!
    
    var locationManager = CLLocationManager()
    
  //  var kClient = "488082975872-h2g3m1cus9rd7fv1nipvp822dg04r6lr.apps.googleusercontent.com"
    
    var kClient = "620389858298-rq76rq9tvrh9ignq05p56c35f00ilndi.apps.googleusercontent.com"
    
    
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
        default:
            break
        }
    }
    
    func getCurrentAddress()
    {
        
        
        let locManager = CLLocationManager()
        // var currentLocation = CLLocation()
        
         locManager.requestAlwaysAuthorization()
        
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
            
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
                let lines = address.lines! as [String]
                GlobalVarible.PickUpLat  = String(coordinate.latitude)
                GlobalVarible.PickUpLng = String(coordinate.longitude)
                
                if let city = address.locality{
                    GlobalVarible.usercityname  = String(city)
                    
                }
                else{
                    GlobalVarible.usercityname = "Dummy City"
                    
                }
                
                
                
                
                
            }
        }
    }
    
    



    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
      //  let device_id = UIDevice.currentDevice().identifierForVendor?.UUIDString
        
      //  NSUserDefaults.standardUserDefaults().setObject(device_id, forKey: "DeviceId")
        
        locationManager.delegate = self
        
        Fabric.with([Digits.self])
        
        Fabric.with([Crashlytics.self])

        
          FIRApp.configure()
        
         GMSServices.provideAPIKey("AIzaSyC8J9saj7enSdCNz50CFgavWlrbNiI3mUA")
        
        PayPalMobile.initializeWithClientIdsForEnvironments([PayPalEnvironmentProduction: "AbRpAa0ZOX95Zczg8FTE9zUfH63kZ8mRwljpwikUMZcTZUMYksdNph8f0vIHia3jGZByTQGZw3xA0Tqh"])
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        
        IQKeyboardManager.sharedManager().enable = true
        
         Stripe.setDefaultPublishableKey("pk_test_529XQobaN0Aa8VMJpqYFdT2n")
        
        
        let langId = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as! String
        
        print("Preferred language: \(langId)")
      
        NSUserDefaults.standardUserDefaults().setObject(langId, forKey: "PreferredLanguage")
        
        
        GIDSignIn.sharedInstance().clientID = kClient
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        
       // self.getNetworkType()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions) || true
        
        
      // return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
         GlobalVarible.k = 1
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()

    }
    
    
      
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        print(url)
        
        let googleDidHandle = GIDSignIn.sharedInstance().handleURL(url,
                                                                   sourceApplication: sourceApplication,
                                                                   annotation: annotation)
        
        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        return googleDidHandle || facebookDidHandle
        
        
        //        print(sourceApplication)
        //        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        //return true
    }
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
       // print("Notifications status: \(notificationSettings)")
        
        if notificationSettings.types == UIUserNotificationType(rawValue: 0){
            print(notificationSettings.types)
            
            GlobalVarible.notificationvalue = 1
            
            let deviceTokenValue = "7eba6f12589ea1d618359dc10d5633e031aae26a50023e531f712659975a7013"
            
            NSUserDefaults.standardUserDefaults().setValue(deviceTokenValue, forKey:"device_key")
            //  self.showalert2("Please first turn on Notification from Settings.")
            
            
        }else{
            print(notificationSettings.types)
            
            GlobalVarible.notificationvalue = 0
        }
        
        
    }

    
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        let deviceTokenValue : String? = deviceToken.description.componentsSeparatedByCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet).joinWithSeparator("")
        
         GlobalVarible.notificationvalue = 0
        print(deviceTokenValue)
       // let device_id = UIDevice.currentDevice().identifierForVendor?.UUIDString
        
      //  NSUserDefaults.standardUserDefaults().setObject(device_id, forKey: "DeviceId")
        
        NSUserDefaults.standardUserDefaults().setValue(deviceTokenValue!, forKey:"device_key")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if  GlobalVarible.afterallownotificationsetting == 1{
            
            let userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
            
            let UserDeviceKey = NSUserDefaults.standardUserDefaults().stringForKey("device_key")
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.UserDeviceId(userid!, USERDEVICEID: UserDeviceKey! , FLAG: "1")
            
            
            
            
        }else{
            
        }
        

    }
    
    
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("grabing notification message inside app delegate \(userInfo)" )
        
     //  NSNotificationCenter.defaultCenter().postNotificationName("hide", object: nil, userInfo: userInfo)
        
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

                
                
            }
        }

        
        if ( application.applicationState == UIApplicationState.Inactive || application.applicationState == UIApplicationState.Background  || application.applicationState == UIApplicationState.Active )
         {
        
                     
            if(part3 == "3"){
               
              
                NSNotificationCenter.defaultCenter().postNotificationName("hide", object: nil, userInfo: userInfo)
                
                
            }
            
            if(part3 == "4"){
               
                NSNotificationCenter.defaultCenter().postNotificationName("hide", object: nil, userInfo: userInfo)
                
            }
            
            if(part3 == "5"){
             //   NSNotificationCenter.defaultCenter().postNotificationName("hide1", object: nil, userInfo: userInfo)
                let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.customerSync1(part2, UserId: Userid!)
                

                
          
                
            }
            
            if(part3 == "6"){
                
               
                //   NSNotificationCenter.defaultCenter().postNotificationName("hide1", object: nil, userInfo: userInfo)
                
                 let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.customerSync1(part2, UserId: Userid!)
                

                
            }
            

            
            
            if(part3 == "7"){
                
                
                let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.customerSyncEnd(part2, UserId: Userid!)
                

                
               
           
            }
            
            
            
            
            if(part3 == "9"){
                
                let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.customerSync1(part2, UserId: Userid!)
                

                
              //  self.showalert1("Your Ride Cancel by Driver!!")
                
                
                
                
            }


        }
       
        
        
 
    }
   
    
    
    
    func showalert1(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "Alert", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "ok", style: .Default) { (action) in
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: NewMapViewController = storyboard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
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

    
    
    func onProgressStatus(value: Int) {
        if(value == 0 ){
          //  MBProgressHUD.hideHUDForView(self.view, animated: true)
            
        }else if (value == 1){
           /* let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
            spinnerActivity.detailsLabel.text = NSLocalizedString("Please Wait!!", comment: "")
            
            spinnerActivity.userInteractionEnabled = false*/
            
            
        }
    }
    
    func onSuccessExecution(msg: String) {
        print("msg")
        
    }
    
    
    func onerror(msg : String, errorCode: Int) {
      /*  MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        if(errorCode == -1009)
            
        {
            
            self.showalert(NSLocalizedString("The Internet connection appears to be offline", comment: ""))
            
        }
            
        else if(errorCode == -1003)
        {
            self.showalert( NSLocalizedString("A server with the specified hostname could not be found.", comment: ""))
            
        }
            
        else {
            
            self.showalert(NSLocalizedString("The Internet connection appears to be slow", comment: ""))
        }*/
        
    }
    
    func onSuccessParse(data: AnyObject) {
        
         if(GlobalVarible.Api == "customersync"){
        
        customersyncdata = data as! CustomerSyncModel
        
        if(customersyncdata.result == 0){
            
             self.showalert1("Your Notification has been expired!!")
            
                       
        }else
        {
            if(customersyncdata.details?.rideStatus == "5"){
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: TrackRideViewController = storyboard.instantiateViewControllerWithIdentifier("TrackRideViewController") as! TrackRideViewController
                
                nextController.Currentrideid = self.part2
                nextController.currentStatus = self.part3
                nextController.currentmessage = self.part1
                
                
                var presentedVC = self.window?.rootViewController
                
                while (presentedVC!.presentedViewController != nil)  {
                    presentedVC = presentedVC!.presentedViewController
                }
                presentedVC!.presentViewController(nextController, animated: true, completion: nil)
                

                
            }
            
            if(customersyncdata.details?.rideStatus == "6"){
                
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextController: TrackRideViewController = storyboard.instantiateViewControllerWithIdentifier("TrackRideViewController") as! TrackRideViewController
                
                nextController.Currentrideid = self.part2
                nextController.currentStatus = self.part3
                nextController.currentmessage = self.part1
                
                
                var presentedVC = self.window?.rootViewController
                
                while (presentedVC!.presentedViewController != nil)  {
                    presentedVC = presentedVC!.presentedViewController
                }
                presentedVC!.presentViewController(nextController, animated: true, completion: nil)
                
                

            }
            
            if(customersyncdata.details?.rideStatus == "9"){
                
                
                self.showalert1("Your Ride Cancel by Driver!!")
            }

        }
        
        }
        
         if(GlobalVarible.Api == "customersyncend"){
            
            customersyncdata = data as! CustomerSyncModel
            
            if(customersyncdata.result == 0){
                
                self.showalert1("Your Notification has been expired!!")
                
                
            }else
            {
                if(customersyncdata.details?.rideStatus == "7"){
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextController: RatingViewController = storyboard.instantiateViewControllerWithIdentifier("RatingViewController") as! RatingViewController
                    
                    nextController.currentrideid = self.part2
                    
                    
                    var presentedVC = self.window?.rootViewController
                    
                    while (presentedVC!.presentedViewController != nil)  {
                        presentedVC = presentedVC!.presentedViewController
                    }
                    presentedVC!.presentViewController(nextController, animated: true, completion: nil)
                    
                }
            }
        }

    }
}

