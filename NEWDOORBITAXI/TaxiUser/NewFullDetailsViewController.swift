//
//  NewFullDetailsViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 03/04/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import StarryStars

class NewFullDetailsViewController: UIViewController,MainCategoryProtocol {
    
    
    @IBOutlet weak var showdatetimelabel: UILabel!
    
    var mailinvoicedata: MailInvoiceModel!
    
    var mydatapage: DriverInfo!
    
    var ridestausvalue = ""
    var datetimedata = ""
    var rideid = ""
    var donerideid = ""
    
    var latroute1: [Double] = [Double]()
    var longroute1: [Double] = [Double]()
    
    let imageUrl = API_URL.imagedomain
    //   var rideid = ""
    
    var value = ""
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    var dropuplat : Double!
   var  dropuplong : Double!
    
    var pickuplat : Double!
   var pickuplong : Double!
    
    
    @IBOutlet weak var completemapimageview: UIImageView!
    
    @IBOutlet weak var completestatusview: UIView!
    
    
    @IBOutlet weak var completestatusbottomview: UIView!
    
    @IBOutlet weak var completedriverimage: UIImageView!
    
    @IBOutlet weak var completeratingview: RatingView!
    
    @IBOutlet weak var completedrivername: UILabel!
    
    @IBOutlet weak var completecarimage: UIImageView!
    
    @IBOutlet weak var completecarname: UILabel!
    
    @IBOutlet weak var completeprice: UILabel!
    
    @IBOutlet weak var completedistance: UILabel!
    
    @IBOutlet weak var completetime: UILabel!
    
    @IBOutlet weak var completepickuplocation: UILabel!
    
    @IBOutlet weak var completedroplocation: UILabel!
    
    @IBOutlet weak var completetotalprice: UILabel!
    
    
    
    //************************************
    
    @IBOutlet weak var Acceptedmapimageview: UIImageView!
    
    @IBOutlet weak var Acceptedstatusview: UIView!
    
    @IBOutlet weak var Accepteddriverimage: UIImageView!
    
    @IBOutlet weak var Accepteddrivername: UILabel!
    
    
    @IBOutlet weak var Acceptedratingview: RatingView!
    
    
    @IBOutlet weak var Acceptedcarimage: UIImageView!
    
    
    @IBOutlet weak var Acceptedcarname: UILabel!
    
    @IBOutlet weak var Acceptedpickuplocation: UILabel!
    
    @IBOutlet weak var Accepteddroplocation: UILabel!
    
    
    
    //*******************************************
    
    @IBOutlet weak var ridelatermapimageview: UIImageView!
    
    @IBOutlet weak var ridelaterstatusview: UIView!
    
    @IBOutlet weak var ridelaterpickuplocation: UILabel!
    
    @IBOutlet weak var ridelaterdroplocation: UILabel!
    
    
    
    //**********************
    
    @IBOutlet weak var ridelaterview: UIView!
    
    @IBOutlet weak var driveracceptedview: UIView!
    
    @IBOutlet weak var driverarrivedview: UIView!
    
   // @IBOutlet weak var cancelrideview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showdatetimelabel.text = datetimedata
        
        GlobalVarible.cancelbtnvaluematch  = "2"
        
        completeratingview.userInteractionEnabled = false
       // Acceptedratingview.userInteractionEnabled = false
        
        if ridestausvalue == "7" {
            completestatusview.hidden = false
           ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = true
            completestatusbottomview.hidden = false
           ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
          //  cancelrideview.hidden = true
            
        }
        
       if ridestausvalue == "1" {
            
            completestatusview.hidden = true
            ridelaterstatusview.hidden = false
            Acceptedstatusview.hidden = true
            completestatusbottomview.hidden = true
            ridelaterview.hidden = false
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
          //  cancelrideview.hidden = true
            
            
        }
        
        if ridestausvalue == "2" {
            
            completestatusview.hidden = true
           ridelaterstatusview.hidden = false
            Acceptedstatusview.hidden = true
            completestatusbottomview.hidden = true
            ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
           // cancelrideview.hidden = false
            
            
        }
        
        if ridestausvalue == "6" {
            
            completestatusview.hidden = true
            ridelaterstatusview.hidden = true
           Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = true
            ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = false
           // cancelrideview.hidden = true
            
            
        }
        
        if ridestausvalue == "4" {
            
            completestatusview.hidden = true
            ridelaterstatusview.hidden = true
           Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = true
            ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
           // cancelrideview.hidden = false
            
            
        }
        
        if ridestausvalue == "5" {
            
            completestatusview.hidden = true
           ridelaterstatusview.hidden = true
            Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = true
            ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = false
          //  cancelrideview.hidden = true
            
            
        }
        
        if ridestausvalue == "3" {
            
            completestatusview.hidden = true
            ridelaterstatusview.hidden = true
           Acceptedstatusview.hidden = false
            completestatusbottomview.hidden = true
            ridelaterview.hidden = true
            driveracceptedview.hidden = false
            driverarrivedview.hidden = true
          //  cancelrideview.hidden = true
            
            
        }
        
        
        if ridestausvalue == "8"{
            
            completestatusview.hidden = true
            ridelaterstatusview.hidden = false
            Acceptedstatusview.hidden = true
            completestatusbottomview.hidden = true
            ridelaterview.hidden = false
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
          //  cancelrideview.hidden = true
            
        }
        
        if ridestausvalue == "9"{
            
            completestatusview.hidden = true
            ridelaterstatusview.hidden = false
            Acceptedstatusview.hidden = true
            completestatusbottomview.hidden = true
            ridelaterview.hidden = true
            driveracceptedview.hidden = true
            driverarrivedview.hidden = true
           // cancelrideview.hidden = false
            
            
        }
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.DriverInformation(rideid)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // self.mainview.frame.size.height = 700
        self.scrollview.frame = self.scrollview.bounds
        self.scrollview.contentSize.height =  650
        self.scrollview.contentSize.width = 0
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func completeusecouponbtn(sender: AnyObject) {
        
        
    }
    
    @IBAction func completemailinvoicebtn(sender: AnyObject) {
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.Mailinvoice(donerideid)
        
        
    }
    
    @IBAction func completesupportbtn(sender: AnyObject) {
        
    }
    
    
    @IBAction func cancelrideusecouponbtn(sender: AnyObject) {
        
        
    }
    
    @IBAction func cancelridesupportbtn(sender: AnyObject) {
        
        
    }
    
    @IBAction func Driveracceptedusecouponbtn(sender: AnyObject) {
    }
    
    @IBAction func Driveracceptedtrackridebtn(sender: AnyObject) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController: TrackRideViewController = storyboard.instantiateViewControllerWithIdentifier("TrackRideViewController") as! TrackRideViewController
        nextController.Currentrideid = rideid
        self.presentViewController(nextController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func Driveracceptedcancelridebtn(sender: AnyObject) {
        
        /*  ApiManager.sharedInstance.protocolmain_Catagory = self
         
         let myRes = ApiManager.sharedInstance.CancelRide(rideid, RIDESTATUS: "2")
         
         let status = myRes["result"]
         
         if(status == 1){
         
         // self.showalert("Cancel Successfully!!")
         self.dismissViewControllerAnimated(true, completion: nil)
         
         }else{
         
         self.showalert1(NSLocalizedString("Please Try Again!!", comment: ""))
         }*/
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewControllerWithIdentifier("ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func Driveracceptedsupportbtn(sender: AnyObject) {
    }
    
    
    @IBAction func ridelaterusecouponbtn(sender: AnyObject) {
    }
    
    
    @IBAction func ridelatercancelridebtn(sender: AnyObject) {
        
        /* ApiManager.sharedInstance.protocolmain_Catagory = self
         
         let myRes = ApiManager.sharedInstance.CancelRide(rideid, RIDESTATUS: "2")
         
         let status = myRes["result"]
         
         if(status == 1){
         
         
         // self.showalert("Cancel Successfully!!")
         self.dismissViewControllerAnimated(true, completion: nil)
         
         }else{
         
         self.showalert1(NSLocalizedString("Please Try Again!!", comment: ""))
         }*/
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewControllerWithIdentifier("ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func ridelatersupportbtn(sender: AnyObject) {
    }
    
    
    @IBAction func driverarrivedusecouponbtn(sender: AnyObject) {
    }
    
    
    @IBAction func driverarrivedtrackridebtn(sender: AnyObject) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController: TrackRideViewController = storyboard.instantiateViewControllerWithIdentifier("TrackRideViewController") as! TrackRideViewController
        nextController.Currentrideid = rideid
        nextController.currentStatus = ridestausvalue
        self.presentViewController(nextController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func driverarrivedsupportbtn(sender: AnyObject) {
        
        
        
    }
    
    
    
    
    
    func showalert1(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
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
            
            spinnerActivity.userInteractionEnabled = false        }
    }
    
    
    func onSuccessExecution(msg: String) {
        print("msg")
        
    }
    
    
    func onerror(msg : String, errorCode: Int) {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        if(errorCode == -1009)
            
        {
            
            self.showalert1(NSLocalizedString("The Internet connection appears to be offline", comment: ""))
            
        }
            
        else if(errorCode == -1003)
        {
            self.showalert1( NSLocalizedString("A server with the specified hostname could not be found.", comment: ""))
            
        }
            
        else {
            
            self.showalert1(NSLocalizedString("The Internet connection appears to be slow", comment: ""))
        }
        
    }
    
    
    
    func onSuccessParse(data: AnyObject) {
        
        
        if(GlobalVarible.Api == "DriverInformation"){
            
            mydatapage = data as! DriverInfo
            
            if(mydatapage.result == 1){
                
                GlobalVarible.RideId = (mydatapage.details?.rideId)!
                
                 dropuplat = Double(mydatapage.details!.dropLat!)!
                 dropuplong = Double(mydatapage.details!.dropLong!)!
                
                 pickuplat = Double(mydatapage.details!.pickupLat!)!
                 pickuplong = Double(mydatapage.details!.pickupLong!)!
                
               ApiManager.sharedInstance.protocolmain_Catagory = self
               ApiManager.sharedInstance.FindDirectionlatlng(pickuplat,pickLng: pickuplong,DropLat : dropuplat ,DropLng: dropuplong)
                
                
                
                completepickuplocation.text = mydatapage.details!.beginLocation
               Acceptedpickuplocation.text = mydatapage.details?.pickupLocation
                ridelaterpickuplocation.text = mydatapage.details?.pickupLocation
                ridelaterdroplocation.text = mydatapage.details?.dropLocation
                
                
                
                
                completedroplocation.text  = mydatapage.details!.endLocation
             Accepteddroplocation.text = mydatapage.details?.dropLocation
                
                let driverratingvalue = mydatapage.details?.driverRating
                
                if driverratingvalue == ""{
                    print("hjjk")
                }else{
                    
                    completeratingview.rating = Float(driverratingvalue!)!
                    Acceptedratingview.rating = Float(driverratingvalue!)!
                }
                
                
                completecarname.text = (mydatapage.details?.carTypeName)! + "," + (mydatapage.details?.carModelName)!
              Acceptedcarname.text = (mydatapage.details?.carTypeName)! + "," + (mydatapage.details?.carModelName)!
                
                completeprice.text =  "LKR " + (mydatapage.details?.amount)!
                
                completedistance.text = (mydatapage.details?.distance)! + NSLocalizedString("Km", comment: "")
                
                completetime.text = mydatapage.details?.time
                
                donerideid = (mydatapage.details?.doneRideId)!
                
                             
                completetotalprice.text = "LKR " +  (mydatapage.details?.amount)!
                
                
                completedrivername.text = "  " + mydatapage.details!.driverName!
                Accepteddrivername.text = "  " + mydatapage.details!.driverName!
                
                
                let drivertypeimage = mydatapage.details!.driverImage
                
                print(drivertypeimage!)
                
                if(drivertypeimage == ""){
                    completedriverimage.image = UIImage(named: "profileeee") as UIImage?
                    Accepteddriverimage.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                     let newUrl = imageUrl + drivertypeimage!
                   // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                    print(newUrl)
                    
                    let url1 = NSURL(string: newUrl)
                    completedriverimage!.af_setImageWithURL(url1!,
                                                            placeholderImage: UIImage(named: "dress"),
                                                            filter: nil,
                                                            imageTransition: .CrossDissolve(1.0))
                    Accepteddriverimage!.af_setImageWithURL(url1!,
                                                            placeholderImage: UIImage(named: "dress"),
                                                            filter: nil,
                                                            imageTransition: .CrossDissolve(1.0))
                }
                
                
                let cartypeimage = mydatapage.details!.carTypeImage
                
                
                
                if(cartypeimage == ""){
                    completecarimage.image = UIImage(named: "profileeee") as UIImage?
                    Acceptedcarimage.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    let newUrl = imageUrl + cartypeimage!
                  //  let url = "http://apporio.co.uk/apporiotaxi/\(cartypeimage!)"
                    print(newUrl)
                    
                    let url1 = NSURL(string: newUrl)
                    completecarimage!.af_setImageWithURL(url1!,
                                                         placeholderImage: UIImage(named: "dress"),
                                                         filter: nil,
                                                         imageTransition: .CrossDissolve(1.0))
                    Acceptedcarimage!.af_setImageWithURL(url1!,
                                                         placeholderImage: UIImage(named: "dress"),
                                                         filter: nil,
                                                         imageTransition: .CrossDissolve(1.0))
                }
                
                
                
                
                
                
            }else{
                
                print("Hello")
                
                
            }
            
            
            
        }
        
        
        if(GlobalVarible.Api == "mailinvoice"){
            
            mailinvoicedata = data as! MailInvoiceModel
            
            if (mailinvoicedata.result == 1){
                
                showalert1(mailinvoicedata.msg!)
                
            }else{
                
                showalert1(mailinvoicedata.msg!)
                
            }
            
            
            
            
        }
        
        if(GlobalVarible.Api == "directionapiresult"){
            
            if(data["status"] as! String ==  "OK"){
                
                latroute1.removeAll()
                longroute1.removeAll()
                
                
         //       let data1 = data["result"]!!["geometry"]!!["location"]!!["lat"] as! Double
           //     let data2 = data["result"]!!["geometry"]!!["location"]!!["lng"] as! Double
                
               
            let data1 = data["routes"]!![0]["legs"]!![0]["steps"]!!.count
                print(data1)
                
                for i in 0..<data1{
         
       
                
                latroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![i]["start_location"]!!["lat"] as! Double)
                    longroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![i]["start_location"]!!["lng"] as! Double)
                    
                
                }
                
               latroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![data1 - 1]["end_location"]!!["lat"] as! Double)
                longroute1.append(data["routes"]!![0]["legs"]!![0]["steps"]!![data1 - 1]["end_location"]!!["lng"] as! Double)
                
                print(latroute1)
                print(longroute1)
                
                
               let phonewidth = Int(self.view.frame.width)
                let phoneheight = 130
                
                
                
                for i in 0..<latroute1.count{
                    
                    
                 value  =   value.stringByAppendingString(String(latroute1[i]) + "," + String(longroute1[i]) + "|")
                    
                    
                    
                }
                
               let truncated = value.substringToIndex(value.endIndex.predecessor())
                
                print(truncated)
                
                let arraycount = latroute1.count
                
                print(arraycount)
                
                
               let url11 = "http://maps.googleapis.com/maps/api/staticmap?size=\(phonewidth)x\(phoneheight)&path=color:0x000000|weight:2|\(truncated)&sensor=false&markers=icon:http://apporio.co.uk/triwl/s3.png|\(pickuplat),\(pickuplong)&markers=icon:http://apporio.co.uk/triwl/s2.png|\(dropuplat),\(dropuplong)"
                
                let url12 = url11.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                
               
                
                let url1 = NSURL(string: url12)
                
                
                self.completemapimageview!.af_setImageWithURL(url1!,
                                                              placeholderImage: UIImage(named: "dress"),
                                                              filter: nil,
                                                              imageTransition: .CrossDissolve(1.0))
                
                self.Acceptedmapimageview!.af_setImageWithURL(url1!,
                                                              placeholderImage: UIImage(named: "dress"),
                                                              filter: nil,
                                                              imageTransition: .CrossDissolve(1.0))
                
                
                self.ridelatermapimageview!.af_setImageWithURL(url1!,
                                                               placeholderImage: UIImage(named: "dress"),
                                                               filter: nil,
                                                               imageTransition: .CrossDissolve(1.0))
                
                


        
        
        }
        
        }
        
    }

}
