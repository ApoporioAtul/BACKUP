//
//  ReceivePassengerController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 31/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

class ReceivePassengerController: UIViewController , ParsingStates  {
    
    var rejectdata: RideReject!
    var acceptdata: RideAccept!
    var count = 0
    var driverid = ""
    var ridedata: ViewRide!
    var helloWorldTimer: NSTimer = NSTimer()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dropAddress: UILabel!
    @IBOutlet weak var pickupAddress: UILabel!
    @IBOutlet weak var timeCircle: CircleTimer!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.viewRideInfo(GlobalVariables.rideid)
        
        driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
        
        
        self.timeCircle.totalTime = 20
        self.timeCircle.active = true
        self.timeCircle.start()
        self.timeCircle.elapsedTime = 20
        
        helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(20.0, target: self, selector: #selector(ReceivePassengerController.sayHello), userInfo: nil, repeats: false)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // ********************* On back click dismiss vc ***************************

    
    
    @IBAction func back_click(sender: AnyObject) {
        dismissViewcontroller()
    }
    
    
    // ********************* scrollView constraints ***************************

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.scrollView.bounds
        self.scrollView.contentSize.height =  350
        self.scrollView.contentSize.width = 0
    }
    
    
    // ********************* automatically reject ride after 20 sec ***************************

    
    func sayHello()
    {
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.rejectRide(GlobalVariables.rideid, driverid: driverid)
        helloWorldTimer.invalidate()
        self.timeCircle.stop()
        self.timeCircle.active = false
    }
    
    
    // *************************** Reject ride click ********************************

   
    @IBAction func reject_click(sender: AnyObject) {
        
        
      /*  self.helloWorldTimer.invalidate()
        self.timeCircle.stop()
        self.timeCircle.active = false
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.rejectRide(GlobalVariables.rideid, driverid: self.driverid)*/
        

        
        
            let refreshAlert = UIAlertController(title: "", message: NSLocalizedString("Do you want to change the status of ride ? ", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                
                    self.helloWorldTimer.invalidate()
                    self.timeCircle.stop()
                    self.timeCircle.active = false
                    APIManager.sharedInstance.delegate = self
                    APIManager.sharedInstance.rejectRide(GlobalVariables.rideid, driverid: self.driverid)
               
            }))
            
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                refreshAlert .dismissViewControllerAnimated(true, completion: nil)
                
                
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
       
    }
    
    
    // ********************* Accept ride click ***************************

    
    @IBAction func accept_click(sender: AnyObject) {
        
        
            self.timeCircle.stop()
            self.timeCircle.active = false


      /*  self.helloWorldTimer.invalidate()
        
        
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.acceptRide(GlobalVariables.rideid, driverid: self.driverid)*/
        
           let refreshAlert = UIAlertController(title: "", message: NSLocalizedString("Do you want to change the status of ride ? ", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                
                    self.helloWorldTimer.invalidate()
                    
                    
                    APIManager.sharedInstance.delegate = self
                    APIManager.sharedInstance.acceptRide(GlobalVariables.rideid, driverid: self.driverid)
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                refreshAlert .dismissViewControllerAnimated(true, completion: nil)
                
                
            }))
            
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
        
    }
    
    
    // ********************* Success state ***************************

    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        if (resultCode == 165){
            self.acceptdata = data as! RideAccept
            if(self.acceptdata.result == 1){
                
                
                GlobalVariables.driverid = (self.acceptdata.details?.driverId)!
                GlobalVariables.rideid = (self.acceptdata.details?.rideId)!
                GlobalVariables.pickupLoc = (self.acceptdata.details?.pickupLocation)!
                GlobalVariables.custId = (self.acceptdata.details?.userId)!
                GlobalVariables.pickupLat = (self.acceptdata.details?.pickupLat)!
                GlobalVariables.pickupLong = (self.acceptdata.details?.pickupLong)!
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: DirectController = storyboard.instantiateViewControllerWithIdentifier("DirectController") as! DirectController
                
                self.presentViewController(next, animated: true, completion: nil)
                
            }
        }
        
        if (resultCode == 176){
            self.rejectdata = data as! RideReject
            if(self.rejectdata.result == 1){
                
                dismissViewcontroller()
            }
        }
        
        if resultCode == 143 {
            
            self.ridedata = data as! ViewRide
            if (self.ridedata.result == 1){
                GlobalVariables.driverid = (self.ridedata.details?.driverId)!
                GlobalVariables.rideid = (self.ridedata.details?.rideId)!
                GlobalVariables.pickupLoc = (self.ridedata.details?.pickupLocation)!
                GlobalVariables.custId = (self.ridedata.details?.userId)!
                GlobalVariables.pickupLat = (self.ridedata.details?.pickupLat)!
                GlobalVariables.pickupLong = (self.ridedata.details?.pickupLong)!
                GlobalVariables.ride_status = (self.ridedata.details?.rideStatus)!
                GlobalVariables.dropLat = (self.ridedata.details?.dropLat)!
                GlobalVariables.dropLong = (self.ridedata.details?.dropLong)!
                GlobalVariables.dropLocation = (self.ridedata.details?.dropLocation)!
                
                self.pickupAddress.text = (self.ridedata.details?.pickupLocation)!
                self.dropAddress.text = (self.ridedata.details?.dropLocation)!
            }
        }
        
        
    }
    
}
