//
//  CustomerInfoController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 30/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//
import UIKit
import StarryStars
import AlamofireImage

class CustomerInfoController: UIViewController,ParsingStates {
    
    var data: ViewUser!
    let imageUrl = API_URLs.imagedomain
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var custImage: UIImageView!
    
    @IBOutlet weak var custAddress: UITextView!
    @IBOutlet weak var custName: UITextView!
    
    @IBOutlet weak var custEmail: UITextView!
    @IBOutlet weak var custNumber: UITextView!
    @IBAction func back_press(sender: AnyObject) {
        dismissViewcontroller()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.viewUserInfo(GlobalVariables.custId)
        
        custImage.layer.cornerRadius =  custImage.frame.width/2
        custImage.clipsToBounds = true
        custImage.layer.borderWidth = 1
        custImage.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! ViewUser
        if (self.data.result == 1){
            custName.text = self.data.details?.userName
            custEmail.text = self.data.details?.userEmail
            custAddress.text = GlobalVariables.pickupLoc
            custNumber.text = self.data.details?.userPhone
            
            let driverratingvalue = self.data.details?.rating
            
            if driverratingvalue == ""{
                print("hjjk")
            }else{
                
                ratingView.rating = Float(driverratingvalue!)!
                
            }
        }
    }
}