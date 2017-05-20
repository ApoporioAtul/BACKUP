//
//  RearTableViewController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 19/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit
import AlamofireImage
import MessageUI

class RearTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , MFMailComposeViewControllerDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         profile_image.layer.cornerRadius =  profile_image.frame.width/2
         profile_image.clipsToBounds = true
         profile_image.layer.borderWidth = 1
         profile_image.layer.borderColor = UIColor.blackColor().CGColor
        
       // APIManager.sharedInstance.ContactApi()
        TextArray = [NSLocalizedString("Profile", comment: ""),NSLocalizedString("My Rides", comment: ""),NSLocalizedString("Earnings", comment: ""),NSLocalizedString("Report Issue", comment: ""),NSLocalizedString("Call Support", comment: ""),NSLocalizedString("Terms Conditions", comment: ""),NSLocalizedString("About Us", comment: "")]
        
        
       // ImageArray = ["User-48 (1)","myride","Pricing Structure-48","report","call","tc","about_us"]
        
        ImageArray = ["profile","yourrides","earning1","report-1","call-1","tc-1","about"]
        
        
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCellController
        
        cell.selectionStyle = .None
        
        cell.textValue.text = TextArray[indexPath.row]
        cell.imageIcon.image = UIImage(named: ImageArray[indexPath.row])
        
        
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
             self.revealViewController().revealToggleAnimated(true)
            
            
            
            
        }
        
        if (indexPath.row == 1)
        {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: YourRideViewController = storyboard.instantiateViewControllerWithIdentifier("YourRideViewController") as! YourRideViewController
            self.presentViewController(nextController, animated: true, completion: nil)
            
            
            self.revealViewController().revealToggleAnimated(true)

            
            
           
        }
        
        if (indexPath.row == 2)
        {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: DriverEarningViewController = storyboard.instantiateViewControllerWithIdentifier("DriverEarningViewController") as! DriverEarningViewController
            self.presentViewController(nextController, animated: true, completion: nil)
            self.revealViewController().revealToggleAnimated(true)
            
            
            

           
        }
        
        if (indexPath.row == 3)
        {
            
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            self.revealViewController().revealToggleAnimated(true)
            
            
        }
        
        if (indexPath.row == 4){
        
            
            
            UIApplication.sharedApplication().openURL(NSURL(string : "tel://\(ContactTelephone)")!)
            
            self.revealViewController().revealToggleAnimated(true)
            

                   }
        
        if (indexPath.row == 5){
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: TCController = storyboard.instantiateViewControllerWithIdentifier("TCController") as! TCController
            self.presentViewController(nextController, animated: true, completion: nil)
            
            self.revealViewController().revealToggleAnimated(true)
            
        
        }
        
        if(indexPath.row == 6){
        
            
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextController: AboutUsController = storyboard.instantiateViewControllerWithIdentifier("AboutUsController") as! AboutUsController
            self.presentViewController(nextController, animated: true, completion: nil)
            self.revealViewController().revealToggleAnimated(true)
            

        
        }
        
        
    

    }
    
    
}