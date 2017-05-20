//
//  DirectController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 01/09/16.
//  Copyright © 2016 Apporio. All rights reserved.
//


import UIKit
import GoogleMaps
import CoreLocation
import Firebase

class DirectController: UIViewController , CLLocationManagerDelegate , ParsingStates ,GMSMapViewDelegate{
    
    @IBOutlet weak var cancelbtn: UIButton!
    
    var lat: Double = 0.0
    var long: Double = 0.0
    let locationManager = CLLocationManager()
    var currentLocation: String = ""
    var arrive_time: String = ""
    var arrive_sec: Int = 0
    var data: Arrived!
    var updateData: UpdateDriverLocation!
    var driverid = ""
    
    let tasks = DirectionButton()
    var originMarker: GMSMarker!
    var destinationMarker: GMSMarker!
    var routePolyline: GMSPolyline!
    
    var ref = FIRDatabase.database().reference()

    
    var timerForGetDriverLocation = NSTimer()
    
    var k = 0

    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pickLoc: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
        
        lat = Double(GlobalVariables.pickupLat)!
        long = Double(GlobalVariables.pickupLong)!
        pickLoc.text = GlobalVariables.pickupLoc
        
          k = 0
        self.locationManager.delegate = self
         self.locationManager.startUpdatingLocation()
        mapView.delegate = self
        
        GlobalVariables.ridecurrentstatus = ""
       // self.timerForGetDriverLocation = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: #selector(DirectController.getDriverLocation(_:)) , userInfo: nil, repeats: true)
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.startUpdatingLocation()
        
       mapView.userInteractionEnabled =  false
        
        mapView.settings.myLocationButton = true
     //   mapView.animateToLocation(CLLocationCoordinate2D(latitude: lat , longitude: long))
        
        mapView.animateToZoom(15)
      //  self.createRoute()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ********************* On back click dismiss vc ***************************

    
    @IBAction func back_click(sender: AnyObject) {
        dismissViewcontroller()
    }
    
   /* @IBAction func cancel_btn(sender: AnyObject) {
        
        timerForGetDriverLocation.invalidate()
        k = 1

        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewControllerWithIdentifier("ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)
        
        
    }*/
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        timerForGetDriverLocation.invalidate()
        k = 1
        
    }

    
   
    // ******************* click to view customer information ********************

    
    @IBAction func info_pressed(sender: AnyObject) {
        
        timerForGetDriverLocation.invalidate()
        k = 1

        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ContextMenuController") as! ContextMenuController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(vc, animated: true, completion:nil)
        
         /*   let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: CustomerInfoController = storyboard.instantiateViewControllerWithIdentifier("CustomerInfoController") as! CustomerInfoController
            
            self.presentViewController(next, animated: true, completion: nil)*/
        
    }
    
    
    // ******************* arrived button click ********************

    
    @IBAction func arrived_click(sender: AnyObject) {
        
        timerForGetDriverLocation.invalidate()
        self.locationManager.stopUpdatingLocation()
        
        k = 1
        

            
           let refreshAlert = UIAlertController(title: "", message: NSLocalizedString("Do you want to change the status of ride ? ", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                
                    print("arrived click")
                    let currentDateTime = NSDate()
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Hour,.Minute,.Second], fromDate: currentDateTime)
                    let hour = components.hour
                    let min = components.minute
                    let sec = components.second
                    let h = String(hour)
                    let m = String(min)
                    let s = String(sec)
                    self.arrive_time =  h + ":" + m + ":" + s
                    self.arrive_sec = sec + (60 * min) + (3600 * hour)
                    GlobalVariables.arrived_sec = self.arrive_sec
                    //GlobalVariables.arriveTime = self.arrive_time
                    APIManager.sharedInstance.delegate = self
                    APIManager.sharedInstance.driverArrived(GlobalVariables.rideid, driverid: self.driverid, arrTime: self.arrive_time)
               
           }))
            
            refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
                
                refreshAlert .dismissViewControllerAnimated(true, completion: nil)
                
                
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
        
    }
    
    
    // ******************* CLLocationManager delegate methods  ********************

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
           // reverseGeocodeCoordinate(location.coordinate)
           
            
            mapView.animateToLocation(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
           

            
            mapView.animateToZoom(15)
            
          //  self.locationManager.stopUpdatingLocation()
            
        }
        
    }
    
   func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
        reverseGeocodeCoordinate(position.target)
    }

    
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                self.mapView.clear()
                
                let lines = address.lines 
                print("Current loc: \(lines!.joinWithSeparator("\n"))")
                let driverLoc = lines!.joinWithSeparator("\n")
                let driverLat = String(coordinate.latitude)
                let driverLong = String(coordinate.longitude)
                
               // self.setuplocationMarker(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))

                
                print("DriverLocation : \(driverLoc)")
                print("DriverLat : \(driverLat)")
                print("DriverLong : \(driverLong)")
                
                self.k = 0
                
                let Message: NSDictionary = ["current_lat": driverLat , "current_long": driverLong , "driver_id": self.driverid]
                self.ref.child("Track Ride Before Arrived").child(GlobalVariables.rideid).setValue(Message)
                

                
              //  APIManager.sharedInstance.delegate = self
              //  APIManager.sharedInstance.updateDriverLocation(GlobalVariables.rideid, driverid: self.driverid, userid: GlobalVariables.custId, driverLat: driverLat, driverLong: driverLong)

              
            }
            
        }
        
    }
    
    
    
    func getDriverLocation(timer : NSTimer)
    {
        
        
        if k == 0{
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
          //  self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()

            self.locationManager.startUpdatingLocation()
            
        }else{
            
            
        }
        
        
        
    }
    

    
    
    // ********************* Creating route methods ***************************
    
    
    
    func createRoute(){
        let origin = GlobalVariables.driverLocation
        let destination = GlobalVariables.pickupLoc
        
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
        originMarker.icon = UIImage(named: "car_ola")
        originMarker.title = self.tasks.originAddress
        
        destinationMarker = GMSMarker(position: self.tasks.destinationCoordinate)
        destinationMarker.map = self.mapView
        destinationMarker.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        destinationMarker.title = self.tasks.destinationAddress
        
    }
    
    func drawRoute() {
        let route = tasks.overviewPolyline["points"] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)!
        routePolyline = GMSPolyline(path: path)
        routePolyline.strokeWidth = 5.0
        routePolyline.strokeColor = DirectionController.getColorFromHex("70C1F8")
        routePolyline.map = mapView
    }
    

    
    // ********************* Set marker on particular location ***************************
    
    
    func setuplocationMarker(coordinate: CLLocationCoordinate2D) {
        
        let marker = GMSMarker(position: coordinate)
        marker.title = GlobalVariables.pickupLoc
        marker.icon = UIImage(named: "car_ola")
        marker.map = mapView
        
    }
    
    
    
    // ********************* Success state  ***************************
    

    func onSuccessState(data: AnyObject , resultCode: Int) {
        if (resultCode == 198){
        self.data = data as! Arrived
            
            if(self.data.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
                
            }else if self.data.result == 1 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: DirectionController = storyboard.instantiateViewControllerWithIdentifier("DirectionController") as! DirectionController
            
            self.presentViewController(next, animated: true, completion: nil)
            }
        }
        
        if resultCode == 264{
            
            self.updateData = data as! UpdateDriverLocation
            
         //   self.timerForGetDriverLocation = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: #selector(DirectController.getDriverLocation(_:)) , userInfo: nil, repeats: true)
            
            
            
            if(self.updateData.result == 419){
                
                NsUserDefaultManager.SingeltonInstance.logOut()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
                self.presentViewController(next, animated: true, completion: nil)
                
                
            }
            

        }

    }

    


    
}