//
//  AboutUsController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//


import UIKit

class AboutUsController: UIViewController , ParsingStates {
    
    var data: AboutUs!
    //var textData: String = ""
    
    
    @IBOutlet weak var descriptionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.aboutUs()
         
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        

            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    @IBAction func back_click(sender: AnyObject) {
       dismissViewcontroller()
         //self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
        
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! AboutUs
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            descriptionText.text = (self.data.details?.descriptionValue)!
        }else{
           descriptionText.text = (self.data.details?.descriptionOther)!
            
        }

        
      /*  if (self.data.result == 1){
            
            descriptionText.text = (self.data.details?.desc)!
        }*/

        
    }

    
}