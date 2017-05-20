//
//  NewProfileViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 06/04/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class NewProfileViewController: UIViewController,MainCategoryProtocol {
    
     var logoutdata : LogOutModel!
    
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var useremail: UILabel!
    
    @IBOutlet weak var usermobile: UILabel!
    
    let imageUrl = API_URL.imagedomain
    
    let Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyname)
    
    
    
    let email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyemail)
    
    let mobile = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyphonenumber)
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
    
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.useremail.text! = email!
        self.username.text! = Name!
       
        self.usermobile.text! = mobile!


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func logoutbtn(sender: AnyObject) {
        
        let refreshAlert = UIAlertController(title:  NSLocalizedString("Log Out", comment: ""), message: NSLocalizedString("Are You Sure to Log Out ?", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Confirm", comment: "") , style: .Default, handler: { (action: UIAlertAction!) in
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.logoutUser(self.Userid!)
            
           
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Default, handler: { (action: UIAlertAction!) in
            
            refreshAlert .dismissViewControllerAnimated(true, completion: nil)
            
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        

    }

    @IBAction func newregisteremailbtn(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let splashViewController = storyBoard.instantiateViewControllerWithIdentifier("RegisterNewEmailViewController") as! RegisterNewEmailViewController
        
        self.presentViewController(splashViewController, animated:true, completion:nil)

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
            
            
        }
        
    }
    


}
