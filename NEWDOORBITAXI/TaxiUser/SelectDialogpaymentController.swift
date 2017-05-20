//
//  SelectDialogpaymentController.swift
//  TaxiUser
//
//  Created by AppOrio on 05/11/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON

class SelectDialogpaymentController: UIViewController,PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate,MainCategoryProtocol {
    
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var cashimage: UIImageView!

    @IBOutlet weak var paymentimage: UIImageView!
    
    var mydata : CompletePayment!
    
    let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)

    
    var i = 0
    var resultText = ""
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentProduction {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    static let sharedInstance = SelectDialogpaymentController()
    
    
    #if HAS_CARDIO
    // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
    // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
    // for more details.
    var acceptCreditCards: Bool = true {
    didSet {
    payPalConfig.acceptCreditCards = acceptCreditCards
    }
    }
    #else
    var acceptCreditCards: Bool = false {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    #endif
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerview.layer.cornerRadius = 5
        payPalConfig.acceptCreditCards = acceptCreditCards
        payPalConfig.merchantName = ""
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0]
        
        payPalConfig.payPalShippingAddressOption = .PayPal

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cashbutton(sender: AnyObject) {
        i = 1
      //  GlobalVarible.StringMatchPayment = "CashButton"
        cashimage.image = UIImage(named: "Circled Dot-35 (1)") as UIImage?
        paymentimage.image = UIImage(named: "Circle Thin-35 (1)") as UIImage?

    }
    
    @IBAction func paypalbutton(sender: AnyObject) {
        i = 2
        //GlobalVarible.StringMatchPayment = "PaypalButton"
        cashimage.image = UIImage(named: "Circle Thin-35 (1)") as UIImage?
        paymentimage.image = UIImage(named: "Circled Dot-35 (1)") as UIImage?
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController, didCompletePayment completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            let data = JSON(completedPayment.confirmation)
            print(data)
            let datatoParse = PayPalModel(json: data)
            GlobalVarible.CreateTime =  (datatoParse.response?.createTime!)!
            GlobalVarible.State = (datatoParse.response?.state!)!
            GlobalVarible.PaypalId = (datatoParse.response?.internalIdentifier!)!
            GlobalVarible.Intent = (datatoParse.response?.intent!)!
            self.resultText = completedPayment.description
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(GlobalVarible.RideId, UserId: self.Userid!, PaymentId: GlobalVarible.PaypalId, PaymentMethod: "Paypal", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CreateTime, PaymentStatus: GlobalVarible.State)
           // self.showSuccess()
        })
    }
    
    
    
    // MARK: Future Payments
    
    @IBAction func authorizeFuturePaymentsAction(sender: AnyObject) {
        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: payPalConfig, delegate: self)
        presentViewController(futurePaymentViewController!, animated: true, completion: nil)
    }
    
    
    func payPalFuturePaymentDidCancel(futurePaymentViewController: PayPalFuturePaymentViewController) {
        print("PayPal Future Payment Authorization Canceled")
        futurePaymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalFuturePaymentViewController(futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [NSObject : AnyObject]) {
        print("PayPal Future Payment Authorization Success!")
        // send authorization to your server to get refresh token.
        futurePaymentViewController.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.resultText = futurePaymentAuthorization.description
            self.showSuccess()
        })
    }
    
    // MARK: Profile Sharing
    
    @IBAction func authorizeProfileSharingAction(sender: AnyObject) {
        let scopes = [kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]
        let profileSharingViewController = PayPalProfileSharingViewController(scopeValues: NSSet(array: scopes) as Set<NSObject>, configuration: payPalConfig, delegate: self)
        presentViewController(profileSharingViewController!, animated: true, completion: nil)
    }
    // PayPalProfileSharingDelegate
    
    func userDidCancelPayPalProfileSharingViewController(profileSharingViewController: PayPalProfileSharingViewController) {
        print("PayPal Profile Sharing Authorization Canceled")
        
        profileSharingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalProfileSharingViewController(profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [NSObject : AnyObject]) {
        print("PayPal Profile Sharing Authorization Success!")
        
        // send authorization to your server
        
        profileSharingViewController.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.resultText = profileSharingAuthorization.description
            
            
            self.showSuccess()
        })
        
    }
    
    
    func showSuccess() {
        self.dismissViewControllerAnimated(true, completion: nil)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelay(2.0)
        
        UIView.commitAnimations()
        self.dismissViewControllerAnimated(true, completion: nil)
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


    @IBAction func donebutton(sender: AnyObject) {
        if(i == 0){
            
            self.showalert(NSLocalizedString("Select options first for payment", comment: ""))
            
        }
        if(i == 1){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(GlobalVarible.RideId, UserId: Userid!, PaymentId: "1", PaymentMethod: "Cash", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
            
          //  self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        if(i == 2){
            
            let decimalTotalamount = NSDecimalNumber(string: GlobalVarible.TotalPayableamount)
            
            print(decimalTotalamount)
            
            let payment = PayPalPayment(amount: decimalTotalamount, currencyCode: "GBP", shortDescription: "Pay", intent: .Sale)
            
            
            if (payment.processable) {
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                presentViewController(paymentViewController!, animated: true, completion: nil)
            }
            else {
                
                print("Payment not processable: \(payment)")
            }
            
            
        }
        
        
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
        
               
        if(GlobalVarible.Api == "CONFIRMPAYMENT"){
            mydata = data as! CompletePayment
            
            if(mydata.result == 1){
               // makepayment.userInteractionEnabled = false
               // Viewinvoice.userInteractionEnabled = true
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let invoiceViewController = storyBoard.instantiateViewControllerWithIdentifier("InvoiceViewController") as! InvoiceViewController
                invoiceViewController.invoicedata = self.mydata
                
                self.presentViewController(invoiceViewController, animated:true, completion:nil)

                
            }else{
               // makepayment.userInteractionEnabled = true
               // Viewinvoice.userInteractionEnabled = false
                
                
                
            }
            
            
        }
        
    }

  
 
}
