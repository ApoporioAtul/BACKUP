//
//  TrackRideViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 19/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import GoogleMaps
import AlamofireImage
import SwiftyJSON
import Alamofire
import StarryStars
import MapKit
import CoreLocation
import Firebase

var trackrideviewcontroller : TrackRideViewController!


class TrackRideViewController: UIViewController,CLLocationManagerDelegate, RatingViewDelegate,MainCategoryProtocol,GMSMapViewDelegate {
    
    var part1: String = ""
    var part2: String = ""
    var part3: String = ""
    var driverdata: DriverInfo!
    var trackdata: DriveTrackModel!
    var Doneridedata : DoneRideModel!
    
      var drivertrackdata : DriveTrackModel!
    
    let imageUrl = API_URL.imagedomain
    
    @IBOutlet weak var customerlocation: UILabel!
    
    @IBOutlet weak var showlocationview: UIView!
    
      @IBOutlet weak var customerlocationimage: UIImageView!
    
    @IBOutlet weak var googlemapnavigationbtn: UIButton!
    
    @IBOutlet weak var googlebtnimageview: UIImageView!
    
    var Timer = NSTimer()

    
    
    @IBOutlet weak var cancelbutton: UIButton!
      
    @IBOutlet weak var ratingview: RatingView!
    
    @IBOutlet weak var drivername: UILabel!
    
     var timerForGetDriverLocation = NSTimer()
    @IBOutlet weak var Carno: UILabel!
   
    @IBOutlet weak var driverimage: UIImageView!
    let tasks = DirectionButton()
    var originMarker: GMSMarker!
     var destinationMarker: GMSMarker!
     var routePolyline: GMSPolyline!
    
    var Currentrideid = ""
    
    var currentStatus = ""
     var currentmessage = ""
    var startlat = ""
    var startlng = ""
    var destinationlat = ""
    var destinationlng = ""

    var ref = FIRDatabase.database().reference()
    

    var x = 0
    var k = 0
    
    var DRIVERLAT = " "
    var DRIVERLNG = " "
    var PickupLoc = ""
    var Drivercurrentaddress = ""
    var Driverdroplocation = ""
    
    @IBOutlet weak var mapview: GMSMapView!
    var mydatapage: DriverInfo!
    let locationManager = CLLocationManager()

    private let googleMapsKey = "AIzaSyAwdw2gOgLTM_lAjEtVvIH87xHx3RTKEUQ"
    private let baseURLString = "https://maps.googleapis.com/maps/api/directions/json?"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackrideviewcontroller = self
        
        
        showlocationview.layer.borderWidth = 1
        showlocationview.layer.borderColor = UIColor.grayColor().CGColor
        showlocationview.layer.cornerRadius = 8
        showlocationview.clipsToBounds = true
        
        googlemapnavigationbtn.hidden = true
        googlebtnimageview.hidden = true
        k = 0
        
        // mapview.animateToZoom(15)
        mapview.myLocationEnabled = true
        
        GlobalSelcetvaluue = 1
        
        latroute.removeAll()
         longroute.removeAll()
        
        GlobalVarible.rideendstopupdatelocation = 0

        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.DriverInformation(Currentrideid)
        
        GlobalVarible.StringMatchPayment = "hellohi"
        
        mapview.delegate = self
        
             
    }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ratingView(ratingView: RatingView, didChangeRating newRating: Float) {
        print("newRating: \(newRating)")
        
    }
    
    @IBAction func backbtn(sender: AnyObject) {
        
        GlobalVarible.trackbackbtnvaluematch = 1
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if(currentStatus == "5"){
            
            self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        if(currentStatus == "6"){
            self.presentingViewController!.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
            
        }

        
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        //If map is being used
        if status == .AuthorizedAlways{
            var myLocation = mapview
            self.locationManager.startUpdatingLocation()
           //  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
           mapview.myLocationEnabled = true
            // mapview.settings.myLocationButton = true
        }
    }
    
   
 /*   func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first  {
            
        //    reverseGeocodeCoordinate(location.coordinate)
            
             mapview.animateToLocation(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
           mapview.animateToZoom(15)
         
          //  locationManager.stopUpdatingLocation()
        }
    }
    
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
      
        reverseGeocodeCoordinate(position.target)
    }*/
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first  {
            
          //  mapview.animateToLocation(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
         //   mapview.animateToZoom(15)

            print(location)
            //  location_route_data.append(location)
            
           if GlobalVarible.rideendstopupdatelocation == 0
                {
                    
            }else{
                
           self.locationManager.stopUpdatingLocation()
            }
            
            reverseGeocodeCoordinate(location.coordinate)
            
            
        }
    }
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                if self.currentStatus == "6" {
                    redrawRoute(self.mapview, lat: coordinate.latitude , lng: coordinate.longitude)
                }
            }
        }
        
        
        
    }
    
    
    func createRoute(){
        //let origin = PickupLoc
       // let destination = Driverdroplocation
        let origin = startlat + "," + startlng
        let destination = destinationlat + "," + destinationlng
        
        self.tasks.getDirections(origin, destination: destination, waypoints: nil, travelMode: nil, completionHandler: { (status, success) -> Void in
            if success {
                self.configureMapAndMarkersForRoute()
                self.drawRoute()
                //self.displayRouteInfo()
            }
            else {
                print(status)
            }
        })
    }
    
    func configureMapAndMarkersForRoute() {
        
        mapview.camera = GMSCameraPosition.cameraWithTarget(tasks.originCoordinate, zoom: 9.0)
        
        
        originMarker = GMSMarker(position: self.tasks.originCoordinate)
      //  originMarker.map = self.mapview
        
        
     //   Map.addAnnotation(info1)
        
        if x == 0{
            originMarker.icon = UIImage(named: "car_30")
          originMarker.title = self.tasks.originAddress
            
            
            self.customerlocation.text = self.tasks.originAddress
            customerlocationimage.image = UIImage(named: "Record-25") as UIImage?
            
        }else{
            
           originMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
            
            self.customerlocation.text = self.tasks.destinationAddress
            customerlocationimage.image = UIImage(named: "Record-25 (1)") as UIImage?
        }

        
       // originMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        originMarker.title = self.tasks.originAddress
        
         originMarker.map = self.mapview
        
        destinationMarker = GMSMarker(position: self.tasks.destinationCoordinate)
     //   destinationMarker.map = self.mapview
        if x == 0{
            destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        }else{
            destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.greenColor())
        }

      //  destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.greenColor())
        destinationMarker.title = self.tasks.destinationAddress
        
        destinationMarker.map = self.mapview

    }
    
    func drawRoute() {
        let route = tasks.overviewPolyline["points"] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)!
        routePolyline = GMSPolyline(path: path)
        routePolyline.strokeWidth = 5.0
        routePolyline.strokeColor = TrackRideViewController.getColorFromHex("70C1F8")
        routePolyline.map = mapview
        self.mapview.animateToZoom(14)
    }
    class func getColorFromHex(hexString:String)->UIColor{
        
        var rgbValue : UInt32 = 0
        let scanner:NSScanner =  NSScanner(string: hexString)
        
        scanner.scanLocation = 1
        scanner.scanHexInt(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }

    
    func starttimer(){
        
        
       /* if self.k == 1{
            self.Timer  = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(TrackRideViewController.myPerformeCode1(_:)), userInfo: nil, repeats: true)
            
        }else{
            
            
        }*/
        
                
        ref.child("Track Ride Before Arrived").observeEventType(.Value, withBlock: { (snapshot) in
            
             self.mapview.clear()
            
            
            
            for items in snapshot.children
            {
                
                // let cartypeid = items.value["car_type_id"] as! String
                //  let onoffstatus = items.value["online_offline_status"] as! String
                //   let loginstatus = items.value["login_logout_status"] as! String
                
                //  if(cartypeid == GlobalVarible.car_type_id && onoffstatus == "1" && loginstatus == "1"){
                
                if(items.key! == GlobalVarible.RideId){
                    
                    
                    let latitude = items.value["current_lat"] as! String
                    let longitude = items.value["current_long"] as! String
                    // let status = items.value["online_offline_status"] as! String
                    
                    
                    self.cresterootviatrack(latitude, long: longitude)
                    
                    
                }else{
                    
                                    
                }
                
                
                
            }
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        

            
        
    }
    
    
    func myPerformeCode1(timer : NSTimer) {
        
        
        ref.child("Track Ride Before Arrived").observeEventType(.Value, withBlock: { (snapshot) in
            
            
             self.mapview.clear()
            
            
            for items in snapshot.children
            {
                
               // let cartypeid = items.value["car_type_id"] as! String
                //  let onoffstatus = items.value["online_offline_status"] as! String
                //   let loginstatus = items.value["login_logout_status"] as! String
                
                //  if(cartypeid == GlobalVarible.car_type_id && onoffstatus == "1" && loginstatus == "1"){
                
                if(items.key! == GlobalVarible.RideId){
                    
                    
                    let latitude = items.value["current_lat"] as! String
                    let longitude = items.value["current_long"] as! String
                   // let status = items.value["online_offline_status"] as! String
                    
                    
                    self.cresterootviatrack(latitude, long: longitude)
                    
                    
                    
                }else{
                    
                                   
                    
                }
                
                
                
            }
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        

        
       // ApiManager.sharedInstance.protocolmain_Catagory = self
      //  ApiManager.sharedInstance.TrackDriver(Currentrideid)
        
      //  mapview.clear()
        
      //  self.createRoute()

    }
    
    

    
    func cresterootviatrack(lat: String , long: String){
        
        let coordinates = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        let marker = GMSMarker(position: coordinates)
        marker.icon = UIImage(named: "car_30")
        // Setting Tags to marker for get Positions
     //   marker.accessibilityLabel = driverId
      //  marker.accessibilityValue = String(status)
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        marker.position =  coordinates
        CATransaction.commit()
        marker.map = mapview
      //  self.markers[index] = marker
      //  self.setMarker()


        
     /*  var markerView: UIImageView?
        
        let house = UIImage(named: "car_30")!.imageWithRenderingMode(.AlwaysOriginal)
        let markerViewImage = UIImageView(image: house)
        markerView = markerViewImage
        
        let position = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
        
        let marker = GMSMarker(position: position)
        
        
        marker.groundAnchor = CGPointMake(0.5, 0.5)
        
        marker.appearAnimation = kGMSMarkerAnimationPop
        
        marker.iconView = markerView!
        marker.tracksViewChanges = true
        marker.map = mapview*/

  


      }
    
    
    

    @IBAction func CancelRide(sender: AnyObject) {
        
        k = 0
        self.Timer.invalidate()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewControllerWithIdentifier("ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)
        
               
    }
  
  /*  func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:SWRevealViewController = storyBoard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
                
                self.presentViewController(revealViewController, animated:true, completion:nil)
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }*/
    
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
    
    
    @IBAction func CallDriverbtn(sender: AnyObject) {
         UIApplication.sharedApplication().openURL(NSURL(string : "tel://\(GlobalVarible.driverphonenumber)")!)
        
    }
    
    
    @IBAction func googlemapnavigationbtn(sender: AnyObject) {
        
       UIApplication.sharedApplication().openURL(NSURL(string:
            "comgooglemaps-x-callback://?saddr=&daddr=\(GlobalVarible.UserDropLat),\(GlobalVarible.UserDropLng)&directionsmode=driving")!)
        

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
                
                k = 1
                
                startlat = mydatapage.details!.pickupLat!
                startlng = mydatapage.details!.pickupLong!
                
                destinationlat = mydatapage.details!.driverLat!
                destinationlng = mydatapage.details!.driverLong!
                
                self.customerlocation.text = mydatapage.details!.pickupLocation
                
                customerlocationimage.image = UIImage(named: "Record-25") as UIImage?
                
                PickupLoc = (mydatapage.details!.pickupLocation)!
               // Drivercurrentaddress = (mydatapage.message?.currentAddress)!
                
               // Driverdroplocation = (mydatapage.details!.dropLocation)!
                
                Driverdroplocation = mydatapage.details!.driverLocation!
                
                GlobalVarible.RideId = (mydatapage.details!.rideId)!
                GlobalVarible.driverphonenumber = (mydatapage.details!.driverPhone)!
                drivername.text = mydatapage.details!.driverName
                
                Carno.text = mydatapage.details!.carNumber
                
                let driverlat = Double((mydatapage.details!.driverLat)!)!
                let driverlng = Double((mydatapage.details!.driverLong)!)!
                
                
                DRIVERLAT  = String(format:"%f", driverlat)
                DRIVERLNG  = String(format:"%f", driverlng)

                
                mapview.animateToLocation(CLLocationCoordinate2D(latitude: driverlat, longitude: driverlng))
                mapview.animateToZoom(15)

                
                
                let driverratingvalue = mydatapage.details?.driverRating
                
                if driverratingvalue == ""{
                    print("hjjk")
                }else{
                    
                    ratingview.rating = Float(driverratingvalue!)!
                   
                }

                  
                let drivertypeimage = mydatapage.details!.driverImage
                
                print(drivertypeimage!)
                
                if(drivertypeimage == ""){
                    driverimage.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    let newUrl = imageUrl + drivertypeimage!
                    
                   // let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                   // print(url)
                    
                    let url1 = NSURL(string: newUrl)
                    driverimage!.af_setImageWithURL(url1!,
                                                    placeholderImage: UIImage(named: "dress"),
                                                    filter: nil,
                                                    imageTransition: .CrossDissolve(1.0))
                }
                
                
                if(currentStatus == "5"){
                    
                    k = 0
                    self.Timer.invalidate()
                    
                    cancelbutton.hidden = true
                    // showTextToast(currentmessage)
                    self.showalert1(currentmessage)
                    
                    
                }else{
                    // ApiController.sharedInstance.ViewRideInfo(BookingID)
                    k = 0
                    self.Timer.invalidate()
                    

                    cancelbutton.hidden = false
                    
                }
                
                if(currentStatus == "6"){
                    
                    k = 0
                    self.Timer.invalidate()
                    
                    self.customerlocation.text = mydatapage.details!.dropLocation
                    customerlocationimage.image = UIImage(named: "Record-25 (1)") as UIImage?
                    
                   // destinationlat = mydatapage.details!.dropLat!
                  //  destinationlng = mydatapage.details!.dropLong!
                    
                      destinationlat = String(GlobalVarible.UserDropLat)
                    destinationlng =  String(GlobalVarible.UserDropLng)

                    
                  Driverdroplocation = (mydatapage.details!.dropLocation)!
                    
                      x = 1
                     cancelbutton.hidden = true
                    googlemapnavigationbtn.hidden = false
                    googlebtnimageview.hidden = false
                    self.showalert1(currentmessage)
                }
                else{
                     k = 0
                    self.Timer.invalidate()


                    googlemapnavigationbtn.hidden = true
                    googlebtnimageview.hidden = true
                    
                }
                

                
                
                
                
                self.locationManager.delegate = self
                self.locationManager.startUpdatingLocation()
                //self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

                
                //set out a marker on the map
               // self.createRoute()
                
                if (currentStatus == "5"){
                    
                  //  startlat = mydatapage.details!.beginLat!
                  //  startlng = mydatapage.details!.beginLong!
                    
                    
                    destinationlat = mydatapage.details!.dropLat!
                    destinationlng = mydatapage.details!.dropLong!
                    
                  self.createRoute()

                    print("status5")
                }else if (currentStatus == "6"){
                    mapview.clear()
                    
                    destinationlat = mydatapage.details!.dropLat!
                    destinationlng = mydatapage.details!.dropLong!
                    
                    self.createRoute()
                    self.locationManager.delegate = self
                 //   self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                  //  self.locationManager.requestAlwaysAuthorization()
                    self.locationManager.startUpdatingLocation()


                    print("status6")
                }else{
                    self.starttimer()
                    
                }
                
                
                
            }else{
                
                print("Hello")
                
                
            }
            
            
            
        }
        
        
        if(GlobalVarible.Api == "DriverTrack"){
            
            
            drivertrackdata = data as! DriveTrackModel
            
            if(drivertrackdata.result == 0){
                
                print("No Record")
                
            }else{
                
                destinationlat = drivertrackdata.details!.driverLat!
                destinationlng = drivertrackdata.details!.driverLong!
                
                //   Driverdroplocation = drivertrackdata.details!.driverLocation!
                
               // mapview.clear()
                
                //self.createRoute()
            }
        }

        
               
    }
    
    
     
    
}








