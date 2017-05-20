//
//  RideFareController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 30/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit
import StarryStars

class RideFareController: UIViewController , RatingViewDelegate , ParsingStates{
    
    @IBOutlet weak var ratingView: RatingView!
    var rating: Float = 0.0
    let imageUrl = API_URLs.imagedomain
    var data: RateCustomer!
    var ratingValue: String = ""
    var defaultdriverid = ""
    var comment = ""
    @IBOutlet weak var totalTime: UITextView!
    @IBOutlet weak var totalDistance: UITextView!
    @IBOutlet weak var totalPrice: UITextView!
    
    @IBOutlet weak var comment_field: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func back_click(sender: AnyObject) {
        
        dismissViewcontroller()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaultdriverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!

        totalTime.text = GlobalVariables.totaltime + " min"
        totalPrice.text =  "LKR " + GlobalVariables.totalamount 
        totalDistance.text = GlobalVariables.totaldistance + " Kms"
        
        ratingView.editable = true
        ratingView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.scrollView.bounds
        self.scrollView.contentSize.height = 600
        self.scrollView.contentSize.width = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done_pressed(sender: AnyObject) {
        
        comment = comment_field.text!
       /* if comment == "" {
            let alert = UIAlertController(title: "", message:NSLocalizedString("Please enter comment", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
        }
        else {*/
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.rateCustomer(self.defaultdriverid, customerid: GlobalVariables.custId, rating: GlobalVariables.finalRating, comment: comment,RideId: GlobalVariables.rideid)
        //}
        
    }
    
    func ratingView(ratingView: RatingView, didChangeRating newRating: Float) {
        print("newRating: \(newRating)")
        rating = newRating
        ratingValue = String(rating)
        GlobalVariables.finalRating = ratingValue
    }
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! RateCustomer
        
        if(self.data.result == 419){
            
            NsUserDefaultManager.SingeltonInstance.logOut()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
            self.presentViewController(next, animated: true, completion: nil)
            
            
            
        }else if (self.data.result == 1){
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: OnLineController = storyboard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
            self.presentViewController(next, animated: true, completion: nil)
        }
        
        
    }

    
}