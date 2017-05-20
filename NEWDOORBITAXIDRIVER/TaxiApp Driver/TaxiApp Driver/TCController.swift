//
//  TCController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//




import UIKit

class TCController: UIViewController , ParsingStates{
    var data: TCClass!
    //var textData: String = ""
    @IBOutlet weak var tcTextview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.tc()
        
    }
    override func viewWillAppear(animated: Bool) {
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_btn_click(sender: AnyObject) {
      //  self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        
        dismissViewcontroller()
    }
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! TCClass
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            tcTextview.text = (self.data.details?.descriptionValue)!
        }else{
            tcTextview.text = (self.data.details?.descriptionOther)!
            
        }
        
        
       /* if (self.data.result == 1){
             tcTextview.text = self.data.details?.desc!
        }*/
        
        
    }

}