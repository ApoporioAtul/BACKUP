//
//  AboutusViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 24/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON
class AboutusViewController: UIViewController,MainCategoryProtocol {
    
    var mydata: TermsModel!
    
    
    @IBOutlet weak var abouttextview: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.AboutUs()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
      //  self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }

    
   /* @IBAction func TCbtn(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let termsViewController = storyBoard.instantiateViewControllerWithIdentifier("TemsConditionsViewController") as! TemsConditionsViewController
        self.presentViewController(termsViewController, animated:true, completion:nil)
        
    }*/
    
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: "") , style: .Default) { (action) in
                
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
        
        
        mydata = data as! TermsModel
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
           abouttextview.text = mydata.details!.descriptionValue!.html2String
        }else{
           abouttextview.text = mydata.details!.descriptionOther!.html2String
        }
        

                    
        
    }
    
     
}

extension String {
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = dataUsingEncoding(NSUTF8StringEncoding)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
