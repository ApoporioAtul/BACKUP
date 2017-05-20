//
//  ReasonDialogController.swift
//  IzyCabs
//
//  Created by AppOrio on 16/02/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class ReasonDialogController: UIViewController,UITableViewDataSource,UITableViewDelegate,MainCategoryProtocol {
    
    
    var reasonData: ReasonModel!
    //  var cancelData: BookingCancelled!
    var SIZE = 0
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cancel_btn: UIButton!
    
    @IBOutlet weak var notCancel_btn: UIButton!
    

    @IBOutlet weak var selectreasonlabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectreasonlabel.text = NSLocalizedString("Select Reason", comment: "")
        
       //   NSLocalizedString("Cancel", comment: "")
        
             self.cancel_btn.setTitle(NSLocalizedString("Cancel", comment: ""), forState: .Normal)
        
         self.notCancel_btn.setTitle(NSLocalizedString("Don't Cancel", comment: ""), forState: .Normal)
        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        cancel_btn.enabled = false
        cancel_btn.layer.backgroundColor = ReasonDialogController.getColorFromHex("#979897").CGColor
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.reasonCancel()
        
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    class func getColorFromHex(hexString:String)->UIColor{
        
        var rgbValue : UInt32 = 0
        let scanner:NSScanner =  NSScanner(string: hexString)
        
        scanner.scanLocation = 1
        scanner.scanHexInt(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    
    @IBAction func donotCancel_click(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel_click(sender: AnyObject) {
        
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        
        let myRes = ApiManager.sharedInstance.CancelRide(GlobalVarible.RideId, RIDESTATUS: "2")
        
        let status = myRes["result"]
        
        if(status == 1){
            
            
            self.showalert1(NSLocalizedString("Cancel Successfully!!", comment: ""))
            //self.dismissViewControllerAnimated(true, completion: nil)
            
        }else{
            
            self.showalert(NSLocalizedString("Please Try Again!!", comment: ""))
        }
        
        
        // APIManager.sharedInstance.delegate = self
        // APIManager.sharedInstance.cancelRide(GlobalVariables.rideid, cancelReasonid: GlobalVariables.cancelId)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SIZE
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("reasonCell", forIndexPath: indexPath) as! ReasonCell
        cell.selectionStyle = .None
        cell.reasonText.text = self.reasonData.msg![indexPath.row].reasonName!
        cell.checkRadioBtn.image = UIImage(named: "Circle Thin-35 (1)")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cells = tableView.cellForRowAtIndexPath(indexPath) as! ReasonCell
        let row = indexPath.row
        print("Row:\(row)")
        cancel_btn.enabled = true
        GlobalVarible.cancelId = self.reasonData.msg![row].reasonId!
        print(GlobalVarible.cancelId)
        cancel_btn.layer.backgroundColor = ReasonDialogController.getColorFromHex("#ffc900").CGColor
        cells.checkRadioBtn.image = UIImage(named: "Circled Dot-35 (1)")
        
    }
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                
            }
            
            
        })
        
    }
    
    
    func showalert1(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
            let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .Default) { (action) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let revealViewController:NewMapViewController = storyBoard.instantiateViewControllerWithIdentifier("NewMapViewController") as! NewMapViewController
                
                self.presentViewController(revealViewController, animated:true, completion:nil)
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
        print("msg")
        
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
        
        if(GlobalVarible.Api == "cancelreason"){
            
            reasonData = data as! ReasonModel
            
            if reasonData.result == 1{
                
                if let size = reasonData.msg?.count
                {
                    SIZE = size
                    
                }
                
                self.tableView.reloadData()
                
                
            }
            
            
            
        }
        
        
        
    }
    


   

}
