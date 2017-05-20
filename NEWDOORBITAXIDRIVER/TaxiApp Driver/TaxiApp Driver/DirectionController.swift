//
//  DirectionController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 31/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//
import UIKit
import CoreLocation
import GoogleMaps
import KVNProgress

class DirectionController: UIViewController , CLLocationManagerDelegate , ParsingStates {
    
    @IBOutlet weak var cancelbtn: UIButton!
    
    var cityid: String = ""
    var cartypeid: String = ""
    var begin_time: String = ""
    var end_time: String = ""
    var begin_sec: Int = 0
    var end_sec: Int = 0
    var waiting_time: String = ""
    var ride_time:String = ""
    let locationManager = CLLocationManager()
    let tasks = DirectionButton()
    var originMarker: GMSMarker!
    var data: RideEnd!
    var destinationMarker: GMSMarker!
    var beginData: RideBegin!
    var routePolyline: GMSPolyline!
    var count = 0
    var defaultdriverid = ""
    var Timer = NSTimer()
    var trackData: TrackRide!
    
    @IBOutlet weak var begin_trip: CustomButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var dropLocField: UILabel!
    @IBOutlet weak var end_trip: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        defaultdriverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
        
        if(GlobalVariables.ridecurrentstatus == "6"){
            
            let currentDateTime = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Hour,.Minute,.Second], fromDate: currentDateTime)
            let hour = components.hour
            let min = components.minute
            let sec = components.second
            let h = String(hour)
            let m = String(min)
            let s = String(sec)
            self.begin_time =  h + ":" + m + ":" + s
            self.begin_sec = sec + (60 * min) + (3600 * hour)
            //GlobalVariables.beginSec = self.begin_sec
            print("Begin_sec: \(self.begin_sec)")
            let waiting_sec = self.begin_sec - GlobalVariables.arrived_sec
            print("Waiting_sec: \(waiting_sec)")
            let hours1 = waiting_sec / 3600
            let minutes1 = (waiting_sec % 3600) / 60
            let seconds1 = waiting_sec % 60
            let h1 = String(hours1)
            let m1 = String(minutes1)
            let s1 = String(seconds1)
            self.waiting_time = h1 + ":" + m1 + ":" + s1
            print("Waiting_time: \(self.waiting_time)")
            
            self.begin_trip.hidden = true
            self.end_trip.hidden = false
            
            self.createRoute()
        
        }else{
         end_trip.hidden = true
        }
        
       // end_trip.hidden = true
       
        dropLocField.layer.cornerRadius = 5
        dropLocField.layer.borderWidth = 1
        dropLocField.layer.borderColor = UIColor.blackColor().CGColor
        
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        let finalLat = Double(GlobalVariables.pickupLat)
        let finalLong = Double(GlobalVariables.pickupLong)
       // let position = CLLocationCoordinate2DMake(finalLat! , finalLong!)
       // self.setuplocationMarker(position)
  
        mapView.animateToLocation(CLLocationCoordinate2D(latitude: finalLat!, longitude: finalLong! ))
        
        mapView.animateToZoom(15)
        self.cityid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCityId)!
        self.cartypeid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyCarType)!
        dropLocField.text = GlobalVariables.dropLocation
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   /* @IBAction func cancel_btn_click(sender: AnyObject) {
        
           Timer.invalidate()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewControllerWithIdentifier("ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)
        

    }*/
    
    
    
    
    // ********************* On back click dismiss vc ***************************

    
    @IBAction func back_btn_press(sender: AnyObject) {
        dismissViewcontroller()
    }
    
    
    // ******************* click to view customer information ********************


    @IBAction func info_click(sender: AnyObject) {
        
           Timer.invalidate()
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ContextMenuController") as! ContextMenuController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(vc, animated: true, completion:nil)
           /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: CustomerInfoController = storyboard.instantiateViewControllerWithIdentifier("CustomerInfoController") as! CustomerInfoController
            
            self.presentViewController(next, animated: true, completion: nil)*/
       
    }
    
    
   
    // ******************* begin trip click ********************

    
        @IBAction func begin_trip_click(sender: AnyObject) {
         
            
            let refreshAlert = UIAlertController(title: "", message: NSLocalizedString("Do you want to change the status of ride ? ", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                    
                    
                        KVNProgress.show()
                        
                        let currentDateTime = NSDate()
                        let calendar = NSCalendar.currentCalendar()
                        let components = calendar.components([.Hour,.Minute,.Second], fromDate: currentDateTime)
                        let hour = components.hour
                        let min = components.minute
                        let sec = components.second
                        let h = String(hour)
                        let m = String(min)
                        let s = String(sec)
                        self.begin_time =  h + ":" + m + ":" + s
                        self.begin_sec = sec + (60 * min) + (3600 * hour)
                        //GlobalVariables.beginSec = self.begin_sec
                        print("Begin_sec: \(self.begin_sec)")
                        let waiting_sec = self.begin_sec - GlobalVariables.arrived_sec
                        print("Waiting_sec: \(waiting_sec)")
                        let hours1 = waiting_sec / 3600
                        let minutes1 = (waiting_sec % 3600) / 60
                        let seconds1 = waiting_sec % 60
                        let h1 = String(hours1)
                        let m1 = String(minutes1)
                        let s1 = String(seconds1)
                        self.waiting_time = h1 + ":" + m1 + ":" + s1
                        print("Waiting_time: \(self.waiting_time)")
                        //GlobalVariables.waitingTime = self.waiting_time
                        
                        
                        //mapView.clear()
                        KVNProgress.dismiss()
                       APIManager.sharedInstance.delegate = self
                        APIManager.sharedInstance.rideBegin(GlobalVariables.rideid, bLat: GlobalVariables.pickupLat, bLong: GlobalVariables.pickupLong, bLocation: GlobalVariables.pickupLoc, bTime: self.begin_time , driverId: self.defaultdriverid)
                        
                        
                        self.begin_trip.hidden = true
                        self.end_trip.hidden = false
                        
                        self.createRoute()
                    
                }))
                
                refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                    
                    refreshAlert .dismissViewControllerAnimated(true, completion: nil)
                    
                    
                }))
                
                presentViewController(refreshAlert, animated: true, completion: nil)
            
    }
    
    
    // ******************* end trip click ********************

    
    
    @IBAction func end_trip_click(sender: AnyObject) {
        
        
                    Timer.invalidate()
           let refreshAlert = UIAlertController(title: "", message: NSLocalizedString("Do you want to change the status of ride ? ", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                
                    KVNProgress.show()
                    
                    
                    let currentDateTime = NSDate()
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Hour,.Minute,.Second], fromDate: currentDateTime)
                    let hour = components.hour
                    let min = components.minute
                    let sec = components.second
                    let hh = String(hour)
                    let mm = String(min)
                    let ss = String(sec)
                    self.end_time =  hh + ":" + mm + ":" + ss
                    self.end_sec = sec + (60 * min) + (3600 * hour)
                    print("End_sec: \(self.end_sec)")
                    
                    let ride_sec = self.end_sec - self.begin_sec
                    print("Ride_sec: \(ride_sec)")
                    let hours1 = ride_sec / 3600
                    let minutes1 = (ride_sec % 3600) / 60
                    let seconds1 = ride_sec % 60
                    let h1 = String(hours1)
                    let m1 = String(minutes1)
                    let s1 = String(seconds1)
                    self.ride_time = h1 + ":" + m1 + ":" + s1
                    print("Ride_time: \(self.ride_time)")
                    KVNProgress.dismiss()
                    self.locationManager.stopUpdatingLocation()
                    APIManager.sharedInstance.delegate = self
                    APIManager.sharedInstance.rideEnd(GlobalVariables.rideid, bLat: GlobalVariables.pickupLat, bLong: GlobalVariables.pickupLong, bLocation: GlobalVariables.pickupLoc, eLat: GlobalVariables.dropLat, eLong: GlobalVariables.dropLong, eLocation: GlobalVariables.dropLocation, eTime: self.end_time, driverid: self.defaultdriverid, waitingTime: self.waiting_time, rideTime: self.ride_time, dist: "0")
                
      }))
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                refreshAlert .dismissViewControllerAnimated(true, completion: nil)
                
                
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
        
    }

    
    // ******************* CLLocationManager delegate methods  ********************

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
           reverseGeocodeCoordinate(location.coordinate)
            
            // mapView.animateToLocation(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            
            
           // mapView.animateToZoom(15)
            
           //  self.locationManager.stopUpdatingLocation()
            
        }
        
    }
    
   /* func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
        reverseGeocodeCoordinate(position.target)
    }*/
    
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                
                let lines = address.lines 
                print("Current loc: \(lines!.joinWithSeparator("\n"))")
               
                let dropLocation = lines!.joinWithSeparator("\n")
                let dropLat = String(coordinate.latitude)
                let dropLong = String(coordinate.longitude)
                
                
                print("DropLoc : \(dropLocation)")
                print("DropLat : \(dropLat)")
                print("DropLong : \(dropLong)")
                print(GlobalVariables.cartypeid)
                print(GlobalVariables.cityid)
                KVNProgress.dismiss()
                
                APIManager.sharedInstance.delegate = self
                APIManager.sharedInstance.trackRide(GlobalVariables.rideid, driverid: self.defaultdriverid, driverLat: dropLat, driverLong: dropLong)

                
            }
            
        }
        
    }

    
    // ********************* Set marker on particular location ***************************

    
    func setuplocationMarker(coordinate: CLLocationCoordinate2D) {
    
    
    let marker = GMSMarker(position: coordinate)
    marker.title = GlobalVariables.pickupLoc
    marker.icon = UIImage(named: "car_ola")
    marker.map = mapView
    
       
    }
    
    func droplocationMarker(coordinate: CLLocationCoordinate2D) {
        
        
        let marker = GMSMarker(position: coordinate)
        marker.title = GlobalVariables.dropLocation
        marker.icon = UIImage(named: "marker_30_black")
        marker.map = mapView
        
        
    }

    
    
    // ********************* Creating route methods ***************************

    func createRoute(){
       // let origin = GlobalVariables.pickupLoc
      //  let destination = GlobalVariables.dropLocation
        
        let origin = GlobalVariables.pickupLat + "," + GlobalVariables.pickupLong
        let destination = GlobalVariables.dropLat + "," + GlobalVariables.dropLong

        
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
        mapView.camera = GMSCameraPosition.cameraWithTarget(tasks.originCoordinate, zoom: 9.0)
        
        
        originMarker = GMSMarker(position: self.tasks.originCoordinate)
        originMarker.map = self.mapView
        originMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        originMarker.title = self.tasks.originAddress
        
        destinationMarker = GMSMarker(position: self.tasks.destinationCoordinate)
        destinationMarker.map = self.mapView
        destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.greenColor())
        destinationMarker.title = self.tasks.destinationAddress
        
    }
    
    func drawRoute() {
        let route = tasks.overviewPolyline["points"] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)!
        routePolyline = GMSPolyline(path: path)
        routePolyline.strokeWidth = 5.0
        routePolyline.strokeColor = DirectionController.getColorFromHex("70C1F8")
        routePolyline.map = mapView
         self.mapView.animateToZoom(14)
    }
    
    
    // ********************* get color from hexcode  ***************************

    class func getColorFromHex(hexString:String)->UIColor{
        
        var rgbValue : UInt32 = 0
        let scanner:NSScanner =  NSScanner(string: hexString)
        
        scanner.scanLocation = 1
        scanner.scanHexInt(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    
    
    // ********************* Textfield delegate ***************************

    
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    
    
    // ********************* Timer function ***************************
    
    
    func myPerformeCode1(timer : NSTimer) {
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.startUpdatingLocation()
        
    }

    
    // ********************* Success state ***************************

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        if (resultCode == 209){
            self.data = data as! RideEnd
            
            
            if(self.data.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
                
            }else if (self.data.result == 1){
                GlobalVariables.matchString = "my"
                GlobalVariables.totalamount = (self.data.details?.amount!)!
                GlobalVariables.totaldistance = (self.data.details?.distance!)!
                GlobalVariables.totaltime = (self.data.details?.totTime!)!
                GlobalVariables.rideid = (self.data.details?.rideId!)!
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: RideFareController = storyboard.instantiateViewControllerWithIdentifier("RideFareController") as! RideFareController
                
                self.presentViewController(next, animated: true, completion: nil)
            }else{
                
            }
        }
        if (resultCode == 220){
            self.beginData = data as! RideBegin
            
            
            if(self.beginData.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
                
            }else if self.beginData.result == 1 {
                let alert = UIAlertController(title: "", message:NSLocalizedString(" Ride Started", comment: ""), preferredStyle: .Alert)
                let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}

                Timer  = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(DirectionController.myPerformeCode1(_:)), userInfo: nil, repeats: true)
            }else{
                
            }
        }
        
        if resultCode == 253{
            self.trackData = data as! TrackRide
            
            if(self.trackData.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
                
            }

        }
    }

   }