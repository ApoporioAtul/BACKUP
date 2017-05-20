//
//  RegisterNewEmailViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 06/04/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class RegisterNewEmailViewController: UIViewController {
    
    
    @IBOutlet weak var enteremaitext: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  enteremaitext.text = "please enter email"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
   
    @IBAction func savebtn(sender: AnyObject) {
        
    }
    
    @IBAction func cancelbtn(sender: AnyObject) {
        
        enteremaitext.text = ""
        
    }
    
    

}
