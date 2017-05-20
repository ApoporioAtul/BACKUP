//
//  EditAccountController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

class EditAccountController: UIViewController , ParsingStates , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var mobileNo: String = ""
    var password: String = ""
    var name: String = ""
    let imageUrl = API_URLs.imagedomain
    var data: ViewProfile!
    var defaultdriverid = ""
    var defaultdrivername = ""
    var defaultdriverphone = ""
    var defaultdriveremail = ""
    var defaultdriverPassword = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var driverProfileImage: UIImageView!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var mobileTf: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    
    
      var defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        defaultdriverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
        defaultdrivername = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDrivername)!
        defaultdriverphone = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyPhoneno)!
        defaultdriveremail = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverEmail)!
        defaultdriverPassword =  NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyPassword)!
        
        emailTf.text = defaultdriveremail
        mobileTf.text = defaultdriverphone
        nameTf.text = defaultdrivername
        passwordTf.text = defaultdriverPassword
        
        emailTf.enabled = false
        
        
        let image = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverImage)!
        let newUrl = imageUrl + image
        let url = NSURL(string: newUrl)
        driverProfileImage.af_setImageWithURL(url!, placeholderImage: UIImage(named: image),
                                              filter: nil, imageTransition: .CrossDissolve(1.0))
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(EditAccountController.imageTapped(_:)))
        driverProfileImage.userInteractionEnabled = true
        driverProfileImage.addGestureRecognizer(tapGestureRecognizer)

        driverProfileImage.layer.cornerRadius =  driverProfileImage.frame.width/2
        driverProfileImage.clipsToBounds = true
        driverProfileImage.layer.borderWidth = 1
        driverProfileImage.layer.borderColor = UIColor.blackColor().CGColor
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ********************* scrollView constraints ***************************
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.scrollView.bounds
        self.scrollView.contentSize.height = 450
        self.scrollView.contentSize.width = 0
    }
    
    
    // ********************* On back click dismiss vc ***************************

    
    @IBAction func back_click(sender: AnyObject) {
          dismissViewcontroller()
        
       // self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // ********************* Image pick from gallery ***************************

    func imageTapped(img: AnyObject)
    {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            driverProfileImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    
     // ********************* Go to change password screen ***************************
    
    
    @IBAction func next_btn(sender: AnyObject) {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: ChangePasswordController = storyboard.instantiateViewControllerWithIdentifier("ChangePasswordController") as! ChangePasswordController
            self.presentViewController(next, animated: true, completion: nil)
    }
    
    @IBAction func edit_password(sender: UITextField) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ChangePasswordController = storyboard.instantiateViewControllerWithIdentifier("ChangePasswordController") as! ChangePasswordController
        self.presentViewController(next, animated: true, completion: nil)
    }
    
    
 
    // ********************* Edit profile by pressing done ***************************
    
    
    @IBAction func done_pressed(sender: AnyObject) {
       
        name = nameTf.text!
        mobileNo = mobileTf.text!
        password = passwordTf.text!
        
        if ((mobileNo.characters.count < 10) || (mobileNo.characters.count > 10 )) {
            
            let alert = UIAlertController(title: NSLocalizedString("Edit Failed!", comment: ""), message:NSLocalizedString("Mobile No. must be of 10 characters ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
            
            
        else
        {
            let parameters = [
                "driver_id": defaultdriverid,
                "driver_name": name,
                "driver_phone": mobileNo,
                 "driver_token=": defaultdrivertoken
                
                ]
            
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.uploadRequest(parameters, driverImage: self.driverProfileImage.image!)
        }

        
    }
    
    
    // ********************* Logout Click ***************************

    
    @IBAction func logOut_pressed(sender: AnyObject) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: SignOutDialogController = storyboard.instantiateViewControllerWithIdentifier("SignOutDialogController") as! SignOutDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve

        self.presentViewController(next, animated: true, completion: nil)

    }
    
    
    // ********************* Success state ***************************

    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        
        
    self.data = data as! ViewProfile
   
       print(" Result is: \(self.data.result!)")
       if ( self.data.result == 1){
        
            
           NsUserDefaultManager.SingeltonInstance.registerDriver((self.data.details?.insurance!)!, rc: (self.data.details?.rc!)!, licence: (self.data.details?.license!)!, did: (self.data.details?.deviceId!)!, carModelId: (self.data.details?.carModelId!)!, otherDoc: (self.data.details?.otherDocs!)!, driverId: (self.data.details?.driverId!)!, driverImg: (self.data.details?.driverImage!)!, driverEmail: (self.data.details?.driverEmail!)!, driverName: (self.data.details?.driverName!)!, flag: (self.data.details?.flag!)!, long: (self.data.details?.currentLong!)!, cityid: (self.data.details?.cityId!)!, carNo: (self.data.details?.carNumber!)!, password: (self.data.details?.driverPassword!)!, lat: (self.data.details?.currentLat!)!, phoneNo: (self.data.details?.driverPhone!)!, carType: (self.data.details?.carTypeId!)!, onOff: (self.data.details?.onlineOffline!)!, status: (self.data.details?.status!)!, loginLogout: (self.data.details?.loginLogout!)!,driverToken: (self.data.details?.driverToken!)!,detailStatus : (self.data.details?.detailStatus)!,carmodelname : (self.data.details?.carModelName!)! , cartypename : (self.data.details?.carTypeName!)!)
        
            let alert = UIAlertController(title: NSLocalizedString("Profile Updated", comment: ""), message:"", preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let next: OnLineController = storyboard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
                self.presentViewController(next, animated: true, completion: nil)
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
        
        else{
        
            let alert = UIAlertController(title: NSLocalizedString("Unable to edit!", comment: ""), message:NSLocalizedString(" Email Already Exsist or Field is Incorrect", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }
        
    
    
    }
    
}