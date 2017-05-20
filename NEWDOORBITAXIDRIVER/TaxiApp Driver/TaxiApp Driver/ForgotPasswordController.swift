//
//  ForgotPasswordController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 19/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

class ForgotPasswordController: UIViewController , ParsingStates {
    
    var driverEmail: String = ""
    var data: ForgotPassword!
    
    @IBOutlet weak var emailField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ********************* On back click dismiss vc ***************************
    
    
    @IBAction func back_btn(sender: AnyObject) {
        
        dismissViewcontroller()
    }
    
    
    // ********************* submit click to send email ***************************

    
    @IBAction func submit_btn(sender: AnyObject) {
        
        driverEmail = emailField.text!
        if (driverEmail.containsString(" "))
        {
            let alert = UIAlertController(title: "", message:NSLocalizedString(" Email id must not contain space ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }

        else{
            
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.forgotPassword(driverEmail)
            
        }

    }
    
    
    // ********************* Success state ***************************

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! ForgotPassword
        if(self.data.result == 1){
            
            let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message:self.data.msg!, preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
        else{
            
            let alert = UIAlertController(title: NSLocalizedString("Failed", comment: ""), message: self.data.msg! , preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
        
    }
        
}
