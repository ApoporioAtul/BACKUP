//
//  UserDropLocationViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 08/11/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class UserDropLocationViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate, GMSMapViewDelegate,MainCategoryProtocol {
    
    @IBOutlet weak var userdroplocation: AutoCompleteTextField!
    
    
    @IBOutlet weak var mapview: GMSMapView!
    
    var locationManager = CLLocationManager()
    
    private var responseData:NSMutableData?
    private var dataTask:NSURLSessionDataTask?
    
    //private let googleMapsKey = "AIzaSyDg2tlPcoqxx2Q2rfjhsAKS-9j0n3JA_a4"
    
    private let googleMapsKey = "AIzaSyB5xfHcGWzuPesz-MegU46fAdY6ZyfCfMo"
    
   // private let googleMapsKey = "AIzaSyALp5ADKlzun286V-GEpJI-ZQFyLk0LT2Y"
    
    private let baseURLString = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    
    
    var selectUserDropLocationText = ""
    var SelectUserDropLat = ""
    var SelectUserDropLng = ""
    
      var i = 0

    
    var lat = ""
    var long = ""
    var cityname = ""

    
    @IBAction func backbtn(sender: AnyObject) {
      self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalVarible.matchintegernumber = 2
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapview.settings.myLocationButton = true
        mapview.myLocationEnabled = true
        
        mapview.delegate = self
        

        
        configureTextField()
        handleTextFieldInterfaces()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func selecctdroplocation(sender: AnyObject) {
        
        
        if userdroplocation.text!.characters.count < 2
        {
           self.showalert(NSLocalizedString("No Location In Text Field ", comment: ""))
            
            return
        }else{
            
             
        GlobalVarible.UserDropLocationText = selectUserDropLocationText
        GlobalVarible.UserDropLat = Double(SelectUserDropLat)!
        GlobalVarible.UserDropLng = Double(SelectUserDropLng)!
        
        self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    
    
    
    private func configureTextField(){
        userdroplocation.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        userdroplocation.autoCompleteTextFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
        userdroplocation.autoCompleteCellHeight = 35.0
        userdroplocation.maximumAutoCompleteCount = 20
        userdroplocation.hidesWhenSelected = true
        userdroplocation.hidesWhenEmpty = true
        userdroplocation.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.blackColor()
        attributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        userdroplocation.autoCompleteAttributes = attributes
    }
    
    
    private func handleTextFieldInterfaces(){
        userdroplocation.onTextChange = {[weak self] text in
            if !text.isEmpty{
                if let dataTask = self?.dataTask {
                    dataTask.cancel()
                }
                self?.fetchAutocompletePlaces(text)
            }
        }
        
       userdroplocation.onSelect = {[weak self] text, indexpath in
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.FindGooglePlaceId()
        
        
        print("jhgjgjwkg")
        }
        
       /* userdroplocation.onSelect = {[weak self] text, indexpath in
            Location.geocodeAddressString(text, completion: { (placemark, error) -> Void in
                if (placemark?.location?.coordinate) != nil {
                    let dropLatitude =  placemark!.location!.coordinate.latitude
                    let dropLongitude = placemark!.location!.coordinate.longitude
                    GlobalVarible.UserDropLocationText = text
                    GlobalVarible.UserDropLat = dropLatitude
                    GlobalVarible.UserDropLng = dropLongitude
                   
                    
                    self!.selectUserDropLocationText = text
                    self!.SelectUserDropLat = String(dropLatitude)
                    self!.SelectUserDropLng = String(dropLongitude)
                    
                    // self?.dismissViewControllerAnimated(true, completion: nil)
                    let position = CLLocationCoordinate2DMake(dropLatitude, dropLongitude)
                  
                    self!.mapview.animateToLocation(position)
                    
                }
            })
        }*/
    }
    
    
    func fetchAutocompletePlaces(keyword:String) {
        //let urlString = "\(baseURLString)?key=\(googleMapsKey)&input=\(keyword)"
        let urlString = "\(baseURLString)?location=\(GlobalVarible.PickUpLat)\(",")\(GlobalVarible.PickUpLng)&radius=\("500")&key=\(googleMapsKey)&input=\(keyword)"

        let s = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        s.addCharactersInString("+&")
        if let encodedString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(s) {
            if let url = NSURL(string: encodedString) {
                let request = NSURLRequest(URL: url)
                dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                    if let data = data{
                        
                        do{
                            let result = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                            
                            if let status = result["status"] as? String{
                                if status == "OK"{
                                    if let predictions = result["predictions"] as? NSArray{
                                        var locations = [String]()
                                        var placeid = [String]()
                                        for dict in predictions as! [NSDictionary]{
                                            locations.append(dict["description"] as! String)
                                            placeid.append(dict["place_id"] as! String)
                                        }
                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            self.userdroplocation.autoCompleteStrings = locations
                                             self.userdroplocation.autoPlaceId = placeid
                                        })
                                        return
                                    }
                                }
                            }
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.userdroplocation.autoCompleteStrings = nil
                                 self.userdroplocation.autoPlaceId = nil
                            })
                        }
                        catch let error as NSError{
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                })
                dataTask?.resume()
            }
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedAlways {
            
            locationManager.startUpdatingLocation()
            
            mapview.myLocationEnabled = true
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            
            mapview.animateToLocation(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            
            mapview.animateToZoom(15)
            
            
            locationManager.stopUpdatingLocation()
            
            
            
        }
        
    }
    
    
    
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
        /* LAT  = String(position.target.latitude)
         LNG = String(position.target.longitude)
         
         SelectUserDropLat = String(position.target.latitude)
         SelectUserDropLng =  String(position.target.longitude)*/
        
        reverseGeocodeCoordinate(position.target)
    }
    
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        
        let geocoder = GMSGeocoder()
        
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                
                if(self.i == 1){
                    self.userdroplocation.text =  GlobalVarible.GooglePlaceSelectedText
                    self.i = 0
                    
                }else{
                    

                
                let lines = address.lines
                // var selcetlocation = lines!.joinWithSeparator("\n")
                self.userdroplocation.text = lines?.joinWithSeparator("\n")
                
                GlobalVarible.UserDropLocationText = lines!.joinWithSeparator("\n")
                GlobalVarible.UserDropLat = coordinate.latitude
                GlobalVarible.UserDropLng = coordinate.longitude
                
                self.selectUserDropLocationText = lines!.joinWithSeparator("\n")
                self.SelectUserDropLat = String(coordinate.latitude)
                self.SelectUserDropLng = String(coordinate.longitude)
                
                          
                    
                }
            }
            
        }
    }
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:  NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
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
            
            spinnerActivity.userInteractionEnabled = false
            
            
        }
    }
    
    func onSuccessExecution(msg: String) {
        print("msg")
        
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
        
        if(data["status"] as! String ==  "OK"){
        
        
        let data1 = data["result"]!!["geometry"]!!["location"]!!["lat"] as! Double
        let data2 = data["result"]!!["geometry"]!!["location"]!!["lng"] as! Double
            
            GlobalVarible.UserDropLocationText = GlobalVarible.GooglePlaceSelectedText
            GlobalVarible.UserDropLat = data1
            GlobalVarible.UserDropLng = data2
            
            self.userdroplocation.text =  GlobalVarible.GooglePlaceSelectedText
            
            i = 1

            
            self.selectUserDropLocationText = GlobalVarible.GooglePlaceSelectedText
            self.SelectUserDropLat = String(data1)
            self.SelectUserDropLng = String(data2)
            
            self.mapview.animateToLocation(CLLocationCoordinate2D(latitude: data1, longitude: data2))
            
            self.mapview.animateToZoom(15)
            
        
        print(data1)
        print(data2)
    }


     else{
      print("hello")

     }
    }


  
}
