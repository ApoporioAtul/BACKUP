//
//  SplashViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 18/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON
import ImageSlideshow
import GoogleMaps
import MapKit

class SplashViewController: UIViewController,MainCategoryProtocol{
    
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var aniimageview: UIImageView!
    
   
    @IBOutlet weak var loginastestingbtn: UIButton!

    @IBOutlet weak var slideviewimage: ImageSlideshow!
    
    var CITY = ""
       
    var images = [UIImage(named: "splash1")!, UIImage(named: "splash2")! ,  UIImage(named: "splash3")]
    
    var index = 0
    let animationDuration: NSTimeInterval = 0.25
    let switchingInterval: NSTimeInterval = 3
    
   
   let  localSource1 = [ImageSource(imageString: "splash1")!, ImageSource(imageString: "splash2")!, ImageSource(imageString: "splash3")!]
    
    var Timer:NSTimer!
    
    var randomnumber = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //  getCurrentAddress()
        
        self.getCurrentAddress()
        
     /*   let number = arc4random_uniform(999999999) + 999999999;
        
        print(number)
        
        randomnumber = String(number)
        
        print(randomnumber)*/
        
        GlobalVarible.MatchStringforCancel = ""
        GlobalVarible.UserDropLocationText = NSLocalizedString("Enter Drop Location", comment: "")
        GlobalVarible.UserDropLat = 0.0
        GlobalVarible.UserDropLng = 0.0
        
      
        if(NsUserDekfaultManager.SingeltionInstance.isloggedin()){
            
             self.getCurrentAddress()
            
         let userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
            
          let UserDeviceKey = NSUserDefaults.standardUserDefaults().stringForKey("device_key")
            
                     
          ApiManager.sharedInstance.protocolmain_Catagory = self
          ApiManager.sharedInstance.UserDeviceId(userid!, USERDEVICEID: UserDeviceKey! , FLAG: "1")
            
                     
        Timer  = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(SplashViewController.myPerformeCode1(_:)), userInfo: nil, repeats: false)
            
        
            
        
        
        }
        else{
            
            
       self.getCurrentAddress()
        
         
        
         Timer  = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(SplashViewController.myPerformeCode(_:)), userInfo: nil, repeats: false)
        
        }
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
   

     
    
        func getCurrentAddress()
        {
    
    
            let locManager = CLLocationManager()
            var currentLocation = CLLocation()
    
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
                    
                    if let city = address.locality{
                        GlobalVarible.usercityname  = String(city)
                        
                    }
                    else{
                        GlobalVarible.usercityname = "Dummy City"
                        
                    }
                    

    
                
                    
                    
                }
            }
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Register(sender: AnyObject) {
      /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let registerViewController = storyBoard.instantiateViewControllerWithIdentifier("RegisterViewController") as! RegisterViewController
        self.presentViewController(registerViewController, animated:true, completion:nil)*/
        
        
    }
    
    @IBAction func Login(sender: AnyObject) {
       /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let loginViewController = storyBoard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.presentViewController(loginViewController, animated:true, completion:nil)*/
        
        
        
    }
    
    
    
   /* @IBAction func Loginastestingbtn(sender: AnyObject) {
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RegisterUser(randomnumber + "@gmail.com",PhoneNumber: randomnumber,Password: randomnumber,Name: "testing")
        
        
        
    }*/
    
    
       
    
    func myPerformeCode(timer : NSTimer) {
        
       //  getCurrentAddress()
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let revealViewController = storyBoard.instantiateViewControllerWithIdentifier("LorgeViewController") as! LorgeViewController
        
        self.presentViewController(revealViewController, animated:true, completion:nil)
        
     /*   Timer.invalidate()
        self.containerView.hidden = false
           self.loginastestingbtn.hidden = false
        
        let transition = CATransition()
        
        //transition.type = kCATransitionFade
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
       containerView.layer.addAnimation(transition, forKey: kCATransition)*/
        
        
        
        // here code to perform
    }
    
     func myPerformeCode1(timer : NSTimer) {
        
       // self.getCurrentAddress()
        
      /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let revealViewController:SWRevealViewController = storyBoard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
        
        self.presentViewController(revealViewController, animated:true, completion:nil)*/
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
        
        self.presentViewController(revealViewController, animated:true, completion:nil)

 
        
    }
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }

    
    
    
    func onProgressStatus(value: Int) {
        if(value == 0 ){
         MBProgressHUD.hideHUDForView(self.view, animated: true)
        }else if (value == 1){
            let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
            spinnerActivity.detailsLabel.text = NSLocalizedString("Please Wait!!", comment: "")
            
            spinnerActivity.userInteractionEnabled = false
        }
    }
    
    func onSuccessExecution(msg: String) {
        print("\(msg)")
    }
    
    
    func onerror(msg : String, errorCode: Int) {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
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
        }
        
    }

    
    func onSuccessParse(data: AnyObject) {
        
              
    }
 
}
