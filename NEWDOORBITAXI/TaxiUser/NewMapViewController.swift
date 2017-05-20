//
//  NewMapViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 29/03/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import TGPControls
import GoogleMaps
import SwiftyJSON
import Firebase
import MessageUI
import Crashlytics




var newmapviewcontroller :  NewMapViewController!

class NewMapViewController: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate,MainCategoryProtocol,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate  {
    
    
     var CarsTimedata: CarsTImeModel!
    
    var distancedata : DistanceModel!
    
    var ridedata: RideEstimate!
    
     var customersyncdata: CustomerSyncModel!
    
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var profilename: UILabel!
    
    @IBOutlet weak var profileemail: UILabel!
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var menutable: UITableView!
    
    var dataArray: [String] = ["BOOK RIDES","YOUR TRIPS","PAYMENTS","RATE CARD","REPORT ISSUE","CALL SUPPORT","TERMS AND CONDITION","ABOUT US"]
    
    
    var imageArray: [String] = ["ic_book","ic_trips","ic_payment","ic_tag_us_dollar","system_report","missed_call","ic_terms_condition","ic_about_us"]
    
    
    var Name = ""
    var email = ""
    
    var Userimage = ""
    
     var cancel60secrideid = ""

    
    @IBOutlet weak var CARIMAGEVIEWCIRCLE: UIView!
    



    let imageUrl = API_URL.imagedomain
    
    @IBOutlet weak var timeshowview: UIView!
    
    var part1: String = ""
    var part2: String = ""
    var part3: String = ""
    
    @IBOutlet var slidingview: UIView!
    
    @IBOutlet weak var pickuplocation: UILabel!
    
    @IBOutlet weak var dropofflocation: UILabel!
    
    @IBOutlet weak var rideestimatedtime: UILabel!
   
    @IBOutlet weak var mapview: GMSMapView!
    
        
    @IBOutlet weak var CustomSlider: TGPDiscreteSlider!
    
    @IBOutlet weak var customlabel: TGPCamelLabels!
    
     var locationManager = CLLocationManager()
    
    var ref = FIRDatabase.database().reference()
    
    
    @IBOutlet weak var ridenowview: UIView!
    
    @IBOutlet weak var afterridenowview: UIView!
    
    
    @IBOutlet weak var carnamelabel: UILabel!
    
    @IBOutlet weak var carimage: UIImageView!
    
    @IBOutlet weak var distancetimelabel: UILabel!
    
    @IBOutlet weak var seatnolabel: UILabel!
    
    @IBOutlet weak var basefarelabel: UILabel!
    
    @IBOutlet weak var rideestimatelabel: UILabel!
    
    @IBOutlet weak var applycoupontext: UILabel!
    
    @IBOutlet weak var carimageview: UIImageView!
    
    @IBOutlet weak var carnametext: UILabel!
    
     var nearstDriverUserDistance  : Double!
    
    var minimumValue : Double!
    
    var timerForGetDriverLocation = NSTimer()
    
    var timerForGetDriverLocation1 = NSTimer()
    
     var movedfrom = " "
     var latermoved = ""
    
    var totaltime = ""
    
     var distanceKM  =  [Double]()
    
    var addarray = [AnyObject]()
    
    let blackView = UIView()

    
    var index = 0
    
    var markers = [GMSMarker]()
    
    var driverIds = [String]()
    
    var cartypeArray = [String]()
    
    var statusArray = [String]()
    
    
    
    
    var matchvalue = 0
    
    var selectvalue = 0
    
    
    @IBOutlet weak var selectpaymenttext: UILabel!
    
    @IBOutlet weak var hiddenview: UIView!

  var cartypearray = [String]()
    
    var CurrentDate = ""
    var CurrentTime = ""

    
  let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
    

    override func viewDidLoad() {
        
                     
        self.ridenowview.hidden = true
        
         newmapviewcontroller = self
        
              
        profileimage.layer.borderWidth = 1
        profileimage.layer.masksToBounds = false
        profileimage.layer.borderColor = UIColor.blackColor().CGColor
        profileimage.layer.cornerRadius =  profileimage.frame.height/2
        profileimage.clipsToBounds = true
        
        Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyname)!
        
        email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyemail)!
        
        Userimage =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyimage)!
        
        if(Userimage == ""){
            profileimage.image = UIImage(named: "profileeee") as UIImage?
            print("No Image")
        }else{
            let newUrl = imageUrl + Userimage
           // let url = "http://apporio.co.uk/apporiotaxi/\(Userimage)"
            print(newUrl)
            
            let url1 = NSURL(string: newUrl)
            profileimage!.af_setImageWithURL(url1!,
                                             placeholderImage: UIImage(named: "dress"),
                                             filter: nil,
                                             imageTransition: .CrossDissolve(1.0))
        }
        
        
        self.profilename.text! = Name
        self.profileemail.text! = email

           
     //   self.customlabel.names = ["A","B","C","D","E","F"]
        
      //  self.ridenowview.hidden = false
        
        self.locationManager.delegate = self
        
        //self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
            // self.CustomSlider.ticksListener = self.customlabel
        mapview.animateToZoom(15)
        
        timeshowview.layer.borderWidth = 1.0
        timeshowview.layer.cornerRadius = 4

        
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(showDialog),
            name: "show",
            object: nil)
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(hideDialog),
            name: "hide",
            object: nil)
        
        GlobalVarible.PaymentOptionId = "1"
        GlobalVarible.MatchCardSelect = 0
        

        
        CustomSlider.addTarget(self,
                                 action: #selector(valueChanged(_:event:)),
                                 forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        if self.revealViewController() != nil{
            
            self.revealViewController().rearViewRevealWidth = 270.0
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }

            GlobalVarible.trackbackbtnvaluematch = 0
    
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
       
        ApiManager.sharedInstance.ViewCarsWithTime(GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
        
        
        GlobalVarible.paymentmethod = "CASH"
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        
        formatter.timeStyle = NSDateFormatterStyle.NoStyle
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        CurrentDate  = formatter.stringFromDate(currentDateTime)
        GlobalVarible.CurrentDate = CurrentDate
        
        formatter.timeStyle = NSDateFormatterStyle.MediumStyle
        formatter.dateStyle = NSDateFormatterStyle.NoStyle
        CurrentTime = formatter.stringFromDate(currentDateTime)
        
        dropofflocation.text = NSLocalizedString("Enter Drop Location", comment: "")
        
        
        print(CurrentDate)
        print(CurrentTime)

        
        mapview.delegate = self

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if  GlobalVarible.trackbackbtnvaluematch == 1 {
            
            self.ridenowview.hidden = false
            self.afterridenowview.hidden = true
            self.hiddenview.hidden = true
            
            GlobalVarible.trackbackbtnvaluematch = 0
        }
        
        self.slidingview.alpha = 0
         self.blackView.alpha = 0

        
       // locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        
        Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyname)!
        
        email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyemail)!
        
        Userimage =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyimage)!
        
        self.profilename.text! = Name
        self.profileemail.text! = email
        
        
        if(Userimage == ""){
            profileimage.image = UIImage(named: "profileeee") as UIImage?
            print("No Image")
        }else{
            let newUrl = imageUrl + Userimage
           // let url = "http://apporio.co.uk/apporiotaxi/\(Userimage)"
            print(newUrl)
            
            let url1 = NSURL(string: newUrl)
            profileimage!.af_setImageWithURL(url1!,
                                             placeholderImage: UIImage(named: "dress"),
                                             filter: nil,
                                             imageTransition: .CrossDissolve(1.0))
        }
        


        
        
        selectpaymenttext.text = GlobalVarible.paymentmethod
        
       dropofflocation.text = GlobalVarible.UserDropLocationText
        
        if(GlobalVarible.matchintegernumber == 2){
            
            timerForGetDriverLocation.invalidate()
            GlobalVarible.k = 1
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.FindDistance()
            
        }
        
        
        if(GlobalVarible.OKBtnString == "OkClick"){
            ridenowview.hidden = true
            afterridenowview.hidden = false
            
            // cardetailview.hidden = true
            if(GlobalVarible.cartypename == " "){
                carnametext.text = "null"
            }else{
                carnametext.text = GlobalVarible.cartypename
                
            }
            if(GlobalVarible.cartypeimage == " "){
               // carimageview.text = "null"
            }else{
                 let newUrl = imageUrl + GlobalVarible.cartypeimage
               // let url = "http://apporio.co.uk/apporiotaxi/\(GlobalVarible.cartypeimage)"
                
                let url1 = NSURL(string: newUrl)
                carimageview!.af_setImageWithURL(
                    url1!,
                    placeholderImage: UIImage(named: "dress"),
                    filter: nil,
                    imageTransition: .CrossDissolve(1.0))
                
            }
            
        }else{
            print("hello")
        }
        
        
    }
    
    
    @IBAction func profilebtn(sender: AnyObject) {
        
        /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let mapViewController = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
         
         self.presentViewController(mapViewController, animated:true, completion:nil)*/
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let mapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewProfileViewController") as! NewProfileViewController
        
        self.presentViewController(mapViewController, animated:true, completion:nil)
        
        
    }
    

    

    
    
    @IBAction func menubtn(sender: AnyObject) {
        
        
         ApiManager.sharedInstance.ContactApi()
        
       // self.revealViewController().revealToggleAnimated(true)
        
        
     /*  let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("NewMenuTableViewController") as! NewMenuTableViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
       vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(vc, animated: true, completion:nil)*/
        
        self.eventAnimationPopUp()

        
        
    
        
    }
    
    @IBAction func currentlocationbtn(sender: AnyObject) {
        
      self.locationManager.startUpdatingLocation()
        
          mapview.animateToZoom(15)
     //   self.locationManager.requestAlwaysAuthorization()
        
       // self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([GlobalVarible.ContactEmail])
        mailComposerVC.setSubject(NSLocalizedString("Report Issue Regarding DoorbiTaxi App", comment: ""))
        mailComposerVC.setMessageBody(NSLocalizedString("Sending e-mail in-app is not so bad!", comment: ""), isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: NSLocalizedString("Could Not Send Email", comment: ""), message: NSLocalizedString("Your device could not send e-mail.  Please check e-mail configuration and try again.", comment: ""), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
       
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return dataArray.count
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = menutable.dequeueReusableCellWithIdentifier("MenuTable1", forIndexPath: indexPath)
        
        
        
        let imageview :UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        let label : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        let labelshow : UILabel = (cell.contentView.viewWithTag(3) as? UILabel)!
        
        if indexPath.row == 3{
            labelshow.hidden = false
            
        }else{
            labelshow.hidden = true
        }
        
        let image = UIImage(named: imageArray[indexPath.row])
        
        imageview.image = image
        label.text = dataArray[indexPath.row]
        
             
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        menutable.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        
        
        if(indexPath.row == 0){
            
         //   self.dismissViewControllerAnimated(true, completion: nil)
            
            self.slidingview.alpha = 0
            self.blackView.alpha = 0

            
            // self.revealViewController().revealToggleAnimated(true)
            
        }
        
        if(indexPath.row == 1)
        {
            
            
            
            
            /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let yourViewController = storyBoard.instantiateViewControllerWithIdentifier("YourRideViewController") as! YourRideViewController
             
             self.presentViewController(yourViewController, animated:true, completion:nil)*/
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let yourViewController = storyBoard.instantiateViewControllerWithIdentifier("NewYourRideViewController") as! NewYourRideViewController
            
            self.presentViewController(yourViewController, animated:true, completion:nil)
            
            
            
            
            
            
        }
        
        
        if(indexPath.row == 2)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let selectcardviewcontroller = storyBoard.instantiateViewControllerWithIdentifier("SelectCardViewController") as! SelectCardViewController
            
            self.presentViewController(selectcardviewcontroller, animated:true, completion:nil)
            //  self.revealViewController().revealToggleAnimated(true)
            
            
            
            
            
            
        }
        
        if(indexPath.row == 3)
        {
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mapViewController = storyBoard.instantiateViewControllerWithIdentifier("RateCardViewController") as! RateCardViewController
            
            self.presentViewController(mapViewController, animated:true, completion:nil)
            
            // self.revealViewController().revealToggleAnimated(true)
            
            
            
        }
        
        if(indexPath.row == 4)
        {
            
            
            
            /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let selectcardviewcontroller = storyBoard.instantiateViewControllerWithIdentifier("SelectCardViewController") as! SelectCardViewController
             
             self.presentViewController(selectcardviewcontroller, animated:true, completion:nil)
             self.revealViewController().revealToggleAnimated(true)*/
            
            
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            //   self.revealViewController().revealToggleAnimated(true)
            
            
            
            
            
        }
        
        
        /*if(indexPath.row == 5){
         
         
         
         /* let mailComposeViewController = configuredMailComposeViewController()
         if MFMailComposeViewController.canSendMail() {
         self.presentViewController(mailComposeViewController, animated: true, completion: nil)
         } else {
         self.showSendMailErrorAlert()
         }
         self.revealViewController().revealToggleAnimated(true)*/
         
         
         
         }*/
        
        if(indexPath.row == 5){
            
            if let url = NSURL(string: "telprompt://\(GlobalVarible.ContactTelephone)") {
                UIApplication.sharedApplication().openURL(url)
            }
            

            
            //UIApplication.sharedApplication().openURL(NSURL(string : "tel://\(GlobalVarible.ContactTelephone)")!)
            //  self.revealViewController().revealToggleAnimated(true)
            
        }
        
        if(indexPath.row == 6){
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let termsViewController = storyBoard.instantiateViewControllerWithIdentifier("TemsConditionsViewController") as! TemsConditionsViewController
            self.presentViewController(termsViewController, animated:true, completion:nil)
            //  self.revealViewController().revealToggleAnimated(true)
            
            
            
            
        }
        
        if(indexPath.row == 7){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let aboutViewController = storyBoard.instantiateViewControllerWithIdentifier("AboutusViewController") as! AboutusViewController
            self.presentViewController(aboutViewController, animated:true, completion:nil)
            //  self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
    }
    

    
        
    
    @IBAction func selectdropofflocationbtn(sender: AnyObject) {
        
        
      /*  let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        presentViewController(autocompleteController, animated: true, completion: nil)*/
        
       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let userdroplocationViewController = storyBoard.instantiateViewControllerWithIdentifier("UserDropLocationViewController") as! UserDropLocationViewController
        self.presentViewController(userdroplocationViewController, animated:true, completion:nil)
        
        
    }
    
    
    func eventAnimationPopUp(){
        
        slidingview.layer.cornerRadius = 5
        slidingview.clipsToBounds = true
        if let window = UIApplication.sharedApplication().keyWindow{
            print(window.frame)
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            let lefswipe = (UISwipeGestureRecognizer(target: self, action:#selector(slideToRightWithGestureRecognizer)))
            lefswipe.direction = .Left
            self.blackView.addGestureRecognizer(lefswipe)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(slidingview)
            slidingview.frame = CGRect(x: 15, y: 15, width: window.frame.width-100, height: window.frame.height-30)
            blackView.frame = window.frame
            blackView.alpha = 0
            //self.sligingview.alpha = 1
            
           slidingview.slideLeft()
            self.slidingview.alpha = 1
            blackView.alpha = 1
            //sligingview.slideLeft()
            
        }
    }
    func handleDismiss() {
        //sligingview.slideLeft()
        slidingview.slideRight()
        self.slidingview.alpha = 0
        self.blackView.alpha = 0
        //self.blackView.removeFromSuperview()
        //self.sligingview.removeFromSuperview()
    }
    func slideToRightWithGestureRecognizer(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped right")
                slidingview.slideRight()
                self.slidingview.alpha = 0
                self.blackView.alpha = 0
            default:
                break
            }
        }
    }
    
    
   /* func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
   /* func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: nil) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }*/
    
    // User canceled the operation.
   /* func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismissViewControllerAnimated(animated: true, completion: nil)
    }*/
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       //UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       // UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }*/

    
    
    
    func valueChanged(sender: TGPDiscreteSlider, event:UIEvent) {
        
        
        self.selectvalue = 1
        
        self.markers.removeAll()
        self.driverIds.removeAll()

        
       self.customlabel.value = UInt(CustomSlider.value)
       print(self.customlabel.value)
        
        
         index = Int(self.customlabel.value)
        
       CARIMAGEVIEWCIRCLE.layer.borderWidth = 1
        CARIMAGEVIEWCIRCLE.layer.masksToBounds = false
        CARIMAGEVIEWCIRCLE.layer.borderColor = UIColor.blackColor().CGColor
        CARIMAGEVIEWCIRCLE.layer.cornerRadius = CARIMAGEVIEWCIRCLE.frame.height/2
        CARIMAGEVIEWCIRCLE.clipsToBounds = true

        
       distancetimelabel.text = CarsTimedata.msg![index].carTypeName!
        
         basefarelabel.text = CarsTimedata.msg![index].baseFare! + " PER KM"
        
        let newString = CarsTimedata.msg![index].carTypeImage!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
          let newUrl = imageUrl + newString
        
       // let url = "http://apporio.co.uk/apporiotaxi/\(newString)"
        
        let url1 = NSURL(string: newUrl)
        carimage!.af_setImageWithURL(
            url1!,
            placeholderImage: UIImage(named: "dress"),
            filter: nil,
            imageTransition: .CrossDissolve(1.0))
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            GlobalVarible.firstcarname = CarsTimedata.msg![index].carTypeName!
            GlobalVarible.cartypename = CarsTimedata.msg![index].carTypeName!
        }else{
            GlobalVarible.firstcarname = CarsTimedata.msg![index].carTypeName!
            GlobalVarible.cartypename = CarsTimedata.msg![index].carTypeName!
        }
        
        GlobalVarible.car_type_id = CarsTimedata.msg![index].carTypeId!
        
        
        GlobalVarible.cartypeid = CarsTimedata.msg![index].carTypeId!
        
        GlobalVarible.Cityid = CarsTimedata.msg![index].cityId!
        GlobalVarible.cartypeimage = CarsTimedata.msg![index].carTypeImage!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        
     
        
         self.seatnolabel.text = " "
        
        
        ref.child("Drivers_A").observeEventType(.Value, withBlock: { (snapshot) in
            
            
            
          GlobalVarible.Counter = "yes"
            self.latermoved = "RideLaterMove"
         //   self.markers.removeAll()
         //   self.driverIds.removeAll()
            self.cartypeArray.removeAll()
           // self.statusArray.removeAll()
            self.mapview.clear()
            self.movedfrom = "CarSelectHello"
            self.distanceKM.removeAll()
            self.addarray.removeAll()
            //self.seatnolabel.text = "No driver"
          // self.seatnolabel.text = " "
            
            
            for items in snapshot.children
            {
                
                
                var cartypeid = ""
                var status = ""
                
                if  (items.value["driver_car_type_id"]) as! String != "" {
                    
                    
                 cartypeid = items.value["driver_car_type_id"] as! String
                 status = items.value["driver_online_offline_status"] as! String
                    
               
                    
                }
                 // self.cartypeArray.append(cartypeid)
                
              //  print(cartypeid)
              //  print(GlobalVarible.car_type_id)
               /* if(cartypeid == GlobalVarible.car_type_id) {
                self.cartypeArray.append(cartypeid)
                self.statusArray.append(status)
                    
                }
                
                
                if self.cartypeArray.contains("GlobalVarible.car_type_id") && self.statusArray.contains("1"){
                    self.selectvalue == 1
                                    
                }*/
                
               // if self.cartypeArray.contains(GlobalVarible.cartypeid) && status == "1" {
                
                
                   // && status == "1"
                  if(cartypeid == GlobalVarible.car_type_id ){
                    
                    self.movedfrom = "CarSelect"
                    
                  //  self.cartypeArray.append(GlobalVarible.car_type_id)
                   // self.statusArray.append(status)
                  //  var latitude = ""
                  //  var longitude = ""
                    
                     if  (items.value["driver_current_latitude"]) as! String != "" {
                        
                      let latitude = items.value["driver_current_latitude"] as! String
                       let longitude = items.value["driver_current_longitude"] as! String
                        
                         let bearningdegree = items.value["bearingfactor"] as! String
                                        
                    let status = items.value["driver_online_offline_status"] as! String
                    
                    
                    if(self.selectvalue == 1 && status == "1"){
                    
                    
                   let coordinateTo = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
                    
                    // let coordinateFrom = CLLocation(latitude: 28.4198, longitude: 77.0382)
                    
                    let pickuplat = Double(GlobalVarible.PickUpLat)
                    let pickuplng = Double(GlobalVarible.PickUpLng)
                    
                    let coordinateFrom = CLLocation(latitude: pickuplat! , longitude: pickuplng!)
                    
                    let distanceInMeter =  coordinateFrom.distanceFromLocation(coordinateTo)
                    
                    let distanceInKilometer =  distanceInMeter * 0.001
                    
                      self.distanceKM.append(distanceInKilometer)
                    
                    self.addarray.append(items)
                    
                    
                     self.minimumValue = self.distanceKM.minElement()
                    
                    }
                    
                    newmapviewcontroller.setMarkers(items.key!, lat: Double(latitude)!, long: Double(longitude)! ,status: Int(status)! , cartypeid: cartypeid,BearningFactor: bearningdegree)
                    
                        
                    }
                    
                }else{
                    
                    
                }
                
            }
            
            if(self.selectvalue == 1){
            for (index , items )  in  self.distanceKM.enumerate()
            {
                
                
                if self.minimumValue ==  items
                {
                     self.nearstDriverUserDistance =  items
                    let latitude = self.addarray[index].value["driver_current_latitude"] as! String
                    let longitude = self.addarray[index].value["driver_current_longitude"] as! String
                    
                    ApiManager.sharedInstance.protocolmain_Catagory = self
                    ApiManager.sharedInstance.FindDistance1(latitude,DriverLong: longitude)
                   self.selectvalue = 0
                                    
                    break
                }
                    
                else
                {
                    
                }
                
            }
                
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }

        
        
    }
    
    
    
    func valuechange1(){
        
        
        CARIMAGEVIEWCIRCLE.layer.borderWidth = 1
        CARIMAGEVIEWCIRCLE.layer.masksToBounds = false
       CARIMAGEVIEWCIRCLE.layer.borderColor = UIColor.blackColor().CGColor
        CARIMAGEVIEWCIRCLE.layer.cornerRadius = CARIMAGEVIEWCIRCLE.frame.height/2
        CARIMAGEVIEWCIRCLE.clipsToBounds = true
        
        
        distancetimelabel.text = CarsTimedata.msg![index].carTypeName!
        
        basefarelabel.text = CarsTimedata.msg![index].baseFare! + " PER KM"
        
        let newString = CarsTimedata.msg![index].carTypeImage!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let newUrl = imageUrl + newString
      //  let url = "http://apporio.co.uk/apporiotaxi/\(newString)"
        
        let url1 = NSURL(string: newUrl)
        carimage!.af_setImageWithURL(
            url1!,
            placeholderImage: UIImage(named: "dress"),
            filter: nil,
            imageTransition: .CrossDissolve(1.0))
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            GlobalVarible.firstcarname = CarsTimedata.msg![index].carTypeName!
            GlobalVarible.cartypename = CarsTimedata.msg![index].carTypeName!
        }else{
           /* GlobalVarible.cartypename = CarsTimedata.msg![index].carNameOther!
            GlobalVarible.firstcarname = CarsTimedata.msg![index].carNameOther!*/
            GlobalVarible.firstcarname = CarsTimedata.msg![index].carTypeName!
            GlobalVarible.cartypename = CarsTimedata.msg![index].carTypeName!

        }
        
        GlobalVarible.car_type_id = CarsTimedata.msg![index].carTypeId!
        
        GlobalVarible.cartypeid = CarsTimedata.msg![index].carTypeId!
        
        GlobalVarible.Cityid = CarsTimedata.msg![index].cityId!
        GlobalVarible.cartypeimage = CarsTimedata.msg![index].carTypeImage!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
               
        ref.child("Drivers_A").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            
            GlobalVarible.Counter = "yes"
            self.latermoved = "RideLaterMove"
            self.markers.removeAll()
            self.driverIds.removeAll()
           
            self.mapview.clear()
            self.movedfrom = "CarSelectHello"
            self.distanceKM.removeAll()
            self.addarray.removeAll()
            self.seatnolabel.text = ""

            
            
            for items  in snapshot.children
            {
                
                
                let cartypeid = items.value["driver_car_type_id"] as! String
                let status = items.value["driver_online_offline_status"] as! String
                
                
                print(cartypeid)
                print(GlobalVarible.car_type_id)
                
                if(cartypeid == GlobalVarible.car_type_id){
                    
                    self.movedfrom = "CarSelect"
                    
                    var latitude = ""
                    var longitude = ""
                    
                    if  (items.value["driver_current_latitude"]) as! String != "" {
                        
                        latitude = items.value["driver_current_latitude"] as! String
                        longitude = items.value["driver_current_longitude"] as! String
                        let status = items.value["driver_online_offline_status"] as! String
                        
                         let bearningdegree = items.value["bearingfactor"] as! String
                        
                        
                        newmapviewcontroller.setMarkers(items.key!, lat: Double(latitude)!, long: Double(longitude)! ,status: Int(status)! , cartypeid: cartypeid,BearningFactor: bearningdegree)
                        
                    }
                    

                    
                  //  let latitude = items.value["driver_current_latitude"] as! String
                  //  let longitude = items.value["driver_current_longitude"] as! String
                 //   let status = items.value["driver_online_offline_status"] as! String
                    
                    
                    
                                        
                  //  newmapviewcontroller.setMarkers(items.key!, lat: Double(latitude)!, long: Double(longitude)! ,status: Int(status)! , cartypeid: cartypeid)
                    
                    
                }else{
                   
                    
                }
                
                
                if(cartypeid == GlobalVarible.car_type_id && status == "1"){
                    
                  //  var latitude = ""
                  //  var longitude = ""
                    
                    if  (items.value["driver_current_latitude"]) as! String != "" {
                        
                      let  latitude = items.value["driver_current_latitude"] as! String
                       let longitude = items.value["driver_current_longitude"] as! String
                        
                        
                    let coordinateTo = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
                    
                    // let coordinateFrom = CLLocation(latitude: 28.4198, longitude: 77.0382)
                    
                    let pickuplat = Double(GlobalVarible.PickUpLat)
                    let pickuplng = Double(GlobalVarible.PickUpLng)
                    
                    let coordinateFrom = CLLocation(latitude: pickuplat! , longitude: pickuplng!)
                    
                    let distanceInMeter =  coordinateFrom.distanceFromLocation(coordinateTo)
                    
                    let distanceInKilometer =  distanceInMeter * 0.001
                    
                    self.distanceKM.append(distanceInKilometer)
                    
                    self.addarray.append(items)
                    
                    
                    self.minimumValue = self.distanceKM.minElement()
                        
                    }

                }else{
                
                    
                }
                            
                
            }
            
            
            for (index , items )  in  self.distanceKM.enumerate()
            {
                
                
                if self.minimumValue ==  items
                {
                    self.nearstDriverUserDistance =  items
                    let latitude = self.addarray[index].value["driver_current_latitude"] as! String
                    let longitude = self.addarray[index].value["driver_current_longitude"] as! String
                    
                  //  ApiManager.sharedInstance.protocolmain_Catagory = self
                  //  ApiManager.sharedInstance.FindDistance1(latitude,DriverLong: longitude)
                    
                    
                    break
                }
                    
                else
                {
                    
                }
                
            }
            
            
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    
    }

    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedAlways{
            
            locationManager.startUpdatingLocation()
              mapview.animateToZoom(15)
            mapview.myLocationEnabled = true
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            
            
            mapview.animateToLocation(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            
           // mapview.animateToZoom(15)
            
           self.locationManager.stopUpdatingLocation()
            
            
        }
        
    }
    
  
    
    
    func mapView(mapView: GMSMapView, didChangeCameraPosition position: GMSCameraPosition) {
        
         self.ridenowview.hidden = true
       
    }

    
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
        
        //self.ridenowview.hidden = false
        reverseGeocodeCoordinate(position.target)
    }
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        
        let geocoder = GMSGeocoder()
        
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                self.ridenowview.hidden = false

                
                let lines = address.lines
                self.pickuplocation.text = lines!.joinWithSeparator("\n")
                GlobalVarible.Pickuptext = lines!.joinWithSeparator("\n")
                GlobalVarible.PickUpLat  = String(coordinate.latitude)
                GlobalVarible.PickUpLng = String(coordinate.longitude)
                GlobalVarible.k = 0
                
                //  MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                if(self.matchvalue == 0){
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                   
                ApiManager.sharedInstance.ViewCarsWithTime(GlobalVarible.usercityname, USERLAT: GlobalVarible.PickUpLat, USERLNG: GlobalVarible.PickUpLng)
                    self.matchvalue = 1
                
                }else{
                
                
                }
                               
                
                UIView.animateWithDuration(0.25) {
                    self.view.layoutIfNeeded()
                }
                
            }
            
        }
        
    }
    
    
    @IBAction func ridelaterbtn(sender: AnyObject) {
        
        timerForGetDriverLocation.invalidate()
        GlobalVarible.k = 1
        
        if(latermoved == "RideLaterMove"){
            
            
            if(GlobalVarible.UserDropLocationText == NSLocalizedString("Enter Drop Location", comment: "")){
                
                self.showalert3(NSLocalizedString("Please Enter Drop Location First!!!", comment: ""))
                
            }else{
                
                GlobalVarible.RideType = "1"
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let dateViewController = storyBoard.instantiateViewControllerWithIdentifier("DateAndTimeViewController") as! DateAndTimeViewController
                self.presentViewController(dateViewController, animated:true, completion:nil)
            }
        }
        else{
            self.showalert(NSLocalizedString("Please Select Car First!!!", comment: ""))
            
        }

    }
    
    
    @IBAction func ridenowbtn(sender: AnyObject) {
        
        
        timerForGetDriverLocation.invalidate()
        GlobalVarible.k = 1
        
        GlobalVarible.matchintegernumber  = 3
        
        if(movedfrom == "CarSelect"){
            
            GlobalVarible.OKBtnString = "NotClick"
            
            if(GlobalVarible.UserDropLocationText == NSLocalizedString("Enter Drop Location", comment: "")){
                
                self.showalert3(NSLocalizedString("Please Enter Drop Location First!!!", comment: ""))
                
                
            }else{
                
                
                GlobalVarible.RideType = "0"
                ridenowview.hidden = true
                afterridenowview.hidden = false
                
                // cardetailview.hidden = false
                
                // GlobalVarible.DriverCityId = (NearCardata.response?.message![0].cityId)!
                
                if(GlobalVarible.cartypename == " "){
                    carnametext.text = "null"
                }else{
                    carnametext.text = GlobalVarible.cartypename
                    
                }
                if(GlobalVarible.cartypeimage == " "){
                    carnametext.text = "null"
                }else{
                     let newUrl = imageUrl + GlobalVarible.cartypeimage
                //    let url = "http://apporio.co.uk/apporiotaxi/\(GlobalVarible.cartypeimage)"
                    
                    let url1 = NSURL(string: newUrl)
                   carimageview!.af_setImageWithURL(
                        url1!,
                        placeholderImage: UIImage(named: "dress"),
                        filter: nil,
                        imageTransition: .CrossDissolve(1.0))
                    
                }
                
                
                
                           }
        }
        else{
            self.showalert(NSLocalizedString("Please Select Car First!!!", comment: ""))
            
        }

    }
    
    @IBAction func confirmbtn(sender: AnyObject) {
        
        GlobalVarible.k = 1
        timerForGetDriverLocation.invalidate()
        //  hiddenview.hidden = false
        
        if  GlobalVarible.notificationvalue == 1
            
        {
            // self.showalert2("Please first turn on Notification from Settings.")
            
            self.showalert5("If you want to book ride. Please, go to settings and allow notification permissions.")
            
            
        }else{

        
        
        if(GlobalVarible.RideType == "0"){
            
            
          /*  if(GlobalVarible.PaymentOptionId == ""){
                
                self.showalert("First Select Payment Method")
                
                
            }else{*/
                hiddenview.hidden = false
                
                
             ref.child("Drivers_A").removeAllObservers()
                
                let Droplat = String(GlobalVarible.UserDropLat)
                let DropLng = String(GlobalVarible.UserDropLng)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.ConfirmRide(self.Userid!,COUPONCODE: GlobalVarible.CouponCode,USERCURRENTLAT: GlobalVarible.PickUpLat,USERCURRENTLONG: GlobalVarible.PickUpLng,CURRENTADDRESS: GlobalVarible.Pickuptext,DROPLAT: Droplat,DROPLNG: DropLng,DropLOCATION: GlobalVarible.UserDropLocationText,RIDETYPE: "1",RIDESTATUS: "1",CARTYPEID: GlobalVarible.cartypeid,PaymentOPtionId: GlobalVarible.PaymentOptionId,CardId: GlobalVarible.CardId)
          //  }
            
            // self.bookRide()
            
            
        }
        if(GlobalVarible.RideType == "1"){
            
           /* if(GlobalVarible.PaymentOptionId == ""){
                
                self.showalert("First Select Payment Method")
                
                
            }else{*/
                
                hiddenview.hidden = false
                let a:Double = GlobalVarible.UserDropLng
                let DropLngString:String = String(format:"%f", a)
                let b:Double = GlobalVarible.UserDropLat
                let DropLatString:String = String(format:"%f", b)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.RideLaterConfirm(Userid!, COUPONCODE: GlobalVarible.CouponCode, USERCURRENTLAT: GlobalVarible.PickUpLat, USERCURRENTLONG: GlobalVarible.PickUpLng, CURRENTADDRESS: GlobalVarible.Pickuptext, DROPLAT: DropLatString, DROPLNG: DropLngString, DropLOCATION: GlobalVarible.UserDropLocationText, SELECTTIME: GlobalVarible.SelectTime, SELECTDATE: GlobalVarible.SelectDate, RIDETYPE: "2", RIDESTATUS: "1", CARTYPEID: GlobalVarible.cartypeid,PaymentOPtionId: GlobalVarible.PaymentOptionId,CardId: GlobalVarible.CardId)
                
           // }
            
        }
            
        }

    }
    
    @IBAction func cancelbtn(sender: AnyObject) {
        
        ridenowview.hidden = false
        afterridenowview.hidden = true
    }
    
    
    @IBAction func selectpaymentmethod(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let paymentviewcontroller = storyBoard.instantiateViewControllerWithIdentifier("SelectPaymentViewController") as! SelectPaymentViewController
        // paymentdialogViewController.modalPresentationStyle = .OverCurrentContext
        paymentviewcontroller.modalPresentationStyle = .Popover
        self.presentViewController(paymentviewcontroller, animated:true, completion:nil)
        

    }
    
    
    @IBAction func applycouponbtn(sender: AnyObject) {
        
        timerForGetDriverLocation.invalidate()
        GlobalVarible.k = 1
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let CouponViewController = storyBoard.instantiateViewControllerWithIdentifier("CouponsCodeViewController") as! CouponsCodeViewController
        self.presentViewController(CouponViewController, animated:true, completion:nil)

    }
    
    
    func showalert5(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "Permission denied", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                
                GlobalVarible.afterallownotificationsetting = 1
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    

    
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    
    func showalert4(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                
                self.timerForGetDriverLocation.invalidate()
                GlobalVarible.k = 1
                
                self.ridenowview.hidden = false
                self.afterridenowview.hidden = true
                self.hiddenview.hidden = true
                self.dropofflocation.text = NSLocalizedString("Enter Drop Location", comment: "")
                GlobalVarible.UserDropLocationText = NSLocalizedString("Enter Drop Location", comment: "")
                GlobalVarible.UserDropLat = 0.0
                GlobalVarible.UserDropLng = 0.0
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    func showalert3(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: "", message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                
                self.timerForGetDriverLocation.invalidate()
                GlobalVarible.k = 1
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let userdroplocationViewController = storyBoard.instantiateViewControllerWithIdentifier("UserDropLocationViewController") as! UserDropLocationViewController
                self.presentViewController(userdroplocationViewController, animated:true, completion:nil)
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    
    
    
    func showalert2(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:  NSLocalizedString("OOPS", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                self.hiddenview.hidden = true
                self.ridenowview.hidden = false
                self.afterridenowview.hidden = true
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    
    
    func showalert1(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: NSLocalizedString("Success", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let TrackViewController = storyBoard.instantiateViewControllerWithIdentifier("TrackRideViewController") as! TrackRideViewController
                // TrackViewController.mydatapage = self.driverdata
                TrackViewController.Currentrideid = self.part2
                TrackViewController.currentStatus = self.part3
                TrackViewController.currentmessage = self.part1
                self.presentViewController(TrackViewController, animated:true, completion:nil)
                
                
            }
            alertController.addAction(OKAction)
            
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    

    
    
    func onProgressStatus(value: Int) {
        if(value == 0 ){
            
            if(GlobalVarible.Counter == "no"){
                
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
            }else{
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }else if (value == 1){
            
            if(GlobalVarible.Counter == "no"){
                
                
            }else{
                
                let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
                spinnerActivity.detailsLabel.text = NSLocalizedString("Please Wait!!", comment: "")
                
                spinnerActivity.userInteractionEnabled = false
            }
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
        
        if(GlobalVarible.Api == "CarsTimeModel"){
            CarsTimedata = data as! CarsTImeModel
            
          //  z = 1
            print(CarsTimedata.msg?.count)
            
            if(CarsTimedata.result == 0){
               
                
            }else{
                self.ridenowview.hidden = false
                 cartypearray.removeAll()
                matchvalue = 1
             //   self.customlabel.names = ["A","B","C","D","E","F"]
              
                for i in 0..<Int((CarsTimedata.msg?.count)!){
                    
                    cartypearray.append(CarsTimedata.msg![i].carTypeName!)

               // self.customlabel.names = CarsTimedata.msg![i].carTypeName

               }
                
                self.CustomSlider.tickCount = Int32((CarsTimedata.msg?.count)!)

                print(cartypearray)
           self.customlabel.names = cartypearray
               self.CustomSlider.ticksListener = self.customlabel
                self.valuechange1()
               // self.valueChanged(CustomSlider, event: .t)
                
                
                
            }
            
        }
        
        
        if(GlobalVarible.Api == "distancetype"){
            
            distancedata = data as! DistanceModel
            
            if(distancedata.status == "OK"){
                
                let distance = String(distancedata.rows![0].elements![0].distance!.value!)
                
                totaltime = String(distancedata.rows![0].elements![0].duration!.text!)

                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                
                
                ApiManager.sharedInstance.RideEstimatedScreen(distance, CITYID: GlobalVarible.Cityid, CARTYPEId: GlobalVarible.cartypeid)
                
            }else{
                
                
            }
        }
        
       
        
        
        if(GlobalVarible.Api == "distancetypenew"){
            
            distancedata = data as! DistanceModel
            
        if(distancedata.status == "OK"){
            
            if(distancedata.rows![0].elements![0].status == "OK"){
                
                
                //let distance = String(distancedata.rows![0].elements![0].distance!.value!)
                
                totaltime = String(distancedata.rows![0].elements![0].duration!.text!)
                
                seatnolabel.text = totaltime
                
              //  ApiManager.sharedInstance.protocolmain_Catagory = self
                
                
             //   ApiManager.sharedInstance.RideEstimatedScreen(distance, CITYID: GlobalVarible.Cityid, CARTYPEId: GlobalVarible.cartypeid)
                
            }else{
                
                
            }
                
            }
        }

        
        if(GlobalVarible.Api == "rideestimateresponse"){
            
            ridedata = data as! RideEstimate
            
            
            if(ridedata.result == 0){
                rideestimatelabel.text = NSLocalizedString("No Record Found", comment: "")
                
                rideestimatedtime.text = NSLocalizedString("No Record Found", comment: "")
            }else{
                
                
                
                rideestimatelabel.text =  "LKR " + ridedata.msg!
                
                rideestimatedtime.text = totaltime
                
             //   rideestimatelabel.text =   "Estimated Fare - " +  "$ " + ridedata.msg! + "  " + "Estimated Time -  " + totaltime
                // distancelabel.text = NSLocalizedString("   Approx Total Distance :   ", comment: "") + (mydata.rows![0].elements![0].duration!.text!)
                
            }
            
            
            
        }
        
        
        if(GlobalVarible.Api == "confirmridebook"){
            
            
            //  if(JSON(data)["msg"].stringValue == "Ride Book successfully!!"){
            
            if(JSON(data)["result"] == 1){
                
                 cancel60secrideid = data["details"]!!["ride_id"] as! String
                
                NSNotificationCenter.defaultCenter().postNotificationName("show", object: nil)
                
                self.timerForGetDriverLocation1 = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: #selector(NewMapViewController.getDriverLocation(_:)) , userInfo: nil, repeats: true)
                
            }else{
                
                hiddenview.hidden = true
                self.showalert("Driver Not available")
                print("Ride Book Unsuccessfully")
            }
            
            
        }
        
        
        if(GlobalVarible.Api == "RideLaterBook"){
            
            
            if(JSON(data)["result"] == 1){
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                self.showalert4( NSLocalizedString("Your Ride Book Successfully Date", comment: "") + GlobalVarible.SelectDate +  NSLocalizedString("Time", comment: "") + GlobalVarible.SelectTime)
                
                
                
            }else{
                
                NSNotificationCenter.defaultCenter().postNotificationName("show", object: nil)
                
            }
            
            
            
            
            
        }
        
        if(GlobalVarible.Api == "customersync"){
            
            customersyncdata = data as! CustomerSyncModel
            
            
            if(customersyncdata.result == 0){
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
                
                self.presentViewController(revealViewController, animated:true, completion:nil)
                
            }else
            {
                if(customersyncdata.details?.rideStatus == "3"){
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        self.showalert1( NSLocalizedString("Your Ride is Successfully Booked!!", comment: ""))
                        
                    })
                    
                    GlobalVarible.MatchStringforCancel = "HideCancelButton"
                    
                    
                    
                }
                
                if(customersyncdata.details?.rideStatus == "4"){
                    
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        
                        self.showalert2(NSLocalizedString("Your Ride has been Rejected!!", comment: ""))
                        
                        
                    })
                    
                    
                }
                
                
                if(customersyncdata.details?.rideStatus == "5"){
                    
                    GlobalVarible.CurrentRideStatus = part3
                    
                }
                
                
            }
        }
        

        

    }
    
    func getDriverLocation(timer : NSTimer){
        
         hiddenview.hidden = true
    
       MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        timerForGetDriverLocation1.invalidate()
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.CancelRide60Sec(cancel60secrideid)
        
    
        self.showalert("Driver Not available")
    }

    
    
    func showDialog(notification: NSNotification){
        
        // hiddenview.hidden = true
        let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
        spinnerActivity.detailsLabel.text =  NSLocalizedString("Please Wait!!", comment: "")
        spinnerActivity.userInteractionEnabled = false
        
    }
    
    func hideDialog(notification: NSNotification){
        
        timerForGetDriverLocation1.invalidate()
        
        
        print("Driver Accepted")
        
        
        let totalvalue = notification.userInfo!
        
        print(totalvalue)
        
        
        if let aps = totalvalue["aps"] as? NSDictionary {
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
                
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.customerSync1(part2, UserId: self.Userid!)
                
                                           
                
            }
            
        }
        
        
    }
    
    

   
}



extension NewMapViewController
    
{
    
    func setMarkers(driverId: String ,lat:Double , long: Double , status: Int , cartypeid: String,BearningFactor: String)
    {
        
        
        var Index = -10
        
        for (index , items) in driverIds.enumerate()
        {
            if items == driverId
            {
                
                Index = index
                print(index)
                break
            }
            else
            {
                Index = -10
            }
            
        }
        
        
        print(Index)
        if Index != -10
        {
            
          //  self.seatnolabel.text = totaltime
            print(status)
            
            self.updateMarker(Index ,driverId: driverId , lat: lat , long: long , status: status , cartypeid: cartypeid , degrees: Double(BearningFactor)! , duration: 1.0)


            //self.updateMarker(Index ,driverId: driverId , lat: lat , long: long , status: status , cartypeid: cartypeid)
            
            
        }
        
        if Index == -10 // Means Marker Not Added
        {
            
            if status == 2 {
                
                
                return
                
                
                
            }
                
            else
            {
                
                self.driverIds.append(driverId)
                let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let marker = GMSMarker(position: coordinates)
                
                if cartypeid == "1"{
                    
                    marker.icon = UIImage(named: "ic_car_green_30")
                    //ic_car_green
                }else if cartypeid == "2"{
                    
                    marker.icon = UIImage(named: "ic_sedancar_30")
                }else if cartypeid == "3"{
                    
                    marker.icon = UIImage(named: "ic_luxurycar_30")
                    // ic_luxurycar_30
                }else if cartypeid == "4"{
                    
                    marker.icon = UIImage(named: "car1@30")
                }else if cartypeid == "5"{
                    marker.icon = UIImage(named: "ic_hatchbackcar_30")
                    
                }else if cartypeid == "6"{
                    marker.icon = UIImage(named: "ic_minicar_30")
                    
                }else{
                    
                    marker.icon = UIImage(named: "car@30")
                }
                
               /* if cartypeid == "1"{
                    
                    
                    marker.icon = UIImage(named: "marker")
                    //ic_car_green
                }else if cartypeid == "2"{
                    
                    marker.icon = UIImage(named: "marker@32")
                }else if cartypeid == "3"{
                    
                    marker.icon = UIImage(named: "suvmarker")
                    
                }else if cartypeid == "4"{
                    
                    marker.icon = UIImage(named: "marker@32")
                }else if cartypeid == "5"{
                    marker.icon = UIImage(named: "hatchbackmarker")
                    
                }else if cartypeid == "6"{
                    marker.icon = UIImage(named: "marker@32")
                    
                }else{
                    
                    marker.icon = UIImage(named: "marker")
                }*/
                
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(1.0)
                marker.rotation = Double(BearningFactor)!
                CATransaction.commit()


                
                               
               // marker.icon = UIImage(named: "car_30")
                
                
                // Setting Tags to marker for get Positions
                marker.accessibilityLabel = driverId
                marker.accessibilityValue = String(status)
               
                self.markers.append(marker)
                self.setMarker()
                
                
            }
            
            
            
        }
        
    }
    
    
    
       
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        print("hello")
        
        let index:Int! = Int(marker.accessibilityLabel!)
        
        print(index)
        
        
        
        
    }
    
    
    
}

extension NewMapViewController
{
    func setMarker()
    {
        self.mapview.clear()
        for items in self.markers
        {
            
            
            items.map = mapview
            
        }
        
    }
    
    
   // func updateMarker(index: Int , driverId: String ,lat:Double , long: Double , status: Int , cartypeid: String)
    func updateMarker(index: Int , driverId: String ,lat:Double , long: Double , status: Int , cartypeid: String, degrees: CLLocationDegrees, duration: Double)

    {
        
        
        if status == 2  // Offline
        {
            self.markers.removeAtIndex(index)
            self.driverIds.removeAtIndex(index)
            self.setMarker()
        }
            
        else  // Online
        {
            
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let marker = GMSMarker(position: coordinates)
            
          /*  if cartypeid == "1"{
                
                
                marker.icon = UIImage(named: "marker")
                //ic_car_green
            }else if cartypeid == "2"{
                
                marker.icon = UIImage(named: "marker@32")
            }else if cartypeid == "3"{
               
                marker.icon = UIImage(named: "suvmarker")
                
            }else if cartypeid == "4"{
                
                marker.icon = UIImage(named: "marker@32")
            }else if cartypeid == "5"{
                marker.icon = UIImage(named: "hatchbackmarker")
                
            }else if cartypeid == "6"{
                marker.icon = UIImage(named: "marker@32")
                
            }else{
                
                marker.icon = UIImage(named: "marker")
            }*/
            
            if cartypeid == "1"{
                
                marker.icon = UIImage(named: "ic_car_green_30")
                //ic_car_green
            }else if cartypeid == "2"{
                
                marker.icon = UIImage(named: "ic_sedancar_30")
            }else if cartypeid == "3"{
                
                marker.icon = UIImage(named: "ic_luxurycar_30")
                // ic_luxurycar_30
            }else if cartypeid == "4"{
                
                marker.icon = UIImage(named: "car1@30")
            }else if cartypeid == "5"{
                marker.icon = UIImage(named: "ic_hatchbackcar_30")
                
            }else if cartypeid == "6"{
                marker.icon = UIImage(named: "ic_minicar_30")
                
            }else{
                
                marker.icon = UIImage(named: "car@30")
            }
            
            
            marker.accessibilityLabel = driverId
            marker.accessibilityValue = String(status)
            
            print(degrees)
            CATransaction.begin()
            CATransaction.setAnimationDuration(1.0)
            marker.rotation = degrees
            CATransaction.commit()
            
            // Movement
            CATransaction.begin()
            CATransaction.setAnimationDuration(duration)
            marker.position = coordinates
            
            CATransaction.commit()
           // marker.map = mapview
            self.markers[index] = marker
           self.setMarker()
            
        }
        
        
    }
}

