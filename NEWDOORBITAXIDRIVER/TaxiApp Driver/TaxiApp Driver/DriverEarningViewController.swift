//
//  DriverEarningViewController.swift
//  TaxiApp Driver
//
//  Created by AppOrio on 07/02/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit

class DriverEarningViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ParsingStates {
    
    var tablesize = 0
    
    var mydata : DriverEarningModel!
    
    var toastLabel : UILabel!

    
    @IBOutlet weak var earningtable: UITableView!
    
    let driverid =   NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!

    
    
    @IBAction func backbtn(sender: AnyObject) {
        dismissViewcontroller()
       //  self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-300, 300, 35))
        toastLabel.backgroundColor = UIColor.whiteColor()
        toastLabel.textColor = UIColor.blackColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(toastLabel)
        toastLabel.text = NSLocalizedString("No Earning!!", comment: "")
        
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.DriverEarning(self.driverid)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
             return tablesize
        
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = earningtable.dequeueReusableCellWithIdentifier("DriverEarning", forIndexPath: indexPath)
        
        
         let totalrides : UILabel = (cell.contentView.viewWithTag(1) as? UILabel)!
         let totalearning : UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        let datelabel : UILabel = (cell.contentView.viewWithTag(3) as? UILabel)!
        
        totalrides.text = String(mydata.msg![indexPath.row].rides!)
        totalearning.text =  "LKR " +  String(mydata.msg![indexPath.row].amount!)
        datelabel.text = mydata.msg![indexPath.row].rideDate
        
        
        
        return cell
        
        
        
    }
    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        
        
        mydata = data as! DriverEarningModel
        
        if(self.mydata.result == 419){
            
            NsUserDefaultManager.SingeltonInstance.logOut()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
            self.presentViewController(next, animated: true, completion: nil)
            
            
            
        }else if(mydata.result == 0){
            
            toastLabel.hidden = false
            earningtable.hidden = true
        }else{
            
            
            toastLabel.hidden = true
            earningtable.hidden = false
            
            tablesize = (mydata.msg?.count)!
            
            earningtable.reloadData()
        }
    }

   
}
