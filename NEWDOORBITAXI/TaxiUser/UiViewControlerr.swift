//
//  UIViewController.swift
//  Pacco
//
//  Created by Piyush /kumar on 21/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

/*import Foundation

import UIKit


extension UIViewController : UITextFieldDelegate
    
{
    
    
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
   
    
    
    @IBAction func onBackPressed(sender: AnyObject) {
        
        if let navigation = self.navigationController
            
        {
            navigation.popViewControllerAnimated(true)
        }
            
            
        else
            
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    
    
    
    
    
    
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func showAlertWithDismissVc(msg: String)
    {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.dismissVc()
        }))
        
        
        
        
        
    }
    
    
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    
     
    
    
    
    func presnet(viewConterlerId : String)     {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(viewConterlerId)
        self.presentViewController(vc!, animated: true, completion: nil)
        
        
        
    }
    
    
    func getVc(viewConterlerId : String) -> UIViewController
    {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(viewConterlerId)
        return vc!
    }
    
    
    
    func dismissVc()  {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func presentAsDialog(viewConterlerId : String)
    {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(viewConterlerId)
        vc!.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(vc!, animated: true, completion: nil)
        
        
    }
    
    var Timestamp: String {
        return "\(NSDate().timeIntervalSince1970 * 1000)"
    }
    
    
  func showBannerError( title : String ,  subTitle: String , imageName: String ) {
    let banner = Banner(title: title, subtitle: subTitle, image: UIImage(named: imageName), backgroundColor: UIColor.redColor())
    banner.dismissesOnTap = true
    banner.show(duration: 1.0)
   }
    
    
      func showBannerSuccess( title : String ,  subTitle: String , imageName: String ) {
        let banner = Banner(title: title, subtitle: subTitle, image: UIImage(named: imageName),backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
        banner.dismissesOnTap = true
        banner.show(duration: 2.0)
    }

    

    
    
    func showBannerSuccessAppColor( title : String ,  subTitle: String , imageName: String ) {
        let banner = Banner(title: nil, subtitle: subTitle, image: UIImage(named: imageName),backgroundColor: UIColor.init(hex: colorBlue))
        banner.dismissesOnTap = true
        banner.show(duration: 2.0)
    }

    
    
    
    func restartApp()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.application(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil)
        
    }
    
    
    func shareOnSocial(message: String , url: String)
    {
        
        //Set the link to share.
        if let link = NSURL(string: url)
        {
            let objectsToShare = [message,link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
}*/





    