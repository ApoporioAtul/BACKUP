//
//  NewRatingViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 05/11/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import StarryStars
import SwiftyJSON

class NewRatingViewController: UIViewController,RatingViewDelegate,MainCategoryProtocol {
    
    @IBOutlet weak var donebtn: UIButton!
    
    @IBOutlet weak var userratingview: RatingView!
    @IBOutlet weak var innerview: UIView!

    @IBOutlet weak var outerratingview: UIView!
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
    var ratingStar = ""
    
    let imageUrl = API_URL.imagedomain
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.donebtn.layer.borderWidth = 1.0
        self.donebtn.layer.cornerRadius = 4

        outerratingview.layer.borderWidth = 1.0
        outerratingview.layer.cornerRadius = 4
        innerview.layer.cornerRadius = 5
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        userratingview.editable = true
        userratingview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func ratingView(ratingView: RatingView, didChangeRating newRating: Float) {
        print("newRating: \(newRating)")
        let rating = newRating
        // var  ratingValue = String(rating)
        ratingStar = String(rating)
        GlobalVarible.RatingValue =  String(rating)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Submitbtn(sender: AnyObject) {
        
        GlobalVarible.UserDropLocationText = NSLocalizedString("Enter Drop Location", comment: "")
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RatingSubmitbtn(Userid!, DriverId: GlobalVarible.DRIVERID , RatingStar: ratingStar,RideId: GlobalVarible.RideId)
        
    }
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:   NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                
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
        
        // if(JSON(data)["msg"].stringValue == "Rating successfully!!")  {
        
        if(JSON(data)["result"] == 1){
            
           /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let revealViewController:SWRevealViewController = storyBoard.instantiateViewControllerWithIdentifier("SWRevealViewController") as! SWRevealViewController
            
            self.presentViewController(revealViewController, animated:true, completion:nil)*/
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
            
            self.presentViewController(revealViewController, animated:true, completion:nil)

            
            
        }else{
          
            self.showalert( NSLocalizedString("Please Try Again!!", comment: ""))
            
            
        }
        
        
    }

   
    
}
