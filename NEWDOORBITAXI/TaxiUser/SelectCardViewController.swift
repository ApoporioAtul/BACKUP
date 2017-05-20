//
//  SelectCardViewController.swift
//  TaxiUser
//
//  Created by AppOrio on 01/03/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit
import Stripe

class SelectCardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, CardIOPaymentViewControllerDelegate,MainCategoryProtocol {
    
    
    
    var savedata : SaveCardModel!
    var carddata : CardDetailsModel!
    var deletedata : DeleteCardModel!
    
    var senderTag = 0
    
    var newGeneratedCardName = ""
    var newGeneratedCardNumber = ""
    var newGeneratedCardExpiryMonth = ""
    var newGeneratedCardExpiryYear = ""
    var newGeneratedCardCv = ""
    
    
    var Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var SIZE = 0
    
  var toastLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.hidden = true
        
        
        toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-300, 300, 35))
        toastLabel.backgroundColor = UIColor.whiteColor()
        toastLabel.textColor = UIColor.blackColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(toastLabel)
        toastLabel.text =  NSLocalizedString("No Card Added!!", comment: "")
        
        toastLabel.hidden = true

        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.viewcarddetails(Userid!)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backbtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onAddCard(sender: AnyObject) {
        
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        cardIOVC.collectCardholderName = true
        
        presentViewController(cardIOVC, animated: true, completion: nil)
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  SIZE
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SelectCardCell") as! SelectCardCell
        
        cell.deleteButton.tag = indexPath.row
      //  cell.payButton.tag = indexPath.row
        
        cell.deleteButton.addTarget(self, action: #selector(onDeleteCard(_:)), forControlEvents: UIControlEvents.TouchUpInside)
       // cell.payButton.addTarget(self, action: #selector(onPay(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        cell.cardNumber.text = "XXXXXXXXXXXX" + carddata.details![indexPath.row].cardNumber!
        cell.expiryDate.text = carddata.details![indexPath.row].cardType
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print(indexPath.row)
        
        GlobalVarible.MatchCardSelect = 1
        
        GlobalVarible.CardId = carddata.details![indexPath.row].cardId!
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
        
        //        let card = paymentTextField.cardParams
        //        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        //        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
        //        //send card information to stripe to get back a token
        //        getStripeToken(card)
        //
        //
        
        
    }
    
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        
        print("caneceld")
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        
        //  KVNProgress.show()
        
        if let info = cardInfo {
            
            //create Stripe card
            let card: STPCardParams = STPCardParams()
            card.number = info.cardNumber
            card.expMonth = info.expiryMonth
            card.expYear = info.expiryYear
            card.name = info.cardholderName
            card.cvc = info.cvv
            
            
            newGeneratedCardName = info.cardholderName
            newGeneratedCardNumber = info.cardNumber
            newGeneratedCardExpiryMonth = String(info.expiryMonth)
            newGeneratedCardExpiryYear = String(info.expiryYear)
            newGeneratedCardCv = info.cvv
            
            
            //Send to Stripe
            getStripeToken(card , resultCode: 0)
            
            
        }
        
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func getStripeToken(card:STPCardParams ,  resultCode: Int ) {
        
        if resultCode == 1
        {
            
            
            // get stripe token for current card
            STPAPIClient.sharedClient().createTokenWithCard(card) { token, error in
                if let token = token {
                    print(token)
                    // SVProgressHUD.showSuccessWithStatus("Stripe token successfully received: \(token)")
                    //  self.placeOrder(token)
                } else {
                    print(error)
                    // SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
                }
            }
            
            
            
        }
            
        else
        {
            // get stripe token for current card
            STPAPIClient.sharedClient().createTokenWithCard(card) { token, error in
                if let token = token {
                    print(token)
                    // SVProgressHUD.showSuccessWithStatus("Stripe token successfully received: \(token)")
                    self.saveCard(token)
                } else {
                    print(error)
                    //  SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
                }
            }
        }
        
        // KVNProgress.dismiss()
        
    }
    
    
    
    // charge money from backend
    func saveCard(token: STPToken) {
        
        print(token)
        print(newGeneratedCardName)
        
        let fullExpiry =  self.newGeneratedCardExpiryMonth + "/"  +  self.newGeneratedCardExpiryYear
        print(fullExpiry)
        let email = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyemail)
        
        let Userid = NsUserDekfaultManager.SingeltionInstance.getuserdetaild(NsUserDekfaultManager.Keyuserid)
        
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.SaveCardDetails(Userid!, UserEmail: email!, StripeToken: String(token))
        
        
        /*  let userId =  parsedData.loginData!.userDetails!.userId!
         let userEmail =  parsedData.loginData!.userDetails!.email!
         
         
         
         
         let parameters = [saveCardsUrlUserId: userId , saveCardsUrlName: self.newGeneratedCardName , saveCardsUrlCardNo: self.newGeneratedCardNumber , saveCardsUrlExpiry: fullExpiry, saveCardsUrlEmail: userEmail ,  saveCardsUrlToken: String(token) ]
         
         ApiController.sharedInstance.parsDataMultipart(saveCardsUrl, parameters: parameters, reseltCode: 18)*/
        
        
        
    }
    
    
    
    
    
    
    func onDeleteCard(sender: UIButton ) {
        
        print("delete")
        
        self.senderTag = sender.tag
        
        
        
        let alert = UIAlertController(title: "Delete Card", message: "Are you sure want to delete this card ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.DeleteCard(self.carddata.details![sender.tag].cardId!)
            
            //  ApiController.sharedInstance.parsDataSimple(deleteCardUrl + parsedData.viewCards!.response!.message![sender.tag].cardId!, reseltCode: 19)
            
        }))
        
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        
        
        
        
    }
    
    func onPay(sender: UIButton ) {
        
        
        self.senderTag = sender.tag
        
        print("pay")
        
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! SelectCardCell
        
        /* if currentCell.cvv.text!.isEmpty
         {
         showAlert("First Enter CVV Number")
         return
         }
         
         
         let cardNumber =  parsedData.viewCards!.response!.message![sender.tag].cardNumber!
         let cardHolderName =  parsedData.viewCards!.response!.message![sender.tag].cardName!
         
         
         let fullExpiry = String(parsedData.viewCards!.response!.message![sender.tag].expiray!)
         
         var fullExpiryDate = fullExpiry.characters.split{$0 == "/"}.map(String.init)
         
         let expMonth =  String(UTF8String: fullExpiryDate[0])!
         
         let expYear = fullExpiryDate[1]
         
         
         
         
         
         //create Stripe card
         let card: STPCardParams = STPCardParams()
         card.number = cardNumber
         card.expMonth = UInt( expMonth)!
         card.expYear = UInt( expYear)!
         card.name = cardHolderName
         card.cvc = currentCell.cvv.text!*/
        
        //Send to Stripe
        // getStripeToken(card , resultCode: 1)
        
        
        
        
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
                
                
                ApiManager.sharedInstance.protocolmain_Catagory = self
                ApiManager.sharedInstance.viewcarddetails(self.Userid!)
                
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
            
            self.showalert(msg)
        }
        
    }
    
    func onSuccessParse(data: AnyObject) {
        
        if(GlobalVarible.Api == "viewcard"){
            
            
            carddata = data as! CardDetailsModel
            
            
            if(carddata.result == 0){
                
                toastLabel.hidden = false
                SIZE = 0
                self.tableView.hidden = true
                
                
            }else{
                
                toastLabel.hidden = true
              // self.tableView.hidden = true
                
              //  mydata = data as! AllRides
                
              //  if(mydata.result == 0){
               //     collectionsize = 0
                    
              //  }else{
                   SIZE = (carddata.details?.count)!
                    self.tableView.hidden = false
                    tableView.reloadData()
                }
                
               // newridetable.reloadData()
                
          //  }

            
            
        /*    print(carddata.details?.count)
            if( carddata.result == 0){
                SIZE = 0
                self.tableView.hidden = true
                
            }else{
                SIZE = (carddata.details?.count)!
                // MapCollectionview.reloadData()
                
                self.tableView.hidden = false
                tableView.reloadData()
            }*/
            
            
            
            
            
        }
        
        if(GlobalVarible.Api == "Savecard"){
            
            savedata = data as! SaveCardModel
            
            if(savedata.result == 0){
                
                self.showalert("Please try Again!!!")
            }else{
                
                self.showalert1("Card Details Saved Succesfully")
                
            }
            
            
            
            
        }
        
        
        if(GlobalVarible.Api == "deletecard")
        {
            
            deletedata = data as! DeleteCardModel
            
            if(deletedata.result == 0){
                
                self.showalert("Please try Again!!!")
            }else{
                
                self.showalert1("Deleted Successfully")
                
            }
            
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    

    

  
}
