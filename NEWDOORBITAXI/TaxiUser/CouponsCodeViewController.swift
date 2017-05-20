//
//  CouponsCodeViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 19/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CouponsCodeViewController: UIViewController,MainCategoryProtocol {
    
    
    @IBOutlet weak var textlabel: UILabel!
    
     var mydata : Coupons!
      var animationView=UIImageView()
    
    var selectcouponcode = "  "
    var collectionsize = 0
    
    @IBOutlet weak var entercouponcode: UITextField!
    
    
    
    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       textlabel.text = NSLocalizedString("You dont seem to have any valid coupons", comment: "")

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelbtn(sender: AnyObject) {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func Donebtn(sender: AnyObject) {
       
        if(entercouponcode.text!.characters.count == 0)
      
        {
            self.showalert(NSLocalizedString("Please enter Coupon Code!!", comment: ""))
        }
        else{
            GlobalVarible.CouponCode = self.entercouponcode.text!
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.getcoupons(self.entercouponcode.text!)

          // self.showalert("Coupon Applied Sucessfully!!!")
             //self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:  NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
           
            
            let OKAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
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
            
            
            let OKAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                
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
        
        
        mydata = data as! Coupons
        
        if(mydata.result == 0){
                       textlabel.text =  NSLocalizedString("Please enter a valid coupon and try again.", comment: "")
            
        }else{
            
            self.showalert( NSLocalizedString("Coupon Applied Sucessfully!!!", comment: "")
)
        }
        
        
        
    }


   
}
