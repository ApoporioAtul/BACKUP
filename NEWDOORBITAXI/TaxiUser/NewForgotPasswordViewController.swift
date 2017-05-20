//
//  ForgotPasswordViewController.swift
//  Appolaundry
//
//  Created by Piyush /kumar on 08/03/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewForgotPasswordViewController: UIViewController,MainCategoryProtocol {

    var changepasswordresponse : NewChangePassword!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var confrimPassword: UITextField!
    
    @IBOutlet var changePasswordButton: UIButton!
    
   
    
    var oldPassword = ""
    var userId = ""
    
    override func viewDidLoad() {
        
      //  viewControllersStructure.forgotPasswordViewController = self
      //  self.viewfirst.borderWithColor(UIColor.init(hex: colorBlueDark))
      //  self.viewSecond.borderWithColor(UIColor.init(hex: colorBlueDark))
        self.changePasswordButton.edgeWithShadow()
    }
    
    
    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
        
    @IBAction func onChangePassword(sender: AnyObject) {
        
        if self.password.text!.characters.count < 6
        {
            self.showalert("Password Shoud Not Be Less Then 6")
           // self.showBannerError("Error", subTitle: "Password Shoud Not Be Less Then 6", imageName: "")
            return
        }
        
        
        if self.password.text!  != self.confrimPassword.text {
            self.showalert("Password Does Not Match")
         //  self.showBannerError("Error", subTitle: "Password Does Not Match", imageName: "")
            return
        }
        
        
        let dic=[ changePassword2:"\(self.userId)"  ,  changePassword3:"\(self.oldPassword)" , changePassword4:"\(self.password.text!)"]
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
       ApiManager.sharedInstance.postData1(dic, url: changePassword)
        
     //   ApiController.sharedInstance.parsPostData(dic, url: changePassword, reseltCode: 12)
        
        
        
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
        
     changepasswordresponse = data as! NewChangePassword
        
        
        
        if(changepasswordresponse.result == 1){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let revealViewController = storyBoard.instantiateViewControllerWithIdentifier("LorgeViewController") as! LorgeViewController
            
            self.presentViewController(revealViewController, animated:true, completion:nil)
            
        
        }else{
        
                self.showalert(changepasswordresponse.message!)
            
        }

        
    
        
    }

}
