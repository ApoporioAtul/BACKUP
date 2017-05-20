//
//  SelectPaymentViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 01/03/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class SelectPaymentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MainCategoryProtocol {
    
    var mydata : ViewPaymentModel!
    
    var check = 1000

    var Size = 0
    
    var selectvalue = ""
    
    @IBOutlet weak var donebtn: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.donebtn.layer.borderWidth = 1.0
        self.donebtn.layer.cornerRadius = 4
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ViewPaymentOption()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if(GlobalVarible.MatchCardSelect == 1){
            GlobalVarible.MatchCardSelect = 0
        self.dismissViewControllerAnimated(true, completion: nil)
        
        }else{
        
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return Size
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cell   = tableView.dequeueReusableCellWithIdentifier("paymentcell" , forIndexPath: indexPath)
        
        let titlename :UILabel = (cell.contentView.viewWithTag(2) as? UILabel)!
        
        let imageview : UIImageView = (cell.contentView.viewWithTag(1) as? UIImageView)!
        
        titlename.text = mydata.msg![indexPath.row].paymentOptionName
        
        if(check == indexPath.row)
        {
            
            imageview.image = UIImage(named: "Circled Dot-35 (1)") as UIImage?
            
        }else{
            imageview.image = UIImage(named: "Circle Thin-35 (1)") as UIImage?
            
        }
        
        
        //  imageview.image = UIImage(named: "Circle Thin-30") as UIImage?
        
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        check = indexPath.row
        
        selectvalue = mydata.msg![indexPath.row].paymentOptionId!
        GlobalVarible.paymentmethod = mydata.msg![indexPath.row].paymentOptionName!
        
      //  print(mydata.msg![indexPath.row].paymentOptionId)
        tableView.reloadData()
        
        
        /*let  cell   = tableView.dequeueReusableCellWithIdentifier("dialogcell" , forIndexPath: indexPath)
         
         let imageview : UIImageView = (cell.contentView.viewWithTag(2) as? UIImageView)!
         
         imageview.image = UIImage(named: "Circled Dot-30") as UIImage?*/
    }

    

   
    @IBAction func donebtn(sender: AnyObject) {
        
        if(selectvalue == ""){
        
        self.showalert("Please select Payment Option First!!")
            
        }
        else if(selectvalue == "3"){
             GlobalVarible.PaymentOptionId = selectvalue
            
          //  self.dismissViewControllerAnimated(true, completion: nil)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let selectcardviewcontroller = storyBoard.instantiateViewControllerWithIdentifier("SelectCardViewController") as! SelectCardViewController
            
            self.presentViewController(selectcardviewcontroller, animated:true, completion:nil)
            
            //self.dismissViewControllerAnimated(true, completion: nil)
        
        
        }else{
        GlobalVarible.PaymentOptionId = selectvalue
        self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
        
        
    }
    
    
    func showalert(message:String)  {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let alertController = UIAlertController(title:  NSLocalizedString("Alert", comment: ""), message:message, preferredStyle: .Alert)
            
            
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
        
        mydata = data as! ViewPaymentModel
        
        if(mydata.result == 0){
        Size = 0
        
        }else{
            
        Size = (mydata.msg?.count)!
            
        tableview.reloadData()
        
        }
        
        
        
    }

  
    
    
}
