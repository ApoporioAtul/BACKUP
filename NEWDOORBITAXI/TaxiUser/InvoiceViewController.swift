//
//  InvoiceViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 05/11/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

class InvoiceViewController: UIViewController {
    
     var invoicedata : CompletePayment!
    
    
    @IBOutlet weak var pleaseratebtn: UIButton!
    
    @IBOutlet weak var datelabel: UILabel!
    
    @IBOutlet weak var paymentidview: UIView!
    @IBOutlet weak var MainPaymentidlabel: UILabel!
    @IBOutlet weak var paymentstatuslabel: UILabel!
    @IBOutlet weak var orderidlabel: UILabel!
    @IBOutlet weak var paymentamountlabel: UILabel!
    
    @IBOutlet weak var paymenttypelabel: UILabel!
    @IBOutlet weak var paymentidlabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.pleaseratebtn.layer.borderWidth = 1.0
        self.pleaseratebtn.layer.cornerRadius = 4

        
        if(invoicedata.details?.paymentId == "1"){
            
            paymentidlabel.hidden = true
            MainPaymentidlabel.hidden = true
            paymentidview.hidden = true
            paymenttypelabel.text = invoicedata.details?.paymentMethod
            datelabel.text = invoicedata.details?.paymentDateTime
            orderidlabel.text = invoicedata.details?.orderId
            paymentstatuslabel.text = invoicedata.details?.paymentStatus
            paymentamountlabel.text = "LKR " + (invoicedata.details?.paymentAmount)!
         
            
        }else{
            
            paymentidlabel.hidden = false
            MainPaymentidlabel.hidden = false
            paymentidview.hidden = false
            paymentidlabel.text = invoicedata.details?.paymentId
            paymenttypelabel.text = invoicedata.details?.paymentMethod
            datelabel.text = invoicedata.details?.paymentDateTime
            orderidlabel.text = invoicedata.details?.orderId
            paymentstatuslabel.text = invoicedata.details?.paymentStatus
            paymentamountlabel.text = "LKR " + (invoicedata.details?.paymentAmount)! 
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func Rateridebtn(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newratingViewController = storyBoard.instantiateViewControllerWithIdentifier("NewRatingViewController") as! NewRatingViewController
        newratingViewController.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(newratingViewController, animated:true, completion:nil)
    }

   

}
