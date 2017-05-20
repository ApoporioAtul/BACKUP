//
//  SignOutDialogController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit
import Firebase

class SignOutDialogController: UIViewController , ParsingStates {
    
    var data: LogOut!
    var driverid: String = ""
    var OnOffData: OnLineOffline!
    
    
     var ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var yes_btn: UIButton!
    @IBOutlet weak var no_btn: UIButton!
    
    var defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
    
   
    
    var onoffstatus = "2"
    
    var drivername = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDrivername)!
    
    var driveremail = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverEmail)!
    
    var driverphone = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyPhoneno)!
    
    var driverdeviceid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDeviceId)!
    
    var driverimage = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverImage)!
    var driverpassword = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyPassword)!
    var driverflag = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyFlag)!
    
    var drivercartypename = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarName)!
    
    var drivercarmodelname = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarModelName)!
    
    var drivercarno = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarNo)!
    
    var drivercityid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCityId)!
    
    var drivermodelid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarModelid)!
    
    
    var loginlogoutstatus = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyLoginLogout)!
    
    
    var cartypeid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarType)!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        yes_btn.layer.cornerRadius = 5
        no_btn.layer.cornerRadius = 5
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // ********************* no button click for log out ***************************

    
        @IBAction func no_pressed(sender: AnyObject) {
            
            dismissViewcontroller()
        }
    
    
     // ********************* yes button click for log out ***************************
    
    
    @IBAction func yes_pressed(sender: AnyObject) {
        
        
         //   NsUserDefaultManager.SingeltonInstance.logOut()
            print("data deleted")
            
            let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message:NSLocalizedString(" LogOut Successfully ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
                APIManager.sharedInstance.goOnline(self.driverid, onlineOffline: "2",driverToken: self.defaultdrivertoken)
                
                APIManager.sharedInstance.delegate = self
                APIManager.sharedInstance.logOut(self.driverid)
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
        
    }
    
    
    // ********************* Success state ***************************

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        if resultCode == 187{
            self.data = data as! LogOut
            
            
            if(self.data.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
                
            }else if(self.data.result == 1){
                
                
              
                
                let Message: NSDictionary = ["driver_id": self.driverid , "driver_name": self.drivername , "driver_phone": self.driverphone , "driver_email": self.driveremail , "driver_image": self.driverimage , "driver_password": self.driverpassword , "driver_token": self.defaultdrivertoken , "driver_device_id": self.driverdeviceid , "driver_flag": self.driverflag,"driver_rating": "" ,"driver_car_type_id": self.cartypeid ,"driver_model_id": self.drivermodelid ,"driver_number": self.drivercarno , "driver_city_id": self.drivercityid ,"driver_registration_date": "" ,"driver_lisence": "" ,"driver_rc": "" ,"driver_insurence": "" ,"driver_other_doc": "" ,"driver_last_update": "" ,"driver_last_update_date": "" ,"driver_completed_rides": "" ,"driver_rejected_rides": "" ,"driver_cancelled_rides": "" ,"driver_login_logout": "2" ,"driver_busy_status": "" ,"driver_online_offline_status": self.onoffstatus ,"driver_detail_status": "" ,"driver_admin_status": "" ,"driver_car_type_name": self.drivercartypename ,"driver_car_model_name": self.drivercarmodelname ,"driver_current_latitude": Lat ,"driver_current_longitude": Lng ,"driver_location_text": GlobalVariables.driverLocation ,"timestamp": "","bearingfactor": "0.0"]
                
                self.ref.child("Drivers_A").child(self.driverid).setValue(Message)

                                
                   NsUserDefaultManager.SingeltonInstance.logOut()
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
            }
        }
        
        if resultCode == 88 {
            self.OnOffData = data as! OnLineOffline
        }
        
        
    }

    
    
}