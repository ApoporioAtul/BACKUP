//
//  ChangePasswordViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 19/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangePasswordViewController: UIViewController,MainCategoryProtocol {
    
    @IBOutlet weak var oldpassword: UITextField!
    
    @IBOutlet weak var newpassword: UITextField!
    
    @IBOutlet weak var confirmpassword: UITextField!
    
    
    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var passwordValid = false
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
    let matcholdpassword = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keypassword)
    
    @IBOutlet weak var detailview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        ApiManager.sharedInstance.protocolmain_Catagory = self
        
        detailview.layer.borderWidth = 1.0
        detailview.layer.cornerRadius = 4
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
   
    func changepassword(){
    
    
    self.oldpassword.text=self.oldpassword.text!
    self.newpassword.text=self.newpassword.text!
    self.confirmpassword.text=self.confirmpassword.text!
    
        
        let enteredPassword=self.newpassword.text!
        if enteredPassword.isPassword{
            
            self.passwordValid=true
            
        }else{
            
            self.passwordValid=false
            
            
        }
        
        if(matcholdpassword == self.oldpassword.text!){
        
            
        if self.newpassword.text!==self.confirmpassword.text!{
            
            ApiManager.sharedInstance.ChangePassword(self.Userid!, NewPassword: self.newpassword.text!, OldPassword: self.oldpassword.text!)
            
        }else{
            self.showalert(NSLocalizedString("Password and confirm password doesn't match.", comment: ""))
        }
            
        }
        else{
        
         self.showalert(NSLocalizedString("Your Old Password doesn't match.", comment: ""))
        
        }

    
        
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
    

    
    
    @IBAction func Donebtn(sender: AnyObject) {
        
        changepassword()
    }

    
    
    func onProgressStatus(value: Int) {
        if(value == 0 ){
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }else if (value == 1){
            let spinnerActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            spinnerActivity.label.text = NSLocalizedString("Loading", comment: "")
            spinnerActivity.detailsLabel.text = NSLocalizedString("Please Wait!!", comment: "")
            spinnerActivity.userInteractionEnabled = false        }
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
        
              
            
             if(JSON(data)["result"] == 1){
            
             self.showalert( NSLocalizedString("Password Change successfully!!", comment: ""))
             //self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
               

            self.showalert(NSLocalizedString("Please Try Again!!!", comment: ""))
        }
        
        
        
    }
    

  

}
