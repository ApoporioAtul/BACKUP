//
//  LoginController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 19/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

class LoginController: UIViewController , ParsingStates {
    
    var mobileNo: String = ""
    var password: String = ""
    var data: RegisterDriver!
    
    @IBOutlet weak var phoneNoField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var login_btn: UIButton!
    @IBOutlet weak var pwd_visible_image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        login_btn.layer.borderWidth = 1
        login_btn.layer.borderColor = UIColor.blackColor().CGColor
        
        passwordField.secureTextEntry = true
        pwd_visible_image.image = UIImage(named: "invisible")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ********************* On back click dismiss vc ***************************
    

    @IBAction func back_click(sender: AnyObject) {
        
        dismissViewcontroller()
    }
    
    
    // ********************* Forgot Password click ***************************
    

    @IBAction func forgot_pwd_action(sender: AnyObject) {
       
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let revealController:  ForgotPasswordController = storyboard.instantiateViewControllerWithIdentifier("ForgotPasswordController") as! ForgotPasswordController
        self.presentViewController(revealController, animated: true, completion: nil)
    }
    
    
    // ********************* Password visibility checks ***************************
    
    
    @IBAction func pwd_click(sender: AnyObject) {
        
        if (pwd_visible_image.image == UIImage(named: "invisible")){
            passwordField.secureTextEntry = false
            pwd_visible_image.image = UIImage(named: "visible")
        }
            
            
        else {
            passwordField.secureTextEntry = true
            pwd_visible_image.image = UIImage(named: "invisible")
        }
    }
    
    
    // ********************* Login button click ***************************
    
    
    @IBAction func login_click(sender: AnyObject) {
        
        mobileNo = phoneNoField.text!
        password = passwordField.text!
        
        if ((mobileNo == "") || (password == "") ) {
            
            let alert = UIAlertController(title: NSLocalizedString("Login Failed!", comment: ""), message:NSLocalizedString("Fields cannot be blank ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
            
        else
        {
            
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.loginDriver(mobileNo, password: password)
            
        }
        
    }
    
    
    // ********************* Success state ***************************
    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! RegisterDriver
        if(self.data.result == 1){
            
            
            if(self.data.details?.detailStatus == "1"){
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: UploadDocumentsController = storyboard.instantiateViewControllerWithIdentifier("UploadDocumentsController") as! UploadDocumentsController
                self.presentViewController(next, animated: true, completion: nil)
                

            
            
            }else{
            
            
            NsUserDefaultManager.SingeltonInstance.registerDriver((self.data.details?.insurance!)!, rc: (self.data.details?.rc!)!, licence: (self.data.details?.license!)!, did: (self.data.details?.deviceId!)!, carModelId: (self.data.details?.carModelId!)!, otherDoc: (self.data.details?.otherDocs!)!, driverId: (self.data.details?.driverId!)!, driverImg: (self.data.details?.driverImage!)!, driverEmail: (self.data.details?.driverEmail!)!, driverName: (self.data.details?.driverName!)!, flag: (self.data.details?.flag!)!, long: (self.data.details?.currentLong!)!, cityid: (self.data.details?.cityId!)!, carNo: (self.data.details?.carNumber!)!, password: (self.data.details?.driverPassword!)!, lat: (self.data.details?.currentLat!)!, phoneNo: (self.data.details?.driverPhone!)!, carType: (self.data.details?.carTypeId!)!, onOff: (self.data.details?.onlineOffline!)!, status: (self.data.details?.status!)!, loginLogout: (self.data.details?.loginLogout!)!,driverToken: (self.data.details?.driverToken!)!,detailStatus : (self.data.details?.detailStatus)!,carmodelname : (self.data.details?.carModelName!)! , cartypename : (self.data.details?.carTypeName!)!)
            print("data saved")
            
            let alert = UIAlertController(title: NSLocalizedString("Login Successful", comment: ""), message:"", preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:OnLineController = storyBoard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
                
                self.presentViewController(revealViewController, animated:true, completion:nil)
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
            
            
        }
        else{
            
            let alert = UIAlertController(title: NSLocalizedString("Unable to login!", comment: ""), message: self.data.msg! , preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
        
    }
    
    
    // ********************* Textfield delegate ***************************


    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    
    
   }
