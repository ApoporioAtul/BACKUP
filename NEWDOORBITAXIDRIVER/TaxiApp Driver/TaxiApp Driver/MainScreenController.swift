//
//  MainScreenController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 19/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit
import ImageSlideshow
import CoreLocation
import GoogleMaps



class MainScreenController: UIViewController , ParsingStates , CLLocationManagerDelegate  {
    
    var data: RegisterDriver!
    var randomNumber = ""
    var city = ""
    var CITY = ""
    
    var images = [UIImage(named: "splash1")!, UIImage(named: "splash2")! ,  UIImage(named: "splash3")]
    
    var index = 0
    let animationDuration: NSTimeInterval = 0.25
    let switchingInterval: NSTimeInterval = 3
     let locationManager = CLLocationManager()
    
    let  localSource1 = [ImageSource(imageString: "splash1")!, ImageSource(imageString: "splash2")!, ImageSource(imageString: "splash3")!]
    
    var Timer:NSTimer!
    
    @IBOutlet weak var slideView: ImageSlideshow!
    @IBOutlet weak var login_btn: UIButton!
    @IBOutlet weak var register_btn: UIButton!
    @IBOutlet weak var container_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
       // locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
           
        if(NsUserDefaultManager.SingeltonInstance.isloggedin()){
            
            
              let defaultdetailstatus = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDetailStatus)!
            

            if defaultdetailstatus == "1"{
                
                APIManager.sharedInstance.delegate = self
                APIManager.sharedInstance.sendDeviceId()
                

            
                self.container_view.hidden = false
                Timer  = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(MainScreenController.myPerformeCode(_:)), userInfo: nil, repeats: false)
            
            }else{
            
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.sendDeviceId()
            
            
            
            self.container_view.hidden = true
            Timer  = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(MainScreenController.myPerformeCode1(_:)), userInfo: nil, repeats: false)
            
            }
            
        }
        else{
          
            self.container_view.hidden = false
            
            Timer  = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(MainScreenController.myPerformeCode(_:)), userInfo: nil, repeats: false)
            
           }
        
       // }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    class func getColorFromHex(hexString:String)->UIColor{
        
        var rgbValue : UInt32 = 0
        let scanner:NSScanner =  NSScanner(string: hexString)
        
        scanner.scanLocation = 1
        scanner.scanHexInt(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }

   /* @IBAction func login_as_particular_data(sender: AnyObject) {
        
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.registerDriver(randomNumber + "@gmail.com", phone: randomNumber, pass: "password", name: "testing", cartype_id: "3", carmodelId: "2", carnumber: "CH:001", cityid: "3")
       
    }*/
    
    @IBAction func register_btn(sender: AnyObject) {
        
        
            
           /* if GlobalVariables.driverLocation == "" {
                
                let alert = UIAlertController(title: "Slow Internet", message: "Location not found yet.", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}

            }
                
            else{*/
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let revealController: RegisterationController = storyboard.instantiateViewControllerWithIdentifier("RegisterationController") as! RegisterationController
            self.presentViewController(revealController, animated: true, completion: nil)
          //  }
       

    }
    
   
    @IBAction func login_btn(sender: AnyObject) {
        
                /*   if GlobalVariables.driverLocation == "" {
                
                let alert = UIAlertController(title: "Slow Internet", message: "Location not found yet.", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
                
            }
                
            else{*/
                
            
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let revealController: LoginController = storyboard.instantiateViewControllerWithIdentifier("LoginController") as! LoginController
        self.presentViewController(revealController, animated: true, completion: nil)
          // }
            
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            reverseGeocodeCoordinate(location.coordinate)
            Lat = String(location.coordinate.latitude)
            Lng = String(location.coordinate.longitude)
            //locationManager.stopUpdatingLocation()
            
        }
        
    }

    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D)  {
        
        // 1
        
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                
                //print(address.lines)
                
                GlobalVariables.driverLocation = address.addressLine1()! + " , " + address.addressLine2()!
                
               // print(GlobalVariables.driverLocation)
              //  self.city = address.locality!
              //  GlobalVariables.city = self.city
              //  print(self.city)
                             
            }
        }
    }

    
    func myPerformeCode(timer : NSTimer) {
        
        //  getCurrentAddress()
        
        Timer.invalidate()
        self.container_view.hidden = false
        
        let transition = CATransition()
        
        //transition.type = kCATransitionFade
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        container_view.layer.addAnimation(transition, forKey: kCATransition)
        
        
        
        // here code to perform
    }
    
    func myPerformeCode1(timer : NSTimer) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let revealViewController:OnLineController = storyBoard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
       // self.navigationController?.popToViewController(revealViewController, animated:true)
     //   self.navigationController(revealViewController, animated:true, completion:nil)
        self.presentViewController(revealViewController, animated:true, completion:nil)
        
       
    }
    
    func myPerformeCode2(timer : NSTimer) {
    
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: UploadDocumentsController = storyboard.instantiateViewControllerWithIdentifier("UploadDocumentsController") as! UploadDocumentsController
        self.presentViewController(next, animated: true, completion: nil)
        

    
    
    }

    
    // ************************** Success state ********************************
    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
             
    }

}
