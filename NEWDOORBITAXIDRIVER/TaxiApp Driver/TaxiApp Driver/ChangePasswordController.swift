//
//  ChangePasswordController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

class ChangePasswordController: UIViewController , ParsingStates {
    var oldPwd: String = ""
    var newPwd: String = ""
    var cnfrmPwd: String = ""
    var data: ChangePassword!
    var defaultdriverid = ""
    
    @IBOutlet weak var confirm_pwd_field: UITextField!
    @IBOutlet weak var new_pwd_field: UITextField!
    @IBOutlet weak var old_pwd_field: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaultdriverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // ********************* On back click dismiss vc ***************************

    
    @IBAction func back_pressed(sender: AnyObject) {
        dismissViewcontroller()
    }
    
    
    
     // ********************* done click to change password ***************************
    
    
    @IBAction func done_pressed(sender: AnyObject) {
        oldPwd = old_pwd_field.text!
        newPwd = new_pwd_field.text!
        cnfrmPwd = confirm_pwd_field.text!
        
        if (newPwd == cnfrmPwd){
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.changePassword(defaultdriverid, oldPwd: oldPwd, newPwd: newPwd)
        }
        
    }
    
  
    
    // ********************* Textfield delegate ***************************
    
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    
    // ********************* Success state ***************************

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! ChangePassword
        if(self.data.result == 1){
            
            let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: self.data.msg! , preferredStyle: .Alert)
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