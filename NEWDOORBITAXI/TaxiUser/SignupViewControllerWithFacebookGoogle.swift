//
//  SignupViewController.swift
//  Appolaundry
//
//  Created by Piyush /kumar on 01/03/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit
import DigitsKit

class SignupViewControllerWithFacebookGoogle: UIViewController,MainCategoryProtocol {
    
    var logindata : SignupLoginResponse!
    
    @IBOutlet var container: UIView!
    
    @IBOutlet var phoneButton: UIButton!
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    
    var movedFrom = ""
    
    var facebookFirstName = ""
    var facebookLastName = ""
    var googleFirstName = ""
    var googleLastName = ""
    var facebookId = ""
    var googleId = ""
    var googleMail = ""
    var googleImage = ""
    var facebookMail = ""
    var facebookImage = ""
    
    override func viewDidLoad() {
            
       // viewControllersStructure.signupViewControllerWithFacebookGoogle = self
        
        self.container.edgeWithShadow()
        
        if movedFrom == "google"{
            
             self.firstName.text = googleFirstName
        }
        else
        {
            self.firstName.text = facebookFirstName
            self.lastName.text = facebookLastName
        }
        
        
        self.signoutTwiterDegit()
    }
    
    
    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func onRegister(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        if self.firstName.text?.characters.count < 2 {
            self.showalert("Please Enter Valid Name")
           // self.showBannerError("Message", subTitle: "Please Enter Valid Name", imageName: "")
            return
        }
        
        if movedFrom != "google"{
            
            if self.lastName.text?.characters.count < 2 {
                 self.showalert("Please check Last Name")
              //  self.showBannerError("Message", subTitle: "Please check Last Name", imageName: "")
                return
            }
        }
       
        
        if self.phoneButton.currentTitle == "Phone"{
            self.showalert("Please Enter Valid Mobile Number")
          //  self.showBannerError("Message", subTitle: "Please Enter Valid Mobile Number", imageName: "")
            return
        }
    

        if movedFrom == "facebook" {
            
            let dic=[ facebookSignupUrl2:"\(self.facebookId)",
                      facebookSignupUrl3:"\(self.facebookMail)",
                      facebookSignupUrl4:"\(self.facebookImage)",
                      facebookSignupUrl5:"\(self.firstName.text!)",
                      facebookSignupUrl6:"\(self.lastName.text!)",
                      facebookSignupUrl7:"\(self.phoneButton.currentTitle!)",
                      facebookSignupUrl8:"\(self.firstName.text!)",
                      facebookSignupUrl9:"\(self.lastName.text!)"
            ]
            
            for items in dic{
                print(items.1)
            }
            ApiManager.sharedInstance.protocolmain_Catagory = self
             ApiManager.sharedInstance.postData(dic, url: facebookSignupUrl)
            
          //  ApiController.sharedInstance.parsPostData(dic, url:facebookSignupUrl, reseltCode: 10)
            
        }
        
        
        if movedFrom == "google"{
            
            let dic=[ googleSignupUrl2:"\(self.googleId)",
                      googleSignupUrl3:"\(self.firstName.text!)",
                      googleSignupUrl4:"\(self.googleMail)",
                      googleSignupUrl5:"\(self.googleImage)",
                      googleSignupUrl6:"\(self.phoneButton.currentTitle!)",
                      googleSignupUrl7:"\(self.firstName.text!)",
                      googleSignupUrl8:"\(".")",
                      
            ]
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.postData(dic, url: googleSignupUrl)

          //  ApiController.sharedInstance.parsPostData(dic, url:googleSignupUrl, reseltCode: 10)
            
        }
        
       
        
        
        
    }
    
    
    
    @IBAction func onPhone(sender: AnyObject) {
        
        let digits = Digits.sharedInstance()
        
        digits.authenticateWithCompletion { (session, error) in
            
            if (session != nil) {
                // TODO: associate the session userID with your user model
                
                print(session!.phoneNumber)
                self.phoneButton.setTitle(session!.phoneNumber, forState: .Normal)
                self.phoneButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
                self.signoutTwiterDegit()
                
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        }
        
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
   
    func signoutTwiterDegit()
    {
        Digits.sharedInstance().logOut()
        
    }
    
    
    func showalert(message:String)  {
        
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
            spinnerActivity.userInteractionEnabled = false
            
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
        
        logindata = data as! SignupLoginResponse
        
        if logindata.result == 1{
            
            let userid = logindata.details!.userId
            
            let UserDeviceKey = NSUserDefaults.standardUserDefaults().stringForKey("device_key")
            
            
            print(UserDeviceKey)
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.UserDeviceId(userid!, USERDEVICEID: UserDeviceKey!, FLAG: "1")
            
            NsUserDekfaultManager.SingeltionInstance.loginuser(self.logindata.details!.flag!, user_id: self.logindata.details!.userId!,name: self.logindata.details!.userName!, image: (self.logindata.details?.userImage)!, email: self.logindata.details!.userEmail!, phonenumber: (self.logindata.details?.userPhone!)!, status: self.logindata.details!.status!,password: self.logindata.details!.userPassword!)
            
            
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
            
            self.presentViewController(revealViewController, animated:true, completion:nil)
            
            
        }else{
            
            
        }
        

    }

    
    
    
}
