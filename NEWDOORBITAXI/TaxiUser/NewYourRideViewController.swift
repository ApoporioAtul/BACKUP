//
//  NewYourRideViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 31/03/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class NewYourRideViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,   MainCategoryProtocol  {
    
    let imageUrl = API_URL.imagedomain
    
    @IBAction func backbtn(sender: AnyObject) {
        
         self.dismissViewControllerAnimated(true, completion: nil)
        
        //  self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet weak var newridetable: UITableView!
    
    var toastLabel : UILabel!
    
    var mydata: AllRides!
    
    var collectionsize = 0

    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GlobalVarible.cancelbtnvaluematch = "1"
        
        toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-300, 300, 35))
        toastLabel.backgroundColor = UIColor.whiteColor()
        toastLabel.textColor = UIColor.blackColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(toastLabel)
        toastLabel.text =  NSLocalizedString("No Rides!!", comment: "")
        
        toastLabel.hidden = true
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ShowAllRides(self.Userid!)
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if GlobalVarible.cancelbtnvaluematch == "2"{
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ShowAllRides(self.Userid!)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*  if(mydata == nil ){
         return 0
         }else {
         return (mydata.message?.count)!
         }*/
        return collectionsize
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = newridetable.dequeueReusableCellWithIdentifier("NewRide1", forIndexPath: indexPath) as! NewYourRideTableViewCell
        
        
        cell.mainview.layer.shadowColor = UIColor.grayColor().CGColor
        cell.mainview.layer.shadowOpacity = 1
        cell.mainview.layer.cornerRadius = 5
        cell.mainview.layer.shadowOffset = CGSizeMake(0, 5)
        cell.mainview.layer.shadowRadius = 5
        
        let checkstatus = mydata.msg![indexPath.row].rideStatus
        
        cell.datelabel.text = mydata.msg![indexPath.row].rideDate! + "," + mydata.msg![indexPath.row].rideTime!
        cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
        
        cell.carnamelabel.text = mydata.msg![indexPath.row].carTypeName
        
       // let cartypeimage = mydata.msg![indexPath.row].carTypeImage
        
        
        let pickuplat = Double(mydata.msg![indexPath.row].pickupLat!)!
        let pickuplong = Double(mydata.msg![indexPath.row].pickupLong!)!
        
        
        let url11 = "https://maps.googleapis.com/maps/api/staticmap?center=\(pickuplat),\(pickuplong)&zoom=15&size=600x600&key=AIzaSyC8J9saj7enSdCNz50CFgavWlrbNiI3mUA"
        
        let url1 = NSURL(string: url11)
        
        cell.firstmapimageview!.af_setImageWithURL(url1!,
                                                   placeholderImage: UIImage(named: "dress"),
                                                   filter: nil,
                                                   imageTransition: .CrossDissolve(1.0))
        
        let dropuplat = Double(mydata.msg![indexPath.row].dropLat!)!
        let dropuplong = Double(mydata.msg![indexPath.row].dropLong!)!

        
        
        let url22 = "https://maps.googleapis.com/maps/api/staticmap?center=\(dropuplat),\(dropuplong)&zoom=15&size=600x600&key=AIzaSyC8J9saj7enSdCNz50CFgavWlrbNiI3mUA"
        
        let url2 = NSURL(string: url22)
        cell.secondimageview!.af_setImageWithURL(url2!,
                                                 placeholderImage: UIImage(named: "dress"),
                                                 filter: nil,
                                                 imageTransition: .CrossDissolve(1.0))
        
        

        
        
        
            if(checkstatus == "2"){
          //  cell.cancelimage.hidden = false
            cell.driverimage.image = UIImage(named: "cancel") as UIImage?
            cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
            
         
            
            
          //  cell.dotimage.hidden = false
           // cell.redimage.hidden = false
            cell.statuslabel.text = "CANCELED"
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
            
            
        }
        
        if (checkstatus == "1"){
            
            cell.statuslabel.text = NSLocalizedString("SCHEDULED", comment: "")
            //  cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
            
            
           
            
            

           // cell.dotimage.hidden = false
            //cell.redimage.hidden = false
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
           // cell.cancelimage.hidden = true
            
        }
        
        if (checkstatus == "3"){
            
            cell.statuslabel.text = NSLocalizedString("SCHEDULED", comment: "")
            //   cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
            
            
            
            

           // cell.dotimage.hidden = false
           // cell.redimage.hidden = false
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
           // cell.cancelimage.hidden = true
            
            
        }
        if (checkstatus == "4"){
            
            cell.statuslabel.text = NSLocalizedString("REJECTED", comment: "")
            //  cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
            
            

           // cell.dotimage.hidden = false
           // cell.redimage.hidden = false
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
           // cell.cancelimage.hidden = true
            
            
        }
        if (checkstatus == "5"){
            
            cell.statuslabel.text = NSLocalizedString("Driver Arrived", comment: "")
            //   cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
            
         //  cell.dotimage.hidden = false
          //  cell.redimage.hidden = false
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
          //  cell.cancelimage.hidden = true
            
            
        }
        
        if (checkstatus == "6"){
            
            cell.statuslabel.text = NSLocalizedString("ONGOING", comment: "")
            //   cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.firstlocation.text = mydata.msg![indexPath.row].beginLocation
            
         
           // cell.dotimage.hidden = false
           // cell.redimage.hidden = false
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
          //  cell.cancelimage.hidden = true
            
        }
        
        if (checkstatus == "7"){
          //  cell.cancelimage.hidden = false
            cell.pricelabel.text =  "LKR " + mydata.msg![indexPath.row].amount!
            cell.firstlocation.text = mydata.msg![indexPath.row].beginLocation
            
            

            cell.secondlocation.text = mydata.msg![indexPath.row].endLocation
            cell.statuslabel.text = NSLocalizedString("COMPLETED", comment: "")
            cell.driverimage.image = UIImage(named: "completed") as UIImage?
            //cell.dotimage.hidden = false
            //cell.redimage.hidden = false
            
            
        }
        
        if (checkstatus == "8"){
            cell.statuslabel.text = "SCHEDULED"
            //  cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
            
            

          //  cell.dotimage.hidden = false
           // cell.redimage.hidden = false
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
         //   cell.cancelimage.hidden = true
            
            
        }
        
        if (checkstatus == "9"){
            cell.statuslabel.text = "CANCELED"
         //   cell.cancelimage.hidden = false
            cell.driverimage.image = UIImage(named: "cancel") as UIImage?
            cell.firstlocation.text = mydata.msg![indexPath.row].pickupLocation
            
                   // cell.dotimage.hidden = false
           // cell.redimage.hidden = false
          //  cell.ongoinglabel.text = ""
            cell.secondlocation.text = mydata.msg![indexPath.row].dropLocation
            
            
            
        }
        
        
        
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        newridetable.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        let value = mydata.msg![indexPath.row].rideStatus
        
        let datevalue = mydata.msg![indexPath.row].rideDate! + "  " + mydata.msg![indexPath.row].rideTime!
        
        let rideidvalue = mydata.msg![indexPath.row].rideId
        
        print(value)
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let fulldetailsViewController = storyBoard.instantiateViewControllerWithIdentifier("NewFullDetailsViewController") as! NewFullDetailsViewController
        fulldetailsViewController.ridestausvalue = value!
        fulldetailsViewController.datetimedata = datevalue
        fulldetailsViewController.rideid = rideidvalue!
        self.presentViewController(fulldetailsViewController, animated:true, completion:nil)
        
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
        
        if(GlobalVarible.RideResult == 0){
            
            toastLabel.hidden = false
            newridetable.hidden = true
            
            
        }else{
            
            toastLabel.hidden = true
            newridetable.hidden = false
            
            mydata = data as! AllRides
            
            if(mydata.result == 0){
                collectionsize = 0
                
            }else{
                collectionsize = (mydata.msg?.count)!
                
            }
            
            newridetable.reloadData()
            
        }
        
        
    }
    

    

   

}
