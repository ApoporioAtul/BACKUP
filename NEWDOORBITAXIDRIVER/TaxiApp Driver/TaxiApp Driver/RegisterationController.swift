//
//  RegisterationController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 19/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit
import DropDown

class RegisterationController: UIViewController , ParsingStates{
    
    var username: String = ""
    var email: String = ""
    var mobile: String = ""
    var pwd: String = ""
    var carmodelid: String = ""
    var carnumber: String = ""
    var cartypeid: String = ""
    var cityid: String = ""
    var data: RegisterDriver!
    var carModelData: CarModel!
    var cartypeData: CarType!
     var cityData: CityTypeModel!
    var cartypeArray = [String]()
     var cityArray = [String]()
    var carModelArray = [String]()
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    let dropDown2 = DropDown()
    
    @IBOutlet weak var confirm_pwd_field: UITextField!
    @IBOutlet weak var register_btn: UIButton!
    @IBOutlet weak var carNoField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var pwd_visible_image: UIImageView!
    @IBOutlet weak var confirm_pwd_image: UIImageView!
     @IBOutlet weak var city_view: UIView!
    @IBOutlet weak var carModel_view: UIView!
    @IBOutlet weak var carType_view: UIView!
    @IBOutlet weak var cityField: UITextField!

    @IBOutlet weak var carModelField: UITextField!
    @IBOutlet weak var carTypeField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        register_btn.layer.borderWidth = 1
        register_btn.layer.borderColor = UIColor.blackColor().CGColor
        pwdField.secureTextEntry = true
        pwd_visible_image.image = UIImage(named: "invisible")
        
        confirm_pwd_field.secureTextEntry = true
        confirm_pwd_image.image = UIImage(named: "invisible")
        
        cityField.text =  NSLocalizedString("Select City", comment: "")
        

        APIManager.sharedInstance.delegate = self
          APIManager.sharedInstance.viewcityType()
       // APIManager.sharedInstance.viewCarType(GlobalVariables.city)
        
    }
    
      // ********************* On back click dismiss vc ***************************
    
    
    @IBAction func back_click(sender: AnyObject) {
        
        dismissViewcontroller()
    }

    
       // ********************* Upload documents click ***************************
    
    
    @IBAction func uploadDocuments(sender: AnyObject) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: UploadDocumentsController = storyboard.instantiateViewControllerWithIdentifier("UploadDocumentsController") as! UploadDocumentsController
        self.presentViewController(next, animated: true, completion: nil)
    }
    

    
    // ********************* Password visibility checks ***************************
    
    
    @IBAction func pwd_click(sender: AnyObject) {
        
        if (pwd_visible_image.image == UIImage(named: "invisible")){
            pwdField.secureTextEntry = false
            pwd_visible_image.image = UIImage(named: "visible")
        }
            
            
        else {
            pwdField.secureTextEntry = true
            pwd_visible_image.image = UIImage(named: "invisible")
        }
    }
    
    @IBAction func confirm_visible_click(sender: AnyObject) {
        
        if (confirm_pwd_image.image == UIImage(named: "invisible")){
            confirm_pwd_field.secureTextEntry = false
            confirm_pwd_image.image = UIImage(named: "visible")
        }
            
        else{
            confirm_pwd_field.secureTextEntry = true
            confirm_pwd_image.image = UIImage(named: "invisible")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
       // ********************* scrollView constraints ***************************
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.scrollView.bounds
        self.scrollView.contentSize.height =  700
        self.scrollView.contentSize.width = 0
    }
    
    
       // ********************* select car type using drop down ***************************
    
    
    @IBAction func select_car_type(sender: AnyObject) {
        
     /*   dropDown.anchorView = carType_view
        dropDown.topOffset = CGPoint(x:0, y: self.carType_view.bounds.height)
        
        self.dropDown.width = 200
        self.dropDown.cellHeight = 50
        
        
        self.dropDown.show()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            GlobalVariables.cartypeid = self.cartypeData.msg![index].carTypeId!
            print(GlobalVariables.cartypeid)
            GlobalVariables.cityid = self.cartypeData.msg![index].cityId!
            self.carTypeField.text = item
            if GlobalVariables.cartypeid != ""{
                
                APIManager.sharedInstance.delegate = self
                APIManager.sharedInstance.viewCarModels(GlobalVariables.cartypeid)
            }
            self.dropDown.hide()
        }*/
        
        
        if cityField.text == "Select City" {
            let alert = UIAlertController(title: "", message: NSLocalizedString("Please select city first ",comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
        else {
            
            
            
            dropDown.anchorView = carType_view
            dropDown.topOffset = CGPoint(x:0, y: self.carType_view.bounds.height)
            
            self.dropDown.width = 200
            self.dropDown.cellHeight = 50
            
            
            self.dropDown.show()
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                
                GlobalVariables.cartypeid = self.cartypeData.msg![index].carTypeId!
                print(GlobalVariables.cartypeid)
                // GlobalVariables.cityid = self.cartypeData.msg![index].cityId!
                self.carTypeField.text = item
                if GlobalVariables.cartypeid != ""{
                    
                    APIManager.sharedInstance.delegate = self
                    APIManager.sharedInstance.viewCarModels(GlobalVariables.cartypeid)
                }
                self.dropDown.hide()
            }
            
        }

        
        
       
    }
    
    
     // ********************* select car model using drop down ***************************
    
    
    @IBAction func select_car_model(sender: AnyObject) {
        
        if carTypeField.text == "Select Car Type" {
        let alert = UIAlertController(title: "", message:NSLocalizedString("Please select car type first ", comment: ""), preferredStyle: .Alert)
        let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}
        }
        else {
            
           
        dropDown1.anchorView = carModel_view
        dropDown1.topOffset = CGPoint(x:0, y: self.carModel_view.bounds.height)
        
        self.dropDown1.width = 200
        self.dropDown1.cellHeight = 50
        
        
        self.dropDown1.show()
        
        dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            GlobalVariables.carModelid = self.carModelData.msg![index].carModelId!
            print(GlobalVariables.carModelid)
            GlobalVariables.carModelName = self.carModelData.msg![index].carModelName!
            self.carModelField.text = item
            self.dropDown1.hide()
        }
    }
        
    }
    
    @IBAction func select_city_type(sender: AnyObject) {
        
        dropDown2.anchorView = city_view
        dropDown2.topOffset = CGPoint(x:0, y: self.city_view.bounds.height)
        
        self.dropDown2.width = 200
        self.dropDown2.cellHeight = 50
        
        
        self.dropDown2.show()
        
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            GlobalVariables.cityid = self.cityData.msg![index].cityId!
            print(GlobalVariables.cityid)
            GlobalVariables.city = self.cityData.msg![index].cityName!
            self.cityField.text = item
            
            if GlobalVariables.cityid != ""{
                
                APIManager.sharedInstance.delegate = self
                APIManager.sharedInstance.viewCarType(GlobalVariables.city)
            }
            
            
            self.dropDown2.hide()
        }
        
        
    }
    
    
    


    
    
    
    // ************************** Register button click ********************************
    
    
    @IBAction func register_click(sender: AnyObject) {
        
        username = usernameField.text!
        email = emailField.text!
        mobile = mobileField.text!
        pwd = pwdField.text!
        cityid = GlobalVariables.cityid
        cartypeid = GlobalVariables.cartypeid
        carmodelid = GlobalVariables.carModelid
        carnumber = carNoField.text!
        
        
        if ((username == "") || (email == "") || (mobile == "") || (pwd == "") || (self.carmodelid == "") || (carnumber == "") || (self.cartypeid == "") || (self.cityid == "")) {
            
            let alert = UIAlertController(title:NSLocalizedString("Registeration Failed!", comment: ""), message:NSLocalizedString("Fields cannot be blank", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
            
        else if ((mobile.characters.count < 10) || (mobile.characters.count > 10 ))
        {
            let alert = UIAlertController(title: NSLocalizedString("Registeration Failed!", comment: ""), message:NSLocalizedString("Mobile number must be 10  digits", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
            
        else if (carModelField.text == "Select Car Model")
        {
            let alert = UIAlertController(title: NSLocalizedString("Registeration Failed!", comment: ""), message:NSLocalizedString("Please Select Model ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
            
        else if (carTypeField.text == "Select Car Type")
        {
            let alert = UIAlertController(title: "", message:NSLocalizedString("Please Select CarType ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }

        
     /*   else if (GlobalVariables.insurance == "" )
        {
            let alert = UIAlertController(title: "", message:"Please upload documents first ", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }*/

            
        else if (!email.containsString("@"))
        {
            let alert = UIAlertController(title: NSLocalizedString("Registeration Failed!", comment: ""), message:NSLocalizedString(" Wrong Email format ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
          
        else if (email.containsString(" "))
        {
            let alert = UIAlertController(title: "", message:NSLocalizedString(" Email id must not contain space ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }

        else
        {
            
                       
            if pwdField.text == confirm_pwd_field.text {
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.registerDriver(email, phone: mobile, pass: pwd, name: username, cartype_id: cartypeid, carmodelId: carmodelid, carnumber: carnumber, cityid: cityid)
            
            }
            
            if pwdField.text != confirm_pwd_field.text {
                
                let alert = UIAlertController(title: "", message: NSLocalizedString("Password do not match. Please Enter again. ", comment: ""), preferredStyle: .Alert)
                let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            }
        }

    }
    
    
    // ************************** Success state ********************************
    
    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        if resultCode == 33 {
            
   
        self.data = data as! RegisterDriver
        if(self.data.result == 1){
            
            
           
           /* public var lastUpdate: String?
            public var rejectRides: String?
            public var rating: String?
            public var cancelledRides: String?
            public var completedRides: String?
            public var busy: String?
            public var currentLocation: String?
            public var lastUpdateDate: String?
            public var registerDate: String?*/
            
       
        
            NsUserDefaultManager.SingeltonInstance.registerDriver((self.data.details?.insurance!)!, rc: (self.data.details?.rc!)!, licence: (self.data.details?.license!)!, did: (self.data.details?.deviceId!)!, carModelId: (self.data.details?.carModelId!)!, otherDoc: (self.data.details?.otherDocs!)!, driverId: (self.data.details?.driverId!)!, driverImg: (self.data.details?.driverImage!)!, driverEmail: (self.data.details?.driverEmail!)!, driverName: (self.data.details?.driverName!)!, flag: (self.data.details?.flag!)!, long: (self.data.details?.currentLong!)!, cityid: (self.data.details?.cityId!)!, carNo: (self.data.details?.carNumber!)!, password: (self.data.details?.driverPassword!)!, lat: (self.data.details?.currentLat!)!, phoneNo: (self.data.details?.driverPhone!)!, carType: (self.data.details?.carTypeId!)!, onOff: (self.data.details?.onlineOffline!)!, status: (self.data.details?.status!)!, loginLogout: (self.data.details?.loginLogout!)!,driverToken: (self.data.details?.driverToken!)!,detailStatus : (self.data.details?.detailStatus)!,carmodelname : (self.data.details?.carModelName!)! , cartypename : (self.data.details?.carTypeName!)!)
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: UploadDocumentsController = storyboard.instantiateViewControllerWithIdentifier("UploadDocumentsController") as! UploadDocumentsController
            self.presentViewController(next, animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: NSLocalizedString("Please try again!", comment: ""), message: self.data.msg!, preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
            }
            
          /*  let alert = UIAlertController(title: "Registration Successful", message:"", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                
                
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: SWRevealViewController = storyboard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
                self.presentViewController(next, animated: true, completion: nil)
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
        else{
        
            let alert = UIAlertController(title: "Unable to register!", message: self.data.msg!, preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }*/
            
    }
    
        if resultCode == 22 {
            
            self.cartypeData = data as! CarType
            if self.cartypeData.result == 1 {
                
                cartypeArray.removeAll()
                
                for items in  self.cartypeData.msg!
                {
                    
                    if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
                        
                        cartypeArray.append(items.carTypeName!)
                    }else{
                        cartypeArray.append(items.carNameOther!)
                    }
                    

                    
                   // cartypeArray.append(items.carTypeName!)
                    //selectcity_field.text = items.cityName
                    
                    dropDown.dataSource = cartypeArray
                    
                }
            }
        }
     
    
        if resultCode == 11 {
            
            self.carModelData = data as! CarModel
            if self.carModelData.result == 1 {
                
                carModelArray.removeAll()
                
                for items in  self.carModelData.msg!
                {
                    
                    if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
                        
                        carModelArray.append(items.carModelName!)
                    }else{
                        carModelArray.append(items.carModelNameOther!)
                        
                    }
                    

                    
                  //  carModelArray.append(items.carModelName!)
                    //selectcity_field.text = items.cityName
                    
                    dropDown1.dataSource = carModelArray
                    
                }
            }
        }
        
        
        if resultCode == 1003 {
            
            self.cityData = data as! CityTypeModel
            
            if self.cityData.result == 1 {
                
                cityArray.removeAll()
                
                for items in  self.cityData.msg!
                {
                    
                    if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
                        
                         cityArray.append(items.cityName!)
                    }else{
                        cityArray.append(items.cityNameOther!)
                    }
                    
                    
                  //  cityArray.append(items.cityName!)
                    //selectcity_field.text = items.cityName
                    
                    print(cityArray)
                    
                    dropDown2.dataSource = cityArray
                    
                }
            }
        }
        



        
    }
    
    // ********************* Textfield delegate ***************************

    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }


}