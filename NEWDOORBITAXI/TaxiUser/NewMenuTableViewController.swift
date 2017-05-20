//
//  NewMenuTableViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 29/03/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import MessageUI

/*class NewMenuTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var profilename: UILabel!
    
    @IBOutlet weak var profileemail: UILabel!

    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var menutable: UITableView!
    
   // var dataArray: [String] = [NSLocalizedString("Book a Rides", comment: ""),NSLocalizedString("Profile", comment: ""),NSLocalizedString("My Rides", comment: ""),NSLocalizedString("Rate Card", comment: ""),NSLocalizedString("Credit Card", comment: ""),NSLocalizedString("Report Issue", comment: ""),NSLocalizedString("Call Support", comment: ""),NSLocalizedString("Terms Conditions", comment: ""),NSLocalizedString("About", comment: "")]
    
    // var imageArray: [String] = ["Car-25","User-48 (1)","myride","ratecard","Bank Card Back Side-30 (1)","System Report Filled-25","Missed Call-25","Info-25","Info-25"]
    
    var dataArray: [String] = ["BOOK RIDES","YOUR TRIPS","PAYMENTS","RATE CARD","REPORT ISSUE","CALL SUPPORT","TERMS AND CONDITION","ABOUT US"]
    
    
    var imageArray: [String] = ["ic_book","ic_trips","ic_payment","ic_tag_us_dollar","system_report","missed_call","ic_terms_condition","ic_about_us"]
    
    
    var Name = ""
    var email = ""
    
    var Userimage = ""

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.innerview.layer.addAnimation(transition, forKey: kCATransition)*/
        
              
        innerview.layer.cornerRadius = 6
        
        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        
       // let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(NewMenuTableViewController.viewTapped(_:)))
       // mainView.addGestureRecognizer(tapGestureRecognizer)
        
        
        profileimage.layer.borderWidth = 1
        profileimage.layer.masksToBounds = false
        profileimage.layer.borderColor = UIColor.blackColor().CGColor
        profileimage.layer.cornerRadius =  profileimage.frame.height/2
        profileimage.clipsToBounds = true
        
        Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyname)!
        
        email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyemail)!
        
        Userimage =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyimage)!
        
        if(Userimage == ""){
            profileimage.image = UIImage(named: "profileeee") as UIImage?
            print("No Image")
        }else{
            let url = "http://apporio.co.uk/apporiotaxi/\(Userimage)"
            print(url)
            
            let url1 = NSURL(string: url)
            profileimage!.af_setImageWithURL(url1!,
                                             placeholderImage: UIImage(named: "dress"),
                                             filter: nil,
                                             imageTransition: .CrossDissolve(1.0))
        }
              
        
        self.profilename.text! = Name
        self.profileemail.text! = email
        
      //  ApiManager.sharedInstance.ContactApi()
        
  
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    @IBAction func profilebtn(sender: AnyObject) {
        
      /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let mapViewController = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        
        self.presentViewController(mapViewController, animated:true, completion:nil)*/
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let mapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewProfileViewController") as! NewProfileViewController
        
        self.presentViewController(mapViewController, animated:true, completion:nil)
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        Name = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyname)!
        
        email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyemail)!
        
        Userimage =  NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyimage)!
        
        self.profilename.text! = Name
        self.profileemail.text! = email
        
        
        if(Userimage == ""){
            profileimage.image = UIImage(named: "profileeee") as UIImage?
            print("No Image")
        }else{
            let url = "http://apporio.co.uk/apporiotaxi/\(Userimage)"
            print(url)
            
            let url1 = NSURL(string: url)
            profileimage!.af_setImageWithURL(url1!,
                                             placeholderImage: UIImage(named: "dress"),
                                             filter: nil,
                                             imageTransition: .CrossDissolve(1.0))
        }
        
        
    }
    
    @IBAction func cancelbtn(sender: AnyObject) {
        
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
   /* func viewTapped(view: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }*/

    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([GlobalVarible.ContactEmail])
        mailComposerVC.setSubject(NSLocalizedString("Report Issue Regarding TaxiUser App", comment: ""))
        mailComposerVC.setMessageBody(NSLocalizedString("Sending e-mail in-app is not so bad!", comment: ""), isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: NSLocalizedString("Could Not Send Email", comment: ""), message: NSLocalizedString("Your device could not send e-mail.  Please check e-mail configuration and try again.", comment: ""), delegate: self, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /* @IBAction func Profilebutton(sender: AnyObject) {
     
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     let mapViewController = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
     
     self.presentViewController(mapViewController, animated:true, completion:nil)
     
     
     }*/
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return dataArray.count
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = menutable.dequeueReusableCellWithIdentifier("MenuTable1", forIndexPath: indexPath)
        
        
        
        let imageview :UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        let label : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        let labelshow : UILabel = (cell.contentView.viewWithTag(3) as? UILabel)!
        
        if indexPath.row == 3{
        labelshow.hidden = false
        
        }else{
        labelshow.hidden = true
        }
        
        let image = UIImage(named: imageArray[indexPath.row])
        
        imageview.image = image
        label.text = dataArray[indexPath.row]
        
        
        
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        menutable.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        
        
        if(indexPath.row == 0){
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            
           // self.revealViewController().revealToggleAnimated(true)
            
        }
        
        if(indexPath.row == 1)
        {
            
            
            
            
           /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let yourViewController = storyBoard.instantiateViewControllerWithIdentifier("YourRideViewController") as! YourRideViewController
            
            self.presentViewController(yourViewController, animated:true, completion:nil)*/
            
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
             let yourViewController = storyBoard.instantiateViewControllerWithIdentifier("NewYourRideViewController") as! NewYourRideViewController
             
             self.presentViewController(yourViewController, animated:true, completion:nil)

            
            
            

            
        }
        
        
        if(indexPath.row == 2)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let selectcardviewcontroller = storyBoard.instantiateViewControllerWithIdentifier("SelectCardViewController") as! SelectCardViewController
            
            self.presentViewController(selectcardviewcontroller, animated:true, completion:nil)
          //  self.revealViewController().revealToggleAnimated(true)
            
            

            
            
            
        }
        
        if(indexPath.row == 3)
        {
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mapViewController = storyBoard.instantiateViewControllerWithIdentifier("RateCardViewController") as! RateCardViewController
            
            self.presentViewController(mapViewController, animated:true, completion:nil)
            
           // self.revealViewController().revealToggleAnimated(true)
            
           
            
        }
        
        if(indexPath.row == 4)
        {
            
            
            
          /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let selectcardviewcontroller = storyBoard.instantiateViewControllerWithIdentifier("SelectCardViewController") as! SelectCardViewController
            
            self.presentViewController(selectcardviewcontroller, animated:true, completion:nil)
            self.revealViewController().revealToggleAnimated(true)*/
            
            
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
         //   self.revealViewController().revealToggleAnimated(true)
            

            
            
            
        }
        
        
        /*if(indexPath.row == 5){
            
            
            
           /* let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            self.revealViewController().revealToggleAnimated(true)*/
            
            
            
        }*/
        
        if(indexPath.row == 5){
            
            
            
            UIApplication.sharedApplication().openURL(NSURL(string : "tel://\(GlobalVarible.ContactTelephone)")!)
          //  self.revealViewController().revealToggleAnimated(true)
            
        }
        
        if(indexPath.row == 6){
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let termsViewController = storyBoard.instantiateViewControllerWithIdentifier("TemsConditionsViewController") as! TemsConditionsViewController
            self.presentViewController(termsViewController, animated:true, completion:nil)
          //  self.revealViewController().revealToggleAnimated(true)
            
            
            
            
        }
        
        if(indexPath.row == 7){
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let aboutViewController = storyBoard.instantiateViewControllerWithIdentifier("AboutusViewController") as! AboutusViewController
            self.presentViewController(aboutViewController, animated:true, completion:nil)
          //  self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
    }
    


}*/
