//
//  SignupViewController.swift
//  Appolaundry
//
//  Created by Piyush /kumar on 01/03/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit
import DigitsKit

class SignupViewController: UIViewController,MainCategoryProtocol {
    
    var logindata: SignupLoginResponse!
    
    @IBOutlet var container: UIView!
    
    @IBOutlet var phoneButton: UIButton!
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    
    @IBOutlet var password: UITextField!
    
     var emailValid=false
  //  @IBOutlet var confirmPassword: UITextField!
    
    var facebookFirstName = ""
    var facebookLastName = ""
    var googleFirstName = ""
    var googleLastName = ""
    var facebookId = ""
    var googleId = ""
    
    override func viewDidLoad() {
        
      //  viewControllersStructure.signupViewController = self
        
        self.container.edgeWithShadow()
        
        if facebookFirstName.characters.count > 0
        {
            self.firstName.text = facebookFirstName
        }
       /* if facebookLastName.characters.count > 0
        {
            self.lastName.text = facebookLastName
        }*/
        if googleFirstName.characters.count > 0
        {
            self.firstName.text = googleFirstName
        }
       /* if facebookFirstName.characters.count > 0
        {
            self.lastName.text = googleLastName
        }*/
        
        self.signOutGoogle()
        self.signOutFacebok()
        self.signoutTwiterDegit()
    }
    
    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onRegister(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        
        self.lastName.text=self.lastName.text!
        
        let enteredEmail=self.lastName.text!
        if enteredEmail.isEmail{
            
            self.emailValid=true
            
            
        }else{
            
            self.emailValid=false
            
            
        }

        
        if self.firstName.text?.characters.count < 2 {
            self.showalert("Please Enter Valid Name")
           // self.showBannerError("Message", subTitle: "Please Enter Valid Name", imageName: "")
            return
        }
        
       /* if self.lastName.text?.characters.count < 2 {
            self.showalert("Please check Last Name")
           // self.showBannerError("Message", subTitle: "Please check Last Name", imageName: "")
            return
        }*/
        
        if self.phoneButton.currentTitle == "Phone"{
            self.showalert("Please Enter Valid Mobile Number")
            
          //  self.showBannerError("Message", subTitle: "Please Enter Valid Mobile Number", imageName: "")
            return
        }
        
        
        if self.password.text?.characters.count < 5 {
            self.showalert("Password  length should not be less then 5")
         //   self.showBannerError("Message", subTitle: "Password  length should not be less then 5", imageName: "")
            return
        }
        
        
        
        
        /*if self.password.text! != self.confirmPassword.text! {
            self.showBannerError("Message", subTitle: "Password Does Not Match", imageName: "")
            return
        }*/
        
        if self.emailValid {

        
        let dic=[ signUpUrl2:"\(self.firstName.text!)",
                  signUpUrl3:"\(".")",
                  signUpUrl4:"\(self.phoneButton.currentTitle!)",
                  signUpUrl5:"\(self.password.text!)",
                   signUpUrl6:"\(self.lastName.text!)"
                  ]
      ApiManager.sharedInstance.protocolmain_Catagory = self  
      ApiManager.sharedInstance.postData(dic, url: signUpUrl)
      //  ApiController.sharedInstance.parsPostData(dic, url: signUpUrl, reseltCode: 3)
        }else{
            
            self.showalert(NSLocalizedString("Please fill email properly.", comment: ""))
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
    
    func signOutGoogle()
    {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() == true {
           GIDSignIn.sharedInstance().signOut()
        }
        
    }
    
    func signOutFacebok()
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
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
            ApiManager.sharedInstance.UserDeviceId(userid!, USERDEVICEID: UserDeviceKey! , FLAG: "1")
            
            NsUserDekfaultManager.SingeltionInstance.loginuser(self.logindata.details!.flag!, user_id: self.logindata.details!.userId!,name: self.logindata.details!.userName!, image: (self.logindata.details?.userImage)!, email: self.logindata.details!.userEmail!, phonenumber: (self.logindata.details?.userPhone!)!, status: self.logindata.details!.status!,password: self.logindata.details!.userPassword!)
            
                      
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
            
            self.presentViewController(revealViewController, animated:true, completion:nil)
            
            
        }else{
            
           self.showalert(logindata.message!)
        }

       
    }


    
    
}
