//
//  FullDetailsViewController.swift
//  TaxiApp Driver
//
//  Created by AppOrio on 07/02/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit
import StarryStars

class FullDetailsViewController: UIViewController,ParsingStates {
    
    
    @IBOutlet weak var showdatetimelabel: UILabel!
    
    var mydatapage: ViewRide!
    
    var ridestausvalue = ""
    var datetimedata = ""
    var rideid = ""
    
    var currentstatusvalue = ""
    
     let imageUrl = API_URLs.imagedomain
    
    
    @IBOutlet weak var completestatusview: UIView!
    
    
    @IBOutlet weak var completestatusbottomview: UIView!
    
    @IBOutlet weak var completecustomerimage: UIImageView!
    
    @IBOutlet weak var completeratingview: RatingView!
    
    @IBOutlet weak var completecustomername: UILabel!
    
 //   @IBOutlet weak var completecarimage: UIImageView!
    
  //  @IBOutlet weak var completecarname: UILabel!

    @IBOutlet weak var completeprice: UILabel!
    
    @IBOutlet weak var completedistance: UILabel!
    
    @IBOutlet weak var completetime: UILabel!
    
    @IBOutlet weak var completepickuplocation: UILabel!
    
    @IBOutlet weak var completedroplocation: UILabel!
    
    @IBOutlet weak var completetotalprice: UILabel!
    
    
    
    //************************************
    
    
    @IBOutlet weak var Acceptedstatusview: UIView!
    
    @IBOutlet weak var Acceptedcustomerimage: UIImageView!
    
    @IBOutlet weak var Acceptedcustomername: UILabel!
    
    
    @IBOutlet weak var Acceptedratingview: RatingView!
    
    
  //  @IBOutlet weak var Acceptedcarimage: UIImageView!
    
    
  //  @IBOutlet weak var Acceptedcarname: UILabel!
    
    @IBOutlet weak var Acceptedpickuplocation: UILabel!
    
    @IBOutlet weak var Accepteddroplocation: UILabel!
    
    
    
    //*******************************************
    
    
 /*   @IBOutlet weak var ridelaterstatusview: UIView!
    
    @IBOutlet weak var ridelaterpickuplocation: UILabel!
    
    @IBOutlet weak var ridelaterdroplocation: UILabel!*/
    
    
    
    //**********************
    @IBOutlet weak var scheduleview: UIView!
    
  /*  @IBOutlet weak var ridelaterview: UIView!
    
    @IBOutlet weak var driveracceptedview: UIView!
    
    @IBOutlet weak var driverarrivedview: UIView!
    
    @IBOutlet weak var cancelrideview: UIView!*/
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        showdatetimelabel.text = datetimedata
        
      
        GlobalVariables.cancelbtnvaluematch = "2"
        
        completeratingview.userInteractionEnabled = false
        Acceptedratingview.userInteractionEnabled = false

        
        if ridestausvalue == "7" {
            completestatusview.hidden = false
          //  ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = true
            completestatusbottomview.hidden = false
            scheduleview.hidden = true
           // ridelaterview.hidden = true
           // driveracceptedview.hidden = true
           // driverarrivedview.hidden = true
           // cancelrideview.hidden = true
            
        }
        
        if ridestausvalue == "1" {
            
            completestatusview.hidden = true
         //   ridelaterstatusview.hidden = false
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = true
            scheduleview.hidden = false
//            ridelaterview.hidden = false
//            driveracceptedview.hidden = true
//            driverarrivedview.hidden = true
//            cancelrideview.hidden = true
            
            
        }
        
        if ridestausvalue == "2" {
            
            completestatusview.hidden = true
          //  ridelaterstatusview.hidden = false
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = false
            scheduleview.hidden = true
            
         /*   ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
            cancelrideview.hidden = false*/
            
            
        }
        
        if ridestausvalue == "6" {
            
            completestatusview.hidden = true
          //  ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = true
            scheduleview.hidden = false
          /*  ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = false
            cancelrideview.hidden = true*/
            
            
        }
        
        if ridestausvalue == "4" {
            
            completestatusview.hidden = true
          //  ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = false
            scheduleview.hidden = true
        /*    ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
            cancelrideview.hidden = false*/
            
            
        }
        
        if ridestausvalue == "5" {
            
            completestatusview.hidden = true
         //   ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = false
            scheduleview.hidden = false
           /* ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = false
            cancelrideview.hidden = true*/
            
            
        }
        
        if ridestausvalue == "3" {
            
            completestatusview.hidden = true
          //  ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = true
            scheduleview.hidden = false
            
          /*  ridelaterview.hidden = true
            driveracceptedview.hidden = false
            driverarrivedview.hidden = true
            cancelrideview.hidden = true*/
            
            
        }
        
        if ridestausvalue == "8" {
        
            completestatusview.hidden = true
            //  ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = false
            scheduleview.hidden = true
        }
        
        if ridestausvalue == "9" {
        
            completestatusview.hidden = true
            //  ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = false
            scheduleview.hidden = true
        
        }
        
        
       APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.viewRideInfo(rideid)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func canceldriverbtn(sender: AnyObject) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewControllerWithIdentifier("ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)
        
        
        
        
    }
    
    @IBAction func calluserbtn(sender: AnyObject) {
        if(currentstatusvalue == "3"){
            
            
            GlobalVariables.driverid = (self.mydatapage.details?.driverId)!
            GlobalVariables.rideid = (self.mydatapage.details?.rideId)!
            GlobalVariables.pickupLoc = (self.mydatapage.details?.pickupLocation)!
            GlobalVariables.custId = (self.mydatapage.details?.userId)!
            GlobalVariables.pickupLat = (self.mydatapage.details?.pickupLat)!
            GlobalVariables.pickupLong = (self.mydatapage.details?.pickupLong)!
            GlobalVariables.dropLat = (self.mydatapage.details?.dropLat)!
            GlobalVariables.dropLong = (self.mydatapage.details?.dropLong)!
            GlobalVariables.dropLocation = (self.mydatapage.details?.dropLocation)!
            GlobalVariables.ridecurrentstatus = (self.mydatapage.details?.rideStatus)!
        
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: DirectController = storyboard.instantiateViewControllerWithIdentifier("DirectController") as! DirectController
            
            self.presentViewController(next, animated: true, completion: nil)

        
        
        }
        
        if(currentstatusvalue == "5"){
            
            GlobalVariables.driverid = (self.mydatapage.details?.driverId)!
            GlobalVariables.rideid = (self.mydatapage.details?.rideId)!
            GlobalVariables.pickupLoc = (self.mydatapage.details?.pickupLocation)!
            GlobalVariables.custId = (self.mydatapage.details?.userId)!
            GlobalVariables.pickupLat = (self.mydatapage.details?.pickupLat)!
            GlobalVariables.pickupLong = (self.mydatapage.details?.pickupLong)!
            GlobalVariables.dropLat = (self.mydatapage.details?.dropLat)!
            GlobalVariables.dropLong = (self.mydatapage.details?.dropLong)!
            GlobalVariables.dropLocation = (self.mydatapage.details?.dropLocation)!
            GlobalVariables.ridecurrentstatus = (self.mydatapage.details?.rideStatus)!

        
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: DirectionController = storyboard.instantiateViewControllerWithIdentifier("DirectionController") as! DirectionController
            
            self.presentViewController(next, animated: true, completion: nil)
        
        }
        
        if(currentstatusvalue == "6"){
            
            GlobalVariables.driverid = (self.mydatapage.details?.driverId)!
            GlobalVariables.rideid = (self.mydatapage.details?.rideId)!
            GlobalVariables.pickupLoc = (self.mydatapage.details?.pickupLocation)!
            GlobalVariables.custId = (self.mydatapage.details?.userId)!
            GlobalVariables.pickupLat = (self.mydatapage.details?.pickupLat)!
            GlobalVariables.pickupLong = (self.mydatapage.details?.pickupLong)!
            GlobalVariables.dropLat = (self.mydatapage.details?.dropLat)!
            GlobalVariables.dropLong = (self.mydatapage.details?.dropLong)!
            GlobalVariables.dropLocation = (self.mydatapage.details?.dropLocation)!
            GlobalVariables.ridecurrentstatus = (self.mydatapage.details?.rideStatus)!

            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: DirectionController = storyboard.instantiateViewControllerWithIdentifier("DirectionController") as! DirectionController
            
            self.presentViewController(next, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    
    @IBAction func backbtn(sender: AnyObject) {
        dismissViewcontroller()
    }
    
    

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        
        mydatapage = data as! ViewRide
        
        if(mydatapage.result == 1){
            
            completepickuplocation.text = mydatapage.details!.beginLocation
            Acceptedpickuplocation.text = mydatapage.details?.pickupLocation
          //  ridelaterpickuplocation.text = mydatapage.details?.pickupLocation
          //  ridelaterdroplocation.text = mydatapage.details?.dropLocation
            
            
            completedroplocation.text  = mydatapage.details!.endLocation
            Accepteddroplocation.text = mydatapage.details?.dropLocation
            
           /* let driverratingvalue = mydatapage.details?.
            
            if driverratingvalue == ""{
                print("hjjk")
            }else{
                
                completeratingview.rating = Float(driverratingvalue!)!
                Acceptedratingview.rating = Float(driverratingvalue!)!
            }
            */
            
          currentstatusvalue = (mydatapage.details?.rideStatus)!
            
            print(currentstatusvalue)
            
            completeprice.text = "LKR " + (mydatapage.details?.amount)!
            
            completedistance.text = (mydatapage.details?.distance)! + " Kms"
            
            completetime.text = mydatapage.details?.time
            
            
            
            completetotalprice.text = "LKR " + (mydatapage.details?.amount)!
            
            
            completecustomername.text = "  " + mydatapage.details!.userName!
            Acceptedcustomername.text = "  " + mydatapage.details!.userName!
            
            
            let driverratingvalue = mydatapage.details!.rating
            
            if driverratingvalue == ""{
                print("hjjk")
            }else{
                
                completeratingview.rating = Float(driverratingvalue!)!
                Acceptedratingview.rating = Float(driverratingvalue!)!
            }

            
            
            let drivertypeimage = mydatapage.details!.userImage
            
            print(drivertypeimage!)
            
            if(drivertypeimage == ""){
                completecustomerimage.image = UIImage(named: "profileeee") as UIImage?
                Acceptedcustomerimage.image = UIImage(named: "profileeee") as UIImage?
                print("No Image")
            }else{
                
                
               // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
               // print(url)
                
                let url = imageUrl + drivertypeimage!
                
                let url1 = NSURL(string: url)
                completecustomerimage!.af_setImageWithURL(url1!,
                                                        placeholderImage: UIImage(named: "dress"),
                                                        filter: nil,
                                                        imageTransition: .CrossDissolve(1.0))
                Acceptedcustomerimage!.af_setImageWithURL(url1!,
                                                        placeholderImage: UIImage(named: "dress"),
                                                        filter: nil,
                                                        imageTransition: .CrossDissolve(1.0))
            }
            
            
               
        }else{
        
        print("hello")
        }
        
    }

}
