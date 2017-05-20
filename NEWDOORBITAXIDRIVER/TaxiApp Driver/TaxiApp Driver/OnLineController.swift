//
//  OnLineController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 19/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

import GoogleMaps
import CoreLocation
import Firebase
import MessageUI


class OnLineController: UIViewController ,GMSMapViewDelegate , ParsingStates, CLLocationManagerDelegate ,UITableViewDelegate, UITableViewDataSource , MFMailComposeViewControllerDelegate {
    
    
    
    @IBOutlet weak var displayView: UIView!
    var TextArray = [String]()
    var ImageArray = [String]()
    let imageUrl = API_URLs.imagedomain
  //  var drivername = ""
  //  var driverid = ""
   // var driveremail = ""
    
    @IBOutlet weak var email_id: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var menutable: UITableView!
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet var switchBtn: UISwitch!
    
      @IBOutlet var slidingview: UIView!
    
    let blackView = UIView()

    
    var locationMarker: GMSMarker!
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var currentLocation: String = ""
    var data: OnLineOffline!
    var homeData: DriverHome!
    var driverid = ""
    let locationManager = CLLocationManager()
    let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6)
    
      var navigationlbl = UILabel()
    
    @IBOutlet weak var locationview: UIView!
    var kz = 0
    
    var valuematch = 0
    
       var radiansBearing : Double = 0.0
    
    var ref = FIRDatabase.database().reference()

	@IBOutlet weak var dNameLabel: UILabel!
    @IBOutlet weak var open_menu: UIBarButtonItem!
	@IBOutlet weak var carNoLabel: UILabel!
	@IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var userFinalLocation: UILabel!
    
    var defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
    
    var onoffstatus = ""
    
    var onappstartvalue = 0
    
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
        
        
        profile_image.layer.cornerRadius =  profile_image.frame.width/2
        profile_image.clipsToBounds = true
        profile_image.layer.borderWidth = 1
        profile_image.layer.borderColor = UIColor.blackColor().CGColor
        
        
        TextArray = ["Profile","My Rides","Earnings","Report Issue","Customer Support","Terms Conditions","About Us"]
        
        ImageArray = ["ic_profile_circular","ic_trips","ic_earning-1","system_report","missed_call","ic_terms_condition","ic_about_us"]
        
        
        email_id.text = drivername
        profileName.text = driveremail
        
        let image = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverImage)!
        let newUrl = imageUrl + image
        
        let url = NSURL(string: newUrl)
        profile_image.af_setImageWithURL(url!, placeholderImage: UIImage(named: image),
                                         filter: nil, imageTransition: .CrossDissolve(1.0))
        
        
        self.locationview.layer.borderWidth = 1.0
        self.locationview.layer.cornerRadius = 4
        // Do any additional setup after loading the view, typically from a nib.
         self.navigationController?.navigationBarHidden = false
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      //  self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.startUpdatingLocation()
        valuematch = 0
		
            self.userFinalLocation.text = GlobalVariables.driverLocation
        driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
       // mapView.animateToLocation(CLLocationCoordinate2D(latitude: Double(Lat)!, longitude: Double(Lng)!))
			mapView.delegate = self
			mapView.myLocationEnabled = true
			mapView.settings.myLocationButton = true
        mapView.animateToZoom(15)
       mapView.userInteractionEnabled =  false
        
        onoffstatus = "1"
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.goOnline(driverid, onlineOffline: "1",driverToken: defaultdrivertoken)
        
        
        
		GlobalVariables.tempValue = "0"
		UIApplication.sharedApplication().idleTimerDisabled = true
		
        
       //APIManager.sharedInstance.delegate = self
       // APIManager.sharedInstance.goDriverHome(self.driverid, currentLat: Lat, currentLong: Lng , currentLoc: GlobalVariables.driverLocation, driverToken: defaultdrivertoken)
        
       /* if self.revealViewController() != nil{
            
            open_menu.target = self.revealViewController()
            open_menu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.revealViewController().rearViewRevealWidth = 240.0
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }*/
        
        // ******************* getting notification when app is open ********************

		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.appplicationIsActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.applicationEnteredForeground), name: UIApplicationWillEnterForegroundNotification, object: nil)
		

        carNameLabel.text = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarModelName)! + "/" + NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarName)!
        dNameLabel.text =  NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDrivername)!
        carNoLabel.text =  NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarNo)!
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //locationManager.requestWhenInUseAuthorization()
        
        self.slidingview.alpha = 0
        self.blackView.alpha = 0
        
        
        drivername = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDrivername)!
        driveremail = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverEmail)!
        email_id.text = drivername
        profileName.text = driveremail
        
        let image = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverImage)!
        let newUrl = imageUrl + image
        
        let url = NSURL(string: newUrl)
        profile_image.af_setImageWithURL(url!, placeholderImage: UIImage(named: image),
                                         filter: nil, imageTransition: .CrossDissolve(1.0))
        
        

        
        self.locationManager.requestAlwaysAuthorization()

         valuematch = 0
     
    }
    
    
    
    @IBAction func menubtn(sender: AnyObject) {
        
       /* let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("NewRearTableViewController") as! NewRearTableViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(vc, animated: true, completion:nil)*/
        
          self.eventAnimationPopUp()

        
        
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

    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([ContactEmail])
        mailComposerVC.setSubject(NSLocalizedString("Report Issue Regarding DoorbiTaxi Driver App", comment: ""))
        mailComposerVC.setMessageBody(NSLocalizedString("Sending e-mail in-app is not so bad!", comment: ""), isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        let alert = UIAlertController(title: NSLocalizedString("Could Not Send Email", comment: ""), message: NSLocalizedString("Your device could not send e-mail.  Please check e-mail configuration and try again.", comment: ""), preferredStyle: .Alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // ********************* TableView datasource methods ***************************
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TextArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTable1", forIndexPath: indexPath)
        
        cell.selectionStyle = .None
        
        let imageview :UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        let label : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        let labelshow : UILabel = (cell.contentView.viewWithTag(3) as? UILabel)!
        
        if indexPath.row == 2{
            labelshow.hidden = false
            
        }else{
            labelshow.hidden = true
        }
        
        
        label.text = TextArray[indexPath.row]
        imageview.image = UIImage(named: ImageArray[indexPath.row])
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print("Row:\(row)")
        
        
        
        if (indexPath.row == 0)
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: EditAccountController = storyboard.instantiateViewControllerWithIdentifier("EditAccountController") as! EditAccountController
            self.presentViewController(nextController, animated: true, completion: nil)
            //  self.revealViewController().revealToggleAnimated(true)
            
            
            
        }
        
        if (indexPath.row == 1)
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: YourRideViewController = storyboard.instantiateViewControllerWithIdentifier("YourRideViewController") as! YourRideViewController
            self.presentViewController(nextController, animated: true, completion: nil)
            
            
            // self.revealViewController().revealToggleAnimated(true)
            
            
            
            
        }
        
        if (indexPath.row == 2)
        {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: DriverEarningViewController = storyboard.instantiateViewControllerWithIdentifier("DriverEarningViewController") as! DriverEarningViewController
            self.presentViewController(nextController, animated: true, completion: nil)
            //  self.revealViewController().revealToggleAnimated(true)
            
            
            
            
            
        }
        
        if (indexPath.row == 3)
        {
            
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            //  self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
        if (indexPath.row == 4){
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: CustomSupportViewController = storyboard.instantiateViewControllerWithIdentifier("CustomSupportViewController") as! CustomSupportViewController
            self.presentViewController(nextController, animated: true, completion: nil)
            
            
            
            // UIApplication.sharedApplication().openURL(NSURL(string : "tel://\(ContactTelephone)")!)
            
            // self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
        if (indexPath.row == 5){
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: TCController = storyboard.instantiateViewControllerWithIdentifier("TCController") as! TCController
            self.presentViewController(nextController, animated: true, completion: nil)
            
            // self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
        if(indexPath.row == 6){
            
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: AboutUsController = storyboard.instantiateViewControllerWithIdentifier("AboutUsController") as! AboutUsController
            self.presentViewController(nextController, animated: true, completion: nil)
            //  self.revealViewController().revealToggleAnimated(true)
            
            
            
        }
        
        
        
        
    }
    
    

    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
         // reverseGeocodeCoordinate(location.coordinate)
            Lat = String(location.coordinate.latitude)
            Lng = String(location.coordinate.longitude)
            
            finddistancelat = String(location.coordinate.latitude)

            finddistancelng = String(location.coordinate.longitude)
            
            
            mapView.animateToLocation(CLLocationCoordinate2D(latitude: Double(Lat)!, longitude: Double(Lng)!))
     // locationManager.stopUpdatingLocation()
            
        }
        
    }
    
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
        reverseGeocodeCoordinate(position.target)
    }
    
    func getBearing(toPoint point: CLLocationCoordinate2D) {
        
        
        func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
        func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
        
        let lat1 = degreesToRadians(Double(Lat)!)
        let lon1 = degreesToRadians(Double(Lng)!)
        
        print(Lat)
        
        let lat2 = degreesToRadians(point.latitude);
        let lon2 = degreesToRadians(point.longitude);
        
        print(point.latitude)
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        
        let radiansBearing1 = atan2(y, x);
        
        radiansBearing = (radiansToDegrees(radiansBearing1))
        
        // return radiansToDegrees(radiansBearing)
    }
    


    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D)  {
        
        // 1
        
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                
                //print(address.lines)
            
                GlobalVariables.driverLocation = address.addressLine1()! + " , " + address.addressLine2()!
                
                 self.userFinalLocation.text = GlobalVariables.driverLocation
              //  Lat = String(coordinate.latitude)
              //  Lng = String(coordinate.longitude)
                
                
                if Lat == ""{
                    
                    Lat = String(coordinate.latitude)
                    Lng = String(coordinate.longitude)
                    
                    finddistancelat = String(coordinate.latitude)
                    finddistancelng = String(coordinate.longitude)

                    
                }
                
                
                
                let coordinateTo = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                
                // let coordinateFrom = CLLocation(latitude: 28.4198, longitude: 77.0382)
                
                let pickuplat = Double(finddistancelat)
                
                print(pickuplat)
                
                let pickuplng = Double(finddistancelng)
                
                let coordinateFrom = CLLocation(latitude: pickuplat! , longitude: pickuplng!)
                
                let distanceInMeter =  coordinateFrom.distanceFromLocation(coordinateTo)
                
                print(distanceInMeter)
                
                
                if self.onappstartvalue == 0 {
                
                    let Message: NSDictionary = ["driver_id": self.driverid , "driver_name": self.drivername , "driver_phone": self.driverphone , "driver_email": self.driveremail , "driver_image": self.driverimage , "driver_password": self.driverpassword , "driver_token": self.defaultdrivertoken , "driver_device_id": self.driverdeviceid , "driver_flag": self.driverflag,"driver_rating": "" ,"driver_car_type_id": self.cartypeid ,"driver_model_id": self.drivermodelid ,"driver_number": self.drivercarno , "driver_city_id": self.drivercityid ,"driver_registration_date": "" ,"driver_lisence": "" ,"driver_rc": "" ,"driver_insurence": "" ,"driver_other_doc": "" ,"driver_last_update": "" ,"driver_last_update_date": "" ,"driver_completed_rides": "" ,"driver_rejected_rides": "" ,"driver_cancelled_rides": "" ,"driver_login_logout": "1" ,"driver_busy_status": "" ,"driver_online_offline_status": self.onoffstatus ,"driver_detail_status": "" ,"driver_admin_status": "" ,"driver_car_type_name": self.drivercartypename ,"driver_car_model_name": self.drivercarmodelname ,"driver_current_latitude": Lat ,"driver_current_longitude": Lng ,"driver_location_text": GlobalVariables.driverLocation ,"timestamp": "","bearingfactor": String(self.radiansBearing)]
                    
                    self.ref.child("Drivers_A").child(self.driverid).setValue(Message)
                    
                    
                    APIManager.sharedInstance.delegate = self
                    APIManager.sharedInstance.goDriverHome(self.driverid, currentLat: Lat, currentLong: Lng , currentLoc: GlobalVariables.driverLocation, driverToken: self.defaultdrivertoken)

                self.onappstartvalue = 1
                
                
                
                }
                
                
                if distanceInMeter < 15 {
                    print("hello")
                    print(Lat)
                    
                    
                }else{
                    
                    self.onappstartvalue = 1
                    self.getBearing(toPoint: coordinate)
                    
                    Lat = String(coordinate.latitude)
                    Lng = String(coordinate.longitude)
                    
                    finddistancelat = String(coordinate.latitude)
                    finddistancelng = String(coordinate.longitude)
                    
                    print(Lat)
                    print(coordinate.latitude)
                    

                
                
            if self.onoffstatus == "1"{
                

                
                let Message: NSDictionary = ["driver_id": self.driverid , "driver_name": self.drivername , "driver_phone": self.driverphone , "driver_email": self.driveremail , "driver_image": self.driverimage , "driver_password": self.driverpassword , "driver_token": self.defaultdrivertoken , "driver_device_id": self.driverdeviceid , "driver_flag": self.driverflag,"driver_rating": "" ,"driver_car_type_id": self.cartypeid ,"driver_model_id": self.drivermodelid ,"driver_number": self.drivercarno , "driver_city_id": self.drivercityid ,"driver_registration_date": "" ,"driver_lisence": "" ,"driver_rc": "" ,"driver_insurence": "" ,"driver_other_doc": "" ,"driver_last_update": "" ,"driver_last_update_date": "" ,"driver_completed_rides": "" ,"driver_rejected_rides": "" ,"driver_cancelled_rides": "" ,"driver_login_logout": "1" ,"driver_busy_status": "" ,"driver_online_offline_status": self.onoffstatus ,"driver_detail_status": "" ,"driver_admin_status": "" ,"driver_car_type_name": self.drivercartypename ,"driver_car_model_name": self.drivercarmodelname ,"driver_current_latitude": Lat ,"driver_current_longitude": Lng ,"driver_location_text": GlobalVariables.driverLocation ,"timestamp": "","bearingfactor": String(self.radiansBearing)]
                
                self.ref.child("Drivers_A").child(self.driverid).setValue(Message)
                
                                    
                APIManager.sharedInstance.delegate = self
                APIManager.sharedInstance.goDriverHome(self.driverid, currentLat: Lat, currentLong: Lng , currentLoc: GlobalVariables.driverLocation, driverToken: self.defaultdrivertoken)
                
               }else{
                
                }
                
                }
                
                // print(GlobalVariables.driverLocation)
                //  self.city = address.locality!
                //  GlobalVariables.city = self.city
                //  print(self.city)
                
            }
        }
    }

    
    
    @IBAction func SwtichBtnAction(sender: AnyObject) {
        
        if switchBtn.on {
            
            onoffstatus = "1"
           let Message: NSDictionary = ["driver_id": self.driverid , "driver_name": self.drivername , "driver_phone": self.driverphone , "driver_email": self.driveremail , "driver_image": self.driverimage , "driver_password": self.driverpassword , "driver_token": self.defaultdrivertoken , "driver_device_id": self.driverdeviceid , "driver_flag": self.driverflag,"driver_rating": "" ,"driver_car_type_id": self.cartypeid ,"driver_model_id": self.drivermodelid ,"driver_number": self.drivercarno , "driver_city_id": self.drivercityid ,"driver_registration_date": "" ,"driver_lisence": "" ,"driver_rc": "" ,"driver_insurence": "" ,"driver_other_doc": "" ,"driver_last_update": "" ,"driver_last_update_date": "" ,"driver_completed_rides": "" ,"driver_rejected_rides": "" ,"driver_cancelled_rides": "" ,"driver_login_logout": "1" ,"driver_busy_status": "" ,"driver_online_offline_status": self.onoffstatus ,"driver_detail_status": "" ,"driver_admin_status": "" ,"driver_car_type_name": self.drivercartypename ,"driver_car_model_name": self.drivercarmodelname ,"driver_current_latitude": Lat ,"driver_current_longitude": Lng ,"driver_location_text": GlobalVariables.driverLocation ,"timestamp": "","bearingfactor": String(self.radiansBearing)]
            
            self.ref.child("Drivers_A").child(self.driverid).setValue(Message)
            

            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.goOnline(driverid, onlineOffline: "1",driverToken: defaultdrivertoken)
            
            
            navigationlbl.textColor = UIColor.greenColor()
            
            print("SwOn")
        }else{
            
            print("SwOff")
            
             onoffstatus = "2"
            
           let Message: NSDictionary = ["driver_id": self.driverid , "driver_name": self.drivername , "driver_phone": self.driverphone , "driver_email": self.driveremail , "driver_image": self.driverimage , "driver_password": self.driverpassword , "driver_token": self.defaultdrivertoken , "driver_device_id": self.driverdeviceid , "driver_flag": self.driverflag,"driver_rating": "" ,"driver_car_type_id": self.cartypeid ,"driver_model_id": self.drivermodelid ,"driver_number": self.drivercarno , "driver_city_id": self.drivercityid ,"driver_registration_date": "" ,"driver_lisence": "" ,"driver_rc": "" ,"driver_insurence": "" ,"driver_other_doc": "" ,"driver_last_update": "" ,"driver_last_update_date": "" ,"driver_completed_rides": "" ,"driver_rejected_rides": "" ,"driver_cancelled_rides": "" ,"driver_login_logout": "1" ,"driver_busy_status": "" ,"driver_online_offline_status": self.onoffstatus ,"driver_detail_status": "" ,"driver_admin_status": "" ,"driver_car_type_name": self.drivercartypename ,"driver_car_model_name": self.drivercarmodelname ,"driver_current_latitude": Lat ,"driver_current_longitude": Lng ,"driver_location_text": GlobalVariables.driverLocation ,"timestamp": "","bearingfactor": String(self.radiansBearing)]
            
            self.ref.child("Drivers_A").child(self.driverid).setValue(Message)
            
            
          /*  let Message: NSDictionary = ["current_lat": Lat , "current_long": Lng , "car_type_id": self.cartypeid , "driver_id": self.driverid , "online_offline_status": self.onoffstatus, "busy_status": "" , "login_logout_status": self.loginlogoutstatus , "status": "" , "device": "Iphone"]
            self.ref.child("Driver Location").child(self.driverid).setValue(Message)*/
            
            
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.goOnline(driverid, onlineOffline: "2",driverToken: defaultdrivertoken)
          
            
            navigationlbl.textColor = UIColor.blackColor()
            
        }
        
        
    }
    
    
    // ******************* getting notification when app is open ********************

	
	func appplicationIsActive(notification: NSNotification) {
		print("Application Did Become Active")

	}
	
	func applicationEnteredForeground(notification: NSNotification) {
		print("Application Entered Foreground")

		
	}

    
    // ************************ Context menu click  **************************

    
    @IBAction func context_menu_click(sender: AnyObject) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ContextMenuController") as! ContextMenuController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(vc, animated: true, completion:nil)
    }
	
    
    // ********************* Go Offline click ***************************

    
    
    @IBAction func go_offline_btn(sender: AnyObject) {
		
		if GlobalVariables.tempValue == "1"{
			
			GlobalVariables.tempValue = "0"
			APIManager.sharedInstance.goOnline(driverid, onlineOffline: "2",driverToken: defaultdrivertoken)
		}
    }
	
    
    // ********************* Success state ***************************
    

    func onSuccessState(data: AnyObject , resultCode: Int) {
		
        if (resultCode == 88){
        self.data = data as! OnLineOffline
            if(self.data.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
            }else if(self.data.result == 1){
                
                self.showAlertMessage("", Message: (self.data.msg!))
                
                /*let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let nextController: SWRevealViewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
                 self.presentViewController(nextController, animated: true, completion: nil)*/
            }
    }
        if (resultCode == 121){
            
            self.homeData = data as! DriverHome
            
            
          //  APIManager.sharedInstance.delegate = self
          //  APIManager.sharedInstance.goOnline(driverid, onlineOffline: "1",driverToken: defaultdrivertoken)
            
            if(self.homeData.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
            }
            
        }
        
        
    }
    
    
    func showAlertMessage(title:String,Message:String){
        
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .Alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}
    }
    
    
    


}


extension UIView
    
{
    func slideLeft()
    {
        
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.layer.addAnimation(transition, forKey: kCATransition)
    }
    
    
    
    func slideRight()
    {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.layer.addAnimation(transition, forKey: kCATransition)
        
        
    }
}
