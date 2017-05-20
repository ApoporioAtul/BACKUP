//
//  RatingViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 31/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

import SwiftyJSON

class RatingViewController: UIViewController,MainCategoryProtocol,PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate {
    
    var mydatapage :DoneRideModel!
    var mydata : CompletePayment!
    var paydata : PayCardModel!
    
    var userselectpaymentoption = ""
    
    var currentrideid = ""
    
    let imageUrl = API_URL.imagedomain
    
    
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
    
    

    var creditcardrideid = ""
    
    @IBOutlet weak var Viewinvoice: UIButton!
    @IBOutlet weak var makepayment: UIButton!
    @IBOutlet weak var TotalPayableview: UIView!
    
    @IBOutlet weak var Totalpayableamount: UILabel!
    
    @IBOutlet weak var Totaldistanceview: UIView!

    @IBOutlet weak var Totaldistancelabel: UILabel!
    
    @IBOutlet weak var Totaltimeview: UIView!
    
    
    @IBOutlet weak var Totaltimelabel: UILabel!
    
    @IBOutlet weak var Driverview: UIView!
    
   
    @IBOutlet weak var DriverImageView: UIImageView!
    
    @IBOutlet weak var Drivernamelabel: UILabel!
    
     let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
    
    
    var DRIVERID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         Viewinvoice.userInteractionEnabled = false
        Viewinvoice.hidden = true
        
        self.makepayment.layer.borderWidth = 1.0
        self.makepayment.layer.cornerRadius = 4
       
       GlobalVarible.rideendstopupdatelocation = 1
        
        payPalConfig.acceptCreditCards = acceptCreditCards
        payPalConfig.merchantName = ""
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0]
        
        payPalConfig.payPalShippingAddressOption = .PayPal

        
        
        makepayment.setTitle(NSLocalizedString("Make Payment", comment: ""), forState: UIControlState.Normal)
        TotalPayableview.layer.borderWidth = 1.0
        TotalPayableview.layer.cornerRadius = 4
        Totaldistanceview.layer.borderWidth = 1.0
        Totaldistanceview.layer.cornerRadius = 4
        Totaltimeview.layer.borderWidth = 1.0
        Totaltimeview.layer.cornerRadius = 4
        Driverview.layer.borderWidth = 1.0
        Driverview.layer.cornerRadius = 4
        
        GlobalVarible.RideId = currentrideid
       
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.ViewDoneRide(currentrideid)
        
        
        
            
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    

   
  /*  @IBAction func ViewInvoicebtn(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let invoiceViewController = storyBoard.instantiateViewControllerWithIdentifier("InvoiceViewController") as! InvoiceViewController
        invoiceViewController.invoicedata = self.mydata
        
        self.presentViewController(invoiceViewController, animated:true, completion:nil)
        
    }*/
   
    
    @IBAction func Paymentbutton(sender: AnyObject) {
        
        if(userselectpaymentoption == "1"){
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.ConfirmPayment(GlobalVarible.RideId, UserId: Userid!, PaymentId: "1", PaymentMethod: "Cash", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
        
        
        }else if(userselectpaymentoption == "2"){
            
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
            

        
        
        }else if(userselectpaymentoption == "3"){
        
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.PayPaymentCard(creditcardrideid, Amount: GlobalVarible.TotalPayableamount)
        
        
        }
        
        
        
      /*  GlobalVarible.MatchStringforCancel = "NotHideCancelButton"
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let paymentdialogViewController = storyBoard.instantiateViewControllerWithIdentifier("SelectDialogpaymentController") as! SelectDialogpaymentController
        // paymentdialogViewController.modalPresentationStyle = .OverCurrentContext
        paymentdialogViewController.modalPresentationStyle = .Popover
        self.presentViewController(paymentdialogViewController, animated:true, completion:nil)*/
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
        
        if(GlobalVarible.Api == "DoneRideInformation"){
            
            mydatapage = data as! DoneRideModel
            
            if(mydatapage.result == 1){
                
                GlobalVarible.TotalPayableamount = (mydatapage.msg!.amount)!
                
                GlobalVarible.DRIVERID = (mydatapage.msg!.driverId)!
                
                Drivernamelabel.text = mydatapage.msg!.driverName
                
                userselectpaymentoption = mydatapage.msg!.paymentOptionId!
                
                Totalpayableamount.text = "LKR " + (mydatapage.msg!.amount)!
                
                 creditcardrideid = (mydatapage.msg?.rideId)!
                
               
                Totaldistancelabel.text =  NSLocalizedString("        Total Distance -  " , comment: "") + (mydatapage.msg!.distance)! + " Kms"
                Totaltimelabel.text =     NSLocalizedString("        Total Time -  " , comment: "") + (mydatapage.msg!.totTime)! +  " min"
                
                
                let drivertypeimage = mydatapage.msg!.driverImage
                
                print(drivertypeimage!)
                
                if(drivertypeimage == ""){
                    DriverImageView.image = UIImage(named: "profileeee") as UIImage?
                    print("No Image")
                }else{
                    
                     let newUrl = imageUrl + drivertypeimage!
                    
                 //   let url = "http://apporio.co.uk/apporiotaxi/\(drivertypeimage!)"
                    print(newUrl)
                    
                    let url1 = NSURL(string: newUrl)
                    DriverImageView!.af_setImageWithURL(url1!,
                                                        placeholderImage: UIImage(named: "dress"),
                                                        filter: nil,
                                                        imageTransition: .CrossDissolve(1.0))
                }
                
            }else{
                
                print("HelloRating")
                
            }
            
            
            
            
        }
        
        
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
        
        if(GlobalVarible.Api == "paycard"){
            paydata = data as! PayCardModel
            
            let completepaymentid = paydata.paymentId
            
            if(paydata.result == 1){
            
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.ConfirmPayment(GlobalVarible.RideId, UserId: Userid!, PaymentId: completepaymentid!, PaymentMethod: "Credit Card", PaymentPlatform: "Ios", PaymentAmount: GlobalVarible.TotalPayableamount, PaymentDate: GlobalVarible.CurrentDate, PaymentStatus: "Done")
                

            
            }else{
            
            self.showalert("Card details Not Exits")
            }
        
        
        
        }

        
             
    }
    
    
    
    
}
