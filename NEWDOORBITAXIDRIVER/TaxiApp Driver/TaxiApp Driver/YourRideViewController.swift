//
//  YourRideViewController.swift
//  TaxiApp Driver
//
//  Created by AppOrio on 07/02/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit

class YourRideViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ParsingStates  {

    
    var toastLabel : UILabel!
    
    var mydata: AllRides!
    
    var collectionsize = 0
    
    @IBOutlet weak var yourridetable: UITableView!

    let driverid =   NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         GlobalVariables.cancelbtnvaluematch = "1"
      //  GlobalVarible.cancelbtnvaluematch = "1"
        
        toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-300, 300, 35))
        toastLabel.backgroundColor = UIColor.whiteColor()
        toastLabel.textColor = UIColor.blackColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(toastLabel)
        toastLabel.text = NSLocalizedString("No Rides!!", comment: "")
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.ShowAllRides(self.driverid)
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backbtn(sender: AnyObject) {
        dismissViewcontroller()
         //self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if GlobalVariables.cancelbtnvaluematch == "2"{
        
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.ShowAllRides(self.driverid)

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
        
        let cell = yourridetable.dequeueReusableCellWithIdentifier("YourRide", forIndexPath: indexPath) as! YourrideTableViewCell
        
        let checkstatus = mydata.msg![indexPath.row].rideStatus
        
        cell.datetimelabel.text = mydata.msg![indexPath.row].rideDate! + "  " + mydata.msg![indexPath.row].rideTime!
        cell.pickuplabel.text = mydata.msg![indexPath.row].pickupLocation
        
     //   cell.carname.text = mydata.msg![indexPath.row].carTypeName
        
     //   let cartypeimage = mydata.msg![indexPath.row].carTypeImage
        
        
        
      /*  if(cartypeimage == ""){
            cell.carimage.image = UIImage(named: "profileeee") as UIImage?
            
            print("No Image")
        }else{
            let url = "http://apporio.co.uk/apporiotaxi/\(cartypeimage!)"
            print(url)
            
            let url1 = NSURL(string: url)
            cell.carimage!.af_setImageWithURL(url1!,
                                              placeholderImage: UIImage(named: "dress"),
                                              filter: nil,
                                              imageTransition: .CrossDissolve(1.0))
        }
        */
        
        
        if(checkstatus == "2"){
            cell.cancelimage.hidden = false
            cell.cancelimage.image = UIImage(named: "cancel") as UIImage?
            cell.pickuplabel.text = mydata.msg![indexPath.row].pickupLocation
            cell.dotimage.hidden = false
            cell.redimage.hidden = false
            cell.ongoinglabel.text = ""
            cell.dropuplabel.text = mydata.msg![indexPath.row].dropLocation
            
            
        }
        
        if (checkstatus == "1"){
            
            cell.ongoinglabel.text = NSLocalizedString("SCHEDULED", comment: "")
            //  cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.pickuplabel.text = mydata.msg![indexPath.row].pickupLocation
            cell.dotimage.hidden = false
            cell.redimage.hidden = false
            cell.dropuplabel.text = mydata.msg![indexPath.row].dropLocation
            cell.cancelimage.hidden = true
            
        }
        
        if (checkstatus == "3"){
            
            cell.ongoinglabel.text = NSLocalizedString("Accepted", comment: "")
            //   cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.pickuplabel.text = mydata.msg![indexPath.row].pickupLocation
            cell.dotimage.hidden = false
            cell.redimage.hidden = false
            cell.dropuplabel.text = mydata.msg![indexPath.row].dropLocation
            cell.cancelimage.hidden = true
            
            
        }
        if (checkstatus == "4"){
            
            cell.ongoinglabel.text = NSLocalizedString("REJECTED", comment: "")
            //  cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.pickuplabel.text = mydata.msg![indexPath.row].pickupLocation
            cell.dotimage.hidden = false
            cell.redimage.hidden = false
            cell.dropuplabel.text = mydata.msg![indexPath.row].dropLocation
            cell.cancelimage.hidden = true
            
            
        }
        if (checkstatus == "5"){
            
            cell.ongoinglabel.text = NSLocalizedString("Driver Arrived", comment: "")
            //   cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.pickuplabel.text = mydata.msg![indexPath.row].pickupLocation
            cell.dotimage.hidden = false
            cell.redimage.hidden = false
            cell.dropuplabel.text = mydata.msg![indexPath.row].dropLocation
            cell.cancelimage.hidden = true
            
            
        }
        
        if (checkstatus == "6"){
            
            cell.ongoinglabel.text = NSLocalizedString("ONGOING", comment: "")
            //   cell.ongoinglabel.textColor = UIColor.greenColor()
            cell.pickuplabel.text = mydata.msg![indexPath.row].beginLocation
            cell.dotimage.hidden = false
            cell.redimage.hidden = false
            cell.dropuplabel.text = mydata.msg![indexPath.row].dropLocation
            cell.cancelimage.hidden = true
            
        }
        
        if (checkstatus == "7"){
            cell.cancelimage.hidden = false
            cell.ongoinglabel.text = "LKR " + mydata.msg![indexPath.row].amount! 
            cell.pickuplabel.text = mydata.msg![indexPath.row].beginLocation
            cell.dropuplabel.text = mydata.msg![indexPath.row].endLocation
            cell.cancelimage.image = UIImage(named: "completed") as UIImage?
            cell.dotimage.hidden = false
            cell.redimage.hidden = false
            
            
        }
        
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       yourridetable.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print("Row: \(row)")
        
        let value = mydata.msg![indexPath.row].rideStatus
        
        let datevalue = mydata.msg![indexPath.row].rideDate! + "  " + mydata.msg![indexPath.row].rideTime!
        
        let rideidvalue = mydata.msg![indexPath.row].rideId
        
        print(value)
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let fulldetailsViewController = storyBoard.instantiateViewControllerWithIdentifier("FullDetailsViewController") as! FullDetailsViewController
        fulldetailsViewController.ridestausvalue = value!
        fulldetailsViewController.datetimedata = datevalue
        fulldetailsViewController.rideid = rideidvalue!
        self.presentViewController(fulldetailsViewController, animated:true, completion:nil)
        
    }
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
    
    
    
        mydata = data as! AllRides
        
        if(self.mydata.result == 419){
            
            NsUserDefaultManager.SingeltonInstance.logOut()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
            self.presentViewController(next, animated: true, completion: nil)
            
      
        }else if(mydata.result == 0){
            
            toastLabel.hidden = false
            yourridetable.hidden = true
            
            
        }else{
            
            toastLabel.hidden = true
            yourridetable.hidden = false
            
           collectionsize = (mydata.msg?.count)!
            
            yourridetable.reloadData()
            
        }
        
    
    
    }
    

   }
