//
//  ReasonDialogController.swift
//  IzyCabs Driver
//
//  Created by AppOrio on 16/02/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit

class ReasonDialogController: UIViewController,UITableViewDelegate,UITableViewDataSource,ParsingStates  {
    
    
    var reasonData: ReasonModel!
    var cancelData: CancelRideModel!
    var SIZE = 0
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cancel_btn: UIButton!
    
    @IBOutlet weak var notCancel_btn: UIButton!
    
    var check = 1000
    

    @IBOutlet weak var selectreasonlabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        selectreasonlabel.text = NSLocalizedString("Select Reason", comment: "")
        
        //   NSLocalizedString("Cancel", comment: "")
        
        self.cancel_btn.setTitle( NSLocalizedString("Cancel", comment: ""), forState: .Normal)
        
        self.notCancel_btn.setTitle(NSLocalizedString("Don't Cancel", comment: ""), forState: .Normal)

        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        cancel_btn.enabled = false
        cancel_btn.layer.backgroundColor = ReasonDialogController.getColorFromHex("#979897").CGColor
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.reasonCancel()


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
        
        APIManager.sharedInstance.delegate = self
        APIManager.sharedInstance.CancelDriver(GlobalVariables.rideid)
        
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
        if(check == indexPath.row)
        {
            
            cell.checkRadioBtn.image = UIImage(named: "radio_checked")
            
        }else{
            cell.checkRadioBtn.image = UIImage(named: "radio_unchecked")
            
        }
       // cell.checkRadioBtn.image = UIImage(named: "radio_unchecked")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cells = tableView.cellForRowAtIndexPath(indexPath) as! ReasonCell
        let row = indexPath.row
        check = indexPath.row
        print("Row:\(row)")
        cancel_btn.enabled = true
        GlobalVariables.cancelId = self.reasonData.msg![row].reasonId!
        print(GlobalVariables.cancelId)
        cancel_btn.layer.backgroundColor = ReasonDialogController.getColorFromHex("FFC900").CGColor
        //cells.checkRadioBtn.image = UIImage(named: "radio_checked")
        tableView.reloadData()
        
    }
    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        if resultCode == 1005{
            
            self.reasonData = data as! ReasonModel
            if self.reasonData.result == 1{
                
                if let size =  self.reasonData.msg?.count
                {
                    SIZE = size
                    
                }
                
                self.tableView.reloadData()
                
                
            }
            
        }
        
        if resultCode == 1006{
            self.cancelData = data as! CancelRideModel
            
            if self.cancelData.result == 1{
                
                let alert = UIAlertController(title: "", message: NSLocalizedString("Booking Cancelled !", comment: ""), preferredStyle: .Alert)
                let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let next: OnLineController = storyboard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
                    self.presentViewController(next, animated: true, completion: nil)
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
                
                
            }
        }
        
    }
    

    

   
}
