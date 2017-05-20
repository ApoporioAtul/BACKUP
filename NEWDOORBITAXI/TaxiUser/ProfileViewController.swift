//
//  ProfileViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 19/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,MainCategoryProtocol,UIPopoverControllerDelegate,UINavigationControllerDelegate{

    var imagesDirectoryPath:String!
    
    var logoutdata : LogOutModel!
    
    let imageUrl = API_URL.imagedomain
    
    @IBOutlet weak var userimage: UIImageView!
   
    var picker:UIImagePickerController?=UIImagePickerController()
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailid: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    
    @IBOutlet weak var mobilenumber: UITextField!
    
    
     let Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyname)
    
    let Password = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keypassword)
    
    let email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyemail)
    
    let mobile = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyphonenumber)
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
   let UserImage = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyimage)
    
    
   
    @IBAction func backbtn(sender: AnyObject) {
        
        self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func changePasswordbtn(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let changepassword = storyBoard.instantiateViewControllerWithIdentifier("ChangePasswordViewController") as! ChangePasswordViewController
        
        self.presentViewController(changepassword, animated:true, completion:nil)
        
    }
    
   
    @IBOutlet weak var Logout: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.sharedInstance.protocolmain_Catagory = self
        
        Logout.layer.borderWidth = 1.0
        Logout.layer.cornerRadius = 4
        
        userimage.layer.borderWidth = 1
        userimage.layer.masksToBounds = false
        userimage.layer.borderColor = UIColor.blackColor().CGColor
        userimage.layer.cornerRadius = userimage.frame.height/2
        userimage.clipsToBounds = true
        
        self.emailid.text! = email!
        self.name.text! = Name!
        self.password.text! = Password!
        self.mobilenumber.text! = mobile!
        picker?.delegate = self

        if(UserImage == ""){
           userimage.image = UIImage(named: "profileeee") as UIImage?
            print("No Image")
        }else{
            
             let newUrl = imageUrl + UserImage!
        //    let url = "http://apporio.co.uk/apporiotaxi/\(UserImage!)"
            print(newUrl)
            
            let url1 = NSURL(string: newUrl)
            userimage!.af_setImageWithURL(url1!,
                                             placeholderImage: UIImage(named: "dress"),
                                             filter: nil,
                                             imageTransition: .CrossDissolve(1.0))
        }
        

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imagebtn(sender: AnyObject) {
        
         self.openGallary()
    }
    
    func editprofile(){
    
      
        self.mobilenumber.text = self.mobilenumber.text!
        self.name.text = self.name.text!
    
        //   http://apporio.in/taxi_app/api/edit_profile.php?user_id=&name=&phone_number=
        
             
        let parameters = [
            "user_id": Userid!,
            "user_name": self.name.text!,
            "user_phone": self.mobilenumber.text!
            
        ]
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.EditProfile(parameters , Image: self.userimage.image!)
        
        
        
    }
    
    
    
    @IBAction func Donebtn(sender: AnyObject) {
        
        editprofile()
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }

    @IBAction func LOgoutbtn(sender: AnyObject) {
        let refreshAlert = UIAlertController(title:  NSLocalizedString("Log Out", comment: ""), message: NSLocalizedString("Are You Sure to Log Out ?", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Confirm", comment: "") , style: .Default, handler: { (action: UIAlertAction!) in
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.logoutUser(self.Userid!)
            
//            NsUserDekfaultManager.SingeltionInstance.logOut()
//            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let splashViewController = storyBoard.instantiateViewControllerWithIdentifier("SplashViewController") as! SplashViewController
//            
//            self.presentViewController(splashViewController, animated:true, completion:nil)
            
            //self.navigationController?.popToRootViewControllerAnimated(true)
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
            
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
            
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
     
        
        
    }
    
    
    
    
    
    func openGallary()
    {
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker!, animated: true, completion: nil)
    }
    
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker .dismissViewControllerAnimated(true, completion: nil)
        let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        userimage.contentMode = .ScaleAspectFit
        userimage.image = chosenImage
        
        
    
     
        print(chosenImage!)
      //  print(imagePath)
       // print(data)
       
               
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    func showalert1(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:  NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
               
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    
    func showalert2(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:  NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
           
            let OKAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                NsUserDekfaultManager.SingeltionInstance.logOut()
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let splashViewController = storyBoard.instantiateViewControllerWithIdentifier("SplashViewController") as! SplashViewController
                
                self.presentViewController(splashViewController, animated:true, completion:nil)

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
            self.showalert(NSLocalizedString("A server with the specified hostname could not be found.", comment: ""))
            
        }
            
        else {
            
            self.showalert(NSLocalizedString("The Internet connection appears to be slow", comment: ""))
        }
    }
    
    func onSuccessParse(data: AnyObject) {
        
        
        if(GlobalVarible.Api == "userlogout"){
        
            logoutdata = data as! LogOutModel
            
            if(logoutdata.result == 1){
                
                 NsUserDekfaultManager.SingeltionInstance.logOut()
                
                self.showalert2(logoutdata.msg!)
            
            }else{
            
            self.showalert(NSLocalizedString("Please Try Again!!!", comment: ""))
            }
        
       
        }else{
        
        //print ("status that we are showing in protocol \(data)")
        
       // if(JSON(data)["msg"].stringValue == "Update successfully!!"){
            if(JSON(data)["result"] == 1){
            
            let  email  =  data["details"]!!["user_email"] as! String
            let flag =  data["details"]!!["flag"] as! String
            let userid = data["details"]!!["user_id"] as! String
            let name = data["details"]!!["user_name"] as! String
            let image = data["details"]!!["user_image"] as! String
            let password = data["details"]!!["user_password"] as! String
            let phonenumber = data["details"]!!["user_phone"] as! String
            let status = data["details"]!!["status"] as! String
            
                
            NsUserDekfaultManager.SingeltionInstance.loginuser(flag, user_id: userid,name: name, image: image, email: email, phonenumber: phonenumber, status: status,password: password)
            
            
            self.showalert(NSLocalizedString("Update successfully!!", comment: ""))
           
        }
        else{
            
            self.showalert(NSLocalizedString("Please Try Again!!!", comment: ""))
        }
        
        }
        
    }
    

   

}
