//
//  CustomSupportViewController.swift
//  TaxiApp Driver
//
//  Created by AppOrio on 06/04/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit

class CustomSupportViewController: UIViewController,ParsingStates {
    
    @IBOutlet weak var entername: UITextField!
    
    @IBOutlet weak var enteremail: UITextField!
    
     var data: CustomerSupportModel!
    @IBOutlet weak var nameview: UIView!
    
    @IBOutlet weak var emailview: UIView!
    
    @IBOutlet weak var enterphone: UITextField!
    
    @IBOutlet weak var queryview: UIView!
    
    @IBOutlet weak var enterquerytext: UITextView!
    @IBOutlet weak var phoneview: UIView!
    
   var driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameview.layer.borderWidth = 1.0
        self.nameview.layer.cornerRadius = 4
        self.emailview.layer.borderWidth = 1.0
        self.emailview.layer.cornerRadius = 4
        self.phoneview.layer.borderWidth = 1.0
        self.phoneview.layer.cornerRadius = 4
        self.queryview.layer.borderWidth = 1.0
        self.queryview.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backbtn(sender: AnyObject) {
        
        dismissViewcontroller()
        
         //self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    @IBAction func sendbtn(sender: AnyObject) {
        
        if entername.text!.characters.count < 2
        {
            self.showAlertMessage("", Message: NSLocalizedString("Please Check Your Name", comment: ""));
            
        }
        else if enteremail.text!.characters.count < 2{
        
         self.showAlertMessage("", Message: NSLocalizedString("Please Check Your Email", comment: ""));
        
        }
        else if (!enteremail.text!.containsString("@"))
        {
            let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message:NSLocalizedString(" Wrong Email format ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
            
        else if (enteremail.text!.containsString(" "))
        {
            let alert = UIAlertController(title: "", message:NSLocalizedString(" Email id must not contain space ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }else{


        
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.CustomerSupportApi(driverid, Name: self.entername.text!, Email: self.enteremail.text!, Phone: self.enterphone.text!, Query: self.enterquerytext.text!)
        }
        
        
        
    }
    
    func showAlertMessage(title:String,Message:String){
        
        let alert = UIAlertController(title: title, message: Message, preferredStyle: .Alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}
    }
    

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        if (resultCode == 5555){
            self.data = data as! CustomerSupportModel
            if(self.data.result == 1){
                
             self.showAlertMessage("", Message: (self.data.msg!))

        
            }else{
            self.showAlertMessage("", Message: (self.data.msg!))
            
            }
            
        }
    }

}
