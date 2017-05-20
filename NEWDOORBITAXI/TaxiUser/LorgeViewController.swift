//
//  LorgeViewController.swift
//  Appolaundry
//
//  Created by Piyush /kumar on 01/03/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit
import DigitsKit
import MICountryPicker

class LorgeViewController: UIViewController ,GIDSignInDelegate, GIDSignInUIDelegate,MainCategoryProtocol,MICountryPickerDelegate {
    
    var logindata : SignupLoginResponse!
    
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet weak var selectcountrycodelabel: UILabel!

    
    @IBOutlet var container: UIView!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var facebokButton: UIButton!
    
    @IBOutlet var googleButton: UIButton!
    
    var firstName = ""
    var lastName = ""
    var fbOrGoogleId = ""
    var fborGoogleImageUrl = ""
    var fbOrGoogleMail = ""
    
    var buttonPressed = ""
    
    var selcetcountrycode = "+94"
    
   // var buttonPressed1 = ""
    
    // facebook google // simple
    
    override func viewDidLoad() {
        
      // viewControllersStructure.lorgeViewController = self
         selectcountrycodelabel.text = selcetcountrycode
                
            // self.application.didRegisterUserNotificationSettings()
        
        self.loginButton.edgeWithShadow()
        self.facebokButton.edgeWithShadow()
        self.googleButton.edgeWithShadow()
        self.container.edgeWithShadow()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
       
    }
    
    
    @IBAction func selectcountrycodebtn(sender: AnyObject) {
        
        
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        
        picker.delegate = self
        
        picker.showCallingCodes = true
        
        
        
        picker.didSelectCountryWithCallingCodeClosure = { name, code , dialcode in
            self.dismissViewControllerAnimated(true, completion: nil)
            print(dialcode)
        }
        
        self.presentViewController(picker, animated: true, completion: nil)
        
        
    }
    
    
    func countryPicker(picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        
        
    }
    
    
    func countryPicker(picker: MICountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String){
        
        selcetcountrycode = dialCode
        selectcountrycodelabel.text = dialCode
        
    }

    
       
    
    @IBAction func newheresignupbtn(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let revealViewController = storyBoard.instantiateViewControllerWithIdentifier("SignupViewController") as! SignupViewController
        
        self.presentViewController(revealViewController, animated:true, completion:nil)

        
        
        
    }


    
    @IBAction func onLogin(sender: AnyObject) {
        
      //  self.buttonPressed = "simple"
        
        self.view.endEditing(true)
        
        
      /*  if phone.text?.characters.count < 10
        {
          self.showalert("Please Enter Valid Phone")
          //showBannerError("Message", subTitle: "Please Enter Valid Phone", imageName: "")
          return
        }*/
        
        
       /* if phone.text?.characters.count < 5
        {
            self.showalert("Please Enter Valid Password")
          //  showBannerError("Message", subTitle: "Please Enter Valid Password", imageName: "")
            return
            
        }*/
        
        self.buttonPressed = "login"
        let dic=[ loginUrl2:"\(selcetcountrycode + self.phone.text!)",
                  loginUrl3:"\(self.password.text!)"]
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.postData(dic, url: loginUrl)
        
        // ApiController.sharedInstance.parsPostData(dic, url: loginUrl, reseltCode: 2)
        
        }
    
 
    
    @IBAction func onGoogle(sender: AnyObject) {
        
        self.buttonPressed = "google"
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    @IBAction func onFacebook(sender: AnyObject) {
        
        self.buttonPressed = "facebook"
        self.loginWithFacebook()
    }
   
    override func prefersStatusBarHidden() -> Bool {
        return true
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
        
        if buttonPressed == "login"{
        
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
        
        
       if buttonPressed == "facebook"{
            
            if logindata.result == 0 // 0 means user Does not exis mens us fb or google id se koi user register nhi ha
            {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewControllerWithIdentifier("SignupViewControllerWithFacebookGoogle") as! SignupViewControllerWithFacebookGoogle
                
                vc.facebookFirstName = self.firstName
                vc.facebookLastName = self.lastName
                vc.facebookId = self.fbOrGoogleId
                vc.facebookMail = fbOrGoogleMail
                vc.facebookImage = fborGoogleImageUrl
                vc.movedFrom = "facebook"
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
            
            
            if logindata.result == 1
            {
                
                let userid = logindata.details!.userId
                
                let UserDeviceKey = NSUserDefaults.standardUserDefaults().stringForKey("device_key")
                
                print(UserDeviceKey)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.UserDeviceId(userid!, USERDEVICEID: UserDeviceKey! , FLAG: "1")
                
                NsUserDekfaultManager.SingeltionInstance.loginuser(self.logindata.details!.flag!, user_id: self.logindata.details!.userId!,name: self.logindata.details!.userName!, image: (self.logindata.details?.userImage)!, email: self.logindata.details!.userEmail!, phonenumber: (self.logindata.details?.userPhone!)!, status: self.logindata.details!.status!,password: self.logindata.details!.userPassword!)
                
                
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
                
                self.presentViewController(revealViewController, animated:true, completion:nil)
                print("user Exist verifyed plz save detail and move to home Screen")
            }
        }
        
        if buttonPressed == "google"{
            
            if logindata.result == 0 // 0 means user Does not exis mens us fb or google id se koi user register nhi ha
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewControllerWithIdentifier("SignupViewControllerWithFacebookGoogle") as! SignupViewControllerWithFacebookGoogle
                
                vc.googleFirstName = self.firstName
                vc.googleLastName = self.lastName
                vc.googleId = self.fbOrGoogleId
                vc.movedFrom = "google"
                vc.googleMail = fbOrGoogleMail
                vc.googleImage = fborGoogleImageUrl
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
            if logindata.result == 1
            {
                
                let userid = logindata.details!.userId
                
                let UserDeviceKey = NSUserDefaults.standardUserDefaults().stringForKey("device_key")
                
                               
                print(UserDeviceKey)
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.UserDeviceId(userid!, USERDEVICEID: UserDeviceKey! , FLAG: "1")
                
                NsUserDekfaultManager.SingeltionInstance.loginuser(self.logindata.details!.flag!, user_id: self.logindata.details!.userId!,name: self.logindata.details!.userName!, image: (self.logindata.details?.userImage)!, email: self.logindata.details!.userEmail!, phonenumber: (self.logindata.details?.userPhone!)!, status: self.logindata.details!.status!,password: self.logindata.details!.userPassword!)
                
                
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
                
                self.presentViewController(revealViewController, animated:true, completion:nil)
                
                print("user Exist verifyed plz save detail and move to home Screen")
            }
            
        }
        
        
        if buttonPressed == "forgot"{
            
        if logindata.result == 1
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewControllerWithIdentifier("NewForgotPasswordViewController") as! NewForgotPasswordViewController
             vc.oldPassword =   logindata.details!.userPassword!
             vc.userId = logindata.details!.userId!
             self.presentViewController(vc, animated: true, completion: nil)
            
        }else{
            
            self.showalert(logindata.message!)
            
            }
        }
        

    }

}

extension LorgeViewController
{
    // Google Sign In
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                
       withError error: NSError!) {
        if (error == nil) {
            
            let userId = user.userID
          //  let idToken = user.authentication.idToken
            let fullName = user.profile.name
           let profilePicture = String(GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(400))
           let email = user.profile.email
          //  self.signOutGoogle()
            
            self.firstName = fullName
            self.fbOrGoogleId = userId
            self.fborGoogleImageUrl = profilePicture
            self.fbOrGoogleMail = email
            
            let dic=[ googleLoginUrl2: "\(userId)"]
           
            ApiManager.sharedInstance.protocolmain_Catagory = self

             ApiManager.sharedInstance.postData(dic, url: googleLoginUrl)
            
         //   ApiController.sharedInstance.parsPostData(dic, url: googleLoginUrl, reseltCode: 9)
            
            
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
}

extension LorgeViewController

{
    // Facebook Login
    func loginWithFacebook()
    {
        //action of the custom button in the storyboard
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            
            if result.isCancelled {
                return
            }
        
            if (error == nil){
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                   // KVNProgress.show()
                    self.getFBUserData()
                }
            }
        }
        
        
    }
    
    func getFBUserData(){
        
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, gender , name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if  result == nil
                    
                {
                    self.showalert(String(error))
                    return
                }
                
                
                
                if (error == nil){
                    //everything works print the user data
                    print(result)
                    
                    
                    var FirstName = ""
                    var LastName = ""
                    var Email = ""
                    var Gender = "male"
                    var FacebookId = ""
                    
                    
                    
                    if let facebookId = (result.objectForKey("id") as? String) {
                        FacebookId = facebookId
                        Email = facebookId + "@facebook.com"
                        
                    }
                    
                    
                    if let firstName = (result.objectForKey("first_name") as? String) {
                        FirstName = firstName
                    }
                    
                    if let lastName = (result.objectForKey("last_name") as? String) {
                        LastName = lastName
                    }
                    
                    if let email = (result.objectForKey("email") as? String) {
                        Email = email
                    }
                    
                    
                    if let fbGender = (result.objectForKey("gender") as? String) {
                        Gender = fbGender
                    }
                    
                    
                    print(FirstName)
                    print(LastName)
                    print(Email)
                    print(Gender)
                    
                    
                    print("Facebook Id Is " +  FacebookId)
                    
                  //  self.signOutFacebok()
                    
                    let imgURLString = "https://graph.facebook.com/\(FacebookId)/picture?width=640&height=640"
                    self.fborGoogleImageUrl = imgURLString
                    self.fbOrGoogleMail = Email
                    self.firstName = FirstName
                    self.lastName = LastName
                    self.fbOrGoogleId = FacebookId
                    
                    let dic=[ facebookLoginUrl2: "\(FacebookId)"]
                    ApiManager.sharedInstance.protocolmain_Catagory = self

                     ApiManager.sharedInstance.postData(dic, url: facebookLoginUrl)
                    
                  //  ApiController.sharedInstance.parsPostData(dic, url: facebookLoginUrl, reseltCode: 9)
          
                    
                }
            })
        }
    }
}

extension LorgeViewController

{
    
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
    
    
  }

extension LorgeViewController
{
    
    @IBAction func onForgotPassword(sender: AnyObject) {
        
      
        
        self.buttonPressed = "forgot"
        let digits = Digits.sharedInstance()
        
        digits.authenticateWithCompletion { (session, error) in
            
            if (session != nil) {
                // TODO: associate the session userID with your user model
                
                let phone = session!.phoneNumber!
                print(phone)
                Digits.sharedInstance().logOut()
                
                let dic=[ checkPhoneExistOrNotUrl2: "\(phone)"]
                
                ApiManager.sharedInstance.protocolmain_Catagory = self

                 ApiManager.sharedInstance.postData(dic, url: checkPhoneExistOrNotUrl)
                                
              //  ApiController.sharedInstance.parsPostData(dic, url: checkPhoneExistOrNotUrl, reseltCode: 11)
         
                
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        }

        
    }
}


    



