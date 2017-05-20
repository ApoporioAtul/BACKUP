//
//  RateCardViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 19/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit
import SwiftyJSON

class RateCardViewController: UIViewController, UIPickerViewDelegate,UITextFieldDelegate,MainCategoryProtocol {
    
    
    var mydata: CityName!
    var Cardata: CarType!
    var ratecarddata: RateCardModel!
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var ridedistancefirst2: UILabel!
    
    @IBOutlet weak var ridedistanceafter2: UILabel!
    
    @IBOutlet weak var ridedistancefirst2charges: UILabel!
    
    @IBOutlet weak var ridedistanceafter2charges: UILabel!
    
    
    @IBOutlet weak var ridetimefirst2: UILabel!
    
    @IBOutlet weak var ridetimeafter2: UILabel!
    
    @IBOutlet weak var ridetimefirst2charges: UILabel!
    
    @IBOutlet weak var ridetimeafter2charges: UILabel!
    
    @IBOutlet weak var citynamelabel: UILabel!
    
    @IBOutlet weak var carnamelabel: UILabel!
    
    @IBOutlet weak var waitingtimefirst2: UILabel!
    
    @IBOutlet weak var waitingtimeafter2: UILabel!
    
    @IBOutlet weak var waitingtimefirst2charges: UILabel!
    
    @IBOutlet weak var waitingtimeafter2charges: UILabel!
    
  //  @IBOutlet weak var city: UITextField!
    
  //  @IBOutlet weak var car: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var newcity: UITextField!
    
    @IBOutlet weak var newcar: UITextField!
    
    
    // var city_name : NSMutableArray = []
    
    var movedfrom = " "
    var cityid = " "
    var carid = " "
    var cityname = ""
    var citysize = 0
    var carsize = 0
    @IBOutlet weak var firstkmlabel: UILabel!

    @IBOutlet weak var afterkmlabel: UILabel!
    @IBOutlet weak var first2kmrate: UILabel!
    @IBOutlet weak var after2kmrate: UILabel!
    
    
    @IBAction func backbtn(sender: AnyObject) {
        
       // self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    let pickerView = UIPickerView()
    
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 1000)
       // scrollview.scrollEnabled = true
       //  self .setNeedsStatusBarAppearanceUpdate()
        
        mainview.layer.borderWidth = 1.0
        mainview.layer.borderColor = UIColor.lightGrayColor().CGColor
        mainview.layer.cornerRadius = 4
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.RateCard(GlobalVarible.usercityname, CarTypeId: GlobalVarible.car_type_id)
        movedfrom = "RateCard"
        
        citynamelabel.text = GlobalVarible.usercityname
        carnamelabel.text = GlobalVarible.firstcarname

      // city.text = GlobalVarible.usercityname
      //  car.text = GlobalVarible.firstcarname
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.blackColor()
        
        let defaultButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action:#selector(RateCardViewController.tappedToolBarBtn(_:)))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action:#selector(RateCardViewController.donePressed(_:)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 2, height: (self.view.frame.size.height + 5)))
        
        label.font = UIFont(name: "AvenirNextCondensed-Medium", size: 18)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = NSLocalizedString("Select City ", comment: "")
        
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        newcity.inputAccessoryView = toolBar
      
        
        pickerView.delegate = self
        textField.delegate = self
        
      
        newcity.inputView = pickerView
      //  citynamelabel.inputView = pickerView
        
        
        let toolBar1 = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar1.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar1.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar1.tintColor = UIColor.whiteColor()
        
        toolBar1.backgroundColor = UIColor.blackColor()
        
        let defaultButton1 = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action:#selector(RateCardViewController.tappedToolBarBtn1(_:)))
        
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action:#selector(RateCardViewController.donePressed1(_:)))
        
        let flexSpace1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 2, height: (self.view.frame.size.height + 5)))
        
        label1.font = UIFont(name: "AvenirNextCondensed-Medium", size: 18)
        
        label1.backgroundColor = UIColor.clearColor()
        
        label1.textColor = UIColor.whiteColor()
        
        label1.text = NSLocalizedString("Select Car ", comment: "")
        
        
        label1.textAlignment = NSTextAlignment.Center
        
        let textBtn1 = UIBarButtonItem(customView: label1)
        
        toolBar1.setItems([defaultButton1,flexSpace1,textBtn1,flexSpace1,doneButton1], animated: true)
        
        newcar.inputAccessoryView = toolBar1
        newcar.inputView = pickerView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // self.mainview.frame.size.height = 700
        self.scrollview.frame = self.scrollview.bounds
        self.scrollview.contentSize.height =  650
        self.scrollview.contentSize.width = 0
        
    }
    
    
    
  /*  @IBAction func selectcitybtn(sender: AnyObject) {
        
        ApiManager.sharedInstance.protocolmain_Catagory = self
        ApiManager.sharedInstance.CityList()
        movedfrom = "City"
    }

    @IBAction func selectcarbtn(sender: AnyObject) {
        
        if(citynamelabel == ""){
            
            car.resignFirstResponder()
            
            self.showalert(NSLocalizedString("Please select City first!!", comment: ""))
            
            // return false
            
        }else{
            
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.viewcars(cityname)
            movedfrom = "Car"
            
        }

    }*/
    
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
       // city.text = ""
        
       // car.text = ""
        
        citynamelabel.text = ""
        
        carnamelabel.text = ""
        
        newcity.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn1(sender: UIBarButtonItem) {
        
         carnamelabel.text = ""
       // car.text = ""
        
        newcar.resignFirstResponder()
        
    }


    
   // func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == newcity
        {
            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.CityList()
            movedfrom = "City"
        
        }
        
        
        if textField == newcar
        {
            
            if(citynamelabel.text!.characters.count == 0){
                
                  newcar.resignFirstResponder()
                
                self.showalert(NSLocalizedString("Please select City first!!", comment: ""))
                
               // return false
                
            }else{

            ApiManager.sharedInstance.protocolmain_Catagory = self
            ApiManager.sharedInstance.viewcars(cityname)
            movedfrom = "Car"
        
            }
        }
        
        
       // return true
    }

    
    func donePressed(sender: UIBarButtonItem) {
        
        newcity.resignFirstResponder()
       // car.resignFirstResponder()
        
        
    }
    
    func donePressed1(sender: UIBarButtonItem) {
    
    
        newcar.resignFirstResponder()
        
        
        if(citynamelabel.text!.characters.count == 0  && carnamelabel.text!.characters.count == 0){
            self.showalert( NSLocalizedString("Please select both filled Car & City!!", comment: ""))
           
        }
        else{
            ApiManager.sharedInstance.protocolmain_Catagory = self
          // ApiManager.sharedInstance.RateCard(self.carid, CityId: self.cityid)
            ApiManager.sharedInstance.RateCard(self.cityname, CarTypeId: self.carid)
            movedfrom = "RateCard"
            
        }
        

    
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

    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 2
////    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if movedfrom == "City" {

       /* if(mydata == nil ){
            return 0
        }else {
            return (mydata.msg?.count)!
        }*/
            return citysize

        }
        else{
           /* if(Cardata == nil ){
                return 0
            }else {
                return (Cardata.msg?.count)!
            }*/
            return carsize
            

        
        
        }
       
        
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if movedfrom == "City" {
            
            if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
                return mydata.msg![row].cityName
              
            }else{
                return mydata.msg![row].cityNameOther
               
            }

        
           // return mydata.msg![row].cityName
        }
    
        else{
            if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
                return Cardata.msg![row].carTypeName

                
            }else{
                return Cardata.msg![row].carNameOther

                
            }
            

            
       // return Cardata.msg![row].carTypeName
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if movedfrom == "City" {
            
            
            if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
                citynamelabel.text = mydata.msg![row].cityName
                cityname = mydata.msg![row].cityName!
                cityid = mydata.msg![row].cityId!
                
            }else{
                citynamelabel.text = mydata.msg![row].cityNameOther
                cityname = mydata.msg![row].cityNameOther!
                cityid = mydata.msg![row].cityId!
                
            }

       
           // city.text = mydata.msg![row].cityName
           // cityname = mydata.msg![row].cityName!
           // cityid = mydata.msg![row].cityId!
            
        }
        else{
            
            
            if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
                //return Cardata.msg![row].carTypeName
                carnamelabel.text = Cardata.msg![row].carTypeName
                carid = Cardata.msg![row].carTypeId!
                
                
            }else{
               // return Cardata.msg![row].carNameOther
                carnamelabel.text = Cardata.msg![row].carNameOther
                carid = Cardata.msg![row].carTypeId!
                
                
            }
        
           // car.text = Cardata.msg![row].carTypeName
          //  carid = Cardata.msg![row].carTypeId!
        }
     
        
     //   pickerView.reloadAllComponents()
        
        
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
        
        if movedfrom == "City"
        {
        mydata = data as! CityName
            
            
            if(mydata.result == 0){
                citysize = 0
                
            }else{
                citysize = (mydata.msg?.count)!
                
            }

        }
        
        if(GlobalVarible.Api == "getcartype"){
          //  mydata = data as! CarType

        if movedfrom == "Car"
        {
        Cardata = data as! CarType
            
            if(Cardata.result == 0){
                carsize = 0
                
            }else{
                carsize = (Cardata.msg?.count)!
                
            }

        
        }
            
        }
        if movedfrom == "RateCard"
        {
            ratecarddata = data as! RateCardModel
            
            if(ratecarddata.result == 0){
              self.showalert(NSLocalizedString("No Record Found", comment: ""))
            
            }else{
                
                
                
                ridedistancefirst2.text =  NSLocalizedString(" First ", comment: "") + (ratecarddata.details?.baseMiles)! + NSLocalizedString(" Kms (Base fare)", comment: "")
                ridedistanceafter2.text = NSLocalizedString(" After ", comment: "") + (ratecarddata.details?.baseMiles)! + " Kms "

                ridedistancefirst2charges.text =  "LKR " + (ratecarddata.details!.basePriceMiles)!
            ridedistanceafter2charges.text =  "LKR " + (ratecarddata.details!.basePricePerUnit)!  +  NSLocalizedString(" per km ", comment: "")
                
                ridetimefirst2.text =  NSLocalizedString(" First ", comment: "") + (ratecarddata.details!.baseRideMinutes)! + " min"
                ridetimeafter2.text = NSLocalizedString(" After ", comment: "") + (ratecarddata.details!.baseRideMinutes)! + " min"
                ridetimefirst2charges.text =  "LKR " + (ratecarddata.details!.baseRideMinutePrice)!
                ridetimeafter2charges.text =  "LKR " + (ratecarddata.details!.pricePerRideMinute)! + NSLocalizedString(" per min", comment: "")
                
                
                waitingtimefirst2.text =  NSLocalizedString(" First ", comment: "") + (ratecarddata.details!.baseWatingTime)! + " min"
                waitingtimeafter2.text = NSLocalizedString(" After ", comment: "") + (ratecarddata.details!.baseWatingTime)! + " min"
                waitingtimefirst2charges.text = "LKR " + (ratecarddata.details!.baseWatingPrice)!
                waitingtimeafter2charges.text = "LKR " + (ratecarddata.details!.watingPriceMinute)!   + NSLocalizedString(" per min", comment: "")
                
                
              /*  firstkmlabel.text = "  First " + (ratecarddata.details?.baseMiles)! + " Miles"
                afterkmlabel.text = "  After " + (ratecarddata.details?.baseMiles)! + " Miles"
            
            first2kmrate.text = "Rs. " + (ratecarddata.details!.basePriceMiles)!
            after2kmrate.text = "Rs. " + (ratecarddata.details!.pricePerMile)!*/
            }
         
        }
        
        pickerView.reloadAllComponents()
        
    }


    

}
