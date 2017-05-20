//
//  NewRearTableViewController.swift
//  TaxiApp Driver
//
//  Created by AppOrio on 05/04/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit
import AlamofireImage
import MessageUI

class NewRearTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var displayView: UIView!
    var TextArray = [String]()
    var ImageArray = [String]()
    let imageUrl = API_URLs.imagedomain
    var drivername = ""
    var driverid = ""
    var driveremail = ""
    
    @IBOutlet weak var email_id: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var menutable: UITableView!
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        innerview.layer.cornerRadius = 6
        
        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false

        
        profile_image.layer.cornerRadius =  profile_image.frame.width/2
        profile_image.clipsToBounds = true
        profile_image.layer.borderWidth = 1
        profile_image.layer.borderColor = UIColor.blackColor().CGColor
        
        
        TextArray = ["Profile","My Rides","Earnings","Report Issue","Customer Support","Terms Conditions","About Us"]
        
        ImageArray = ["ic_profile_circular","ic_trips","ic_earning-1","system_report","missed_call","ic_terms_condition","ic_about_us"]
        
                
        drivername = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDrivername)!
        driveremail = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverEmail)!
        email_id.text = drivername
        profileName.text = driveremail
        
        let image = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverImage)!
        let newUrl = imageUrl + image
        
        let url = NSURL(string: newUrl)
        profile_image.af_setImageWithURL(url!, placeholderImage: UIImage(named: image),
                                         filter: nil, imageTransition: .CrossDissolve(1.0))
        
        
        // let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(RearTableViewController.viewTapped(_:)))
        //  displayView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        drivername = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDrivername)!
        driveremail = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverEmail)!
        email_id.text = drivername
        profileName.text = driveremail
        
        let image = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverImage)!
        let newUrl = imageUrl + image
        
        let url = NSURL(string: newUrl)
        profile_image.af_setImageWithURL(url!, placeholderImage: UIImage(named: image),
                                         filter: nil, imageTransition: .CrossDissolve(1.0))
        
        
        
    }
    
    @IBAction func cancelbtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // ********************* view click to go to edit profile ***************************
    
    
    /* func viewTapped(view: AnyObject){
     
     let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let nextController: EditAccountController = storyboard.instantiateViewControllerWithIdentifier("EditAccountController") as! EditAccountController
     self.presentViewController(nextController, animated: true, completion: nil)
     
     }*/
    
    // ********************* open mail directly on report issue ***************************
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([ContactEmail])
        mailComposerVC.setSubject(NSLocalizedString("Report Issue Regarding TaxiApp Driver App", comment: ""))
        mailComposerVC.setMessageBody(NSLocalizedString("Sending e-mail in-app is not so bad!", comment: ""), isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        let alert = UIAlertController(title: NSLocalizedString("Could Not Send Email", comment: ""), message: NSLocalizedString("Your device could not send e-mail.  Please check e-mail configuration and try again.", comment: ""), preferredStyle: .Alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // ********************* TableView datasource methods ***************************
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TextArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTable1", forIndexPath: indexPath)
        
        cell.selectionStyle = .None
        
        let imageview :UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        let label : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        let labelshow : UILabel = (cell.contentView.viewWithTag(3) as? UILabel)!
        
        if indexPath.row == 2{
            labelshow.hidden = false
            
        }else{
            labelshow.hidden = true
        }

        
        label.text = TextArray[indexPath.row]
        imageview.image = UIImage(named: ImageArray[indexPath.row])
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print("Row:\(row)")
        
        
        
        if (indexPath.row == 0)
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: EditAccountController = storyboard.instantiateViewControllerWithIdentifier("EditAccountController") as! EditAccountController
            self.presentViewController(nextController, animated: true, completion: nil)
          //  self.revealViewController().revealToggleAnimated(true)
            
            
            
        }
        
        if (indexPath.row == 1)
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: YourRideViewController = storyboard.instantiateViewControllerWithIdentifier("YourRideViewController") as! YourRideViewController
            self.presentViewController(nextController, animated: true, completion: nil)
            
            
           // self.revealViewController().revealToggleAnimated(true)
            
            
            
            
        }
        
        if (indexPath.row == 2)
        {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: DriverEarningViewController = storyboard.instantiateViewControllerWithIdentifier("DriverEarningViewController") as! DriverEarningViewController
            self.presentViewController(nextController, animated: true, completion: nil)
          //  self.revealViewController().revealToggleAnimated(true)
            
            
            
            
            
        }
        
        if (indexPath.row == 3)
        {
            
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
          //  self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
        if (indexPath.row == 4){
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: CustomSupportViewController = storyboard.instantiateViewControllerWithIdentifier("CustomSupportViewController") as! CustomSupportViewController
            self.presentViewController(nextController, animated: true, completion: nil)
            

            
           // UIApplication.sharedApplication().openURL(NSURL(string : "tel://\(ContactTelephone)")!)
            
           // self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
        if (indexPath.row == 5){
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: TCController = storyboard.instantiateViewControllerWithIdentifier("TCController") as! TCController
            self.presentViewController(nextController, animated: true, completion: nil)
            
           // self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
        if(indexPath.row == 6){
            
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: AboutUsController = storyboard.instantiateViewControllerWithIdentifier("AboutUsController") as! AboutUsController
            self.presentViewController(nextController, animated: true, completion: nil)
          //  self.revealViewController().revealToggleAnimated(true)
            
            
            
        }
        
        
        
        
    }
    

   

}
