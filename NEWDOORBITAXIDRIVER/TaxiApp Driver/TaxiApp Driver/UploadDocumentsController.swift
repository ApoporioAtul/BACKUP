//
//  UploadDocumentsController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

class UploadDocumentsController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,ParsingStates {
    
    var data: RegisterDriver!
    
    @IBOutlet weak var insurance_btn: CustomButton!
 //   @IBOutlet weak var other_btn: CustomButton!
    @IBOutlet weak var rc_btn: CustomButton!
    @IBOutlet weak var licence_btn: CustomButton!
    
    @IBOutlet weak var rcimage: UIImageView!
    
    @IBOutlet weak var insuranceimage: UIImageView!
    
    @IBOutlet weak var licenseimage: UIImageView!
    
    
    @IBOutlet weak var textview: UITextView!
    
    @IBOutlet weak var Insurancelabel: UILabel!
    
    @IBOutlet weak var Licencelabel: UILabel!
    
    @IBOutlet weak var RClabel: UILabel!
    
    
   var defaultdriverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textview.text = NSLocalizedString("For Registering with us you have to upload documents like:- Licence, Registeration of vehicle, Insurance", comment: "")
        Insurancelabel.text = NSLocalizedString("Insurance", comment: "")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // ********************* On back click dismiss vc ***************************

    
    @IBAction func back_btn_click(sender: AnyObject) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
        self.presentViewController(next, animated: true, completion: nil)
        

        
       // dismissViewcontroller()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // ********************* Upload insurance click ***************************

    
    @IBAction func insurance_pressed(sender: AnyObject) {
        GlobalVariables.i = 0
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
       /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: UploadDialogController = storyboard.instantiateViewControllerWithIdentifier("UploadDialogController") as! UploadDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve

        insurance_btn.backgroundColor = UIColor.darkGrayColor()
        self.presentViewController(next, animated: true, completion: nil)*/
    }
    
    // ********************* Upload license click ***************************

    
    @IBAction func licence_pressed(sender: AnyObject) {
        GlobalVariables.i = 1
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
       /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: UploadDialogController = storyboard.instantiateViewControllerWithIdentifier("UploadDialogController") as! UploadDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        licence_btn.backgroundColor = UIColor.darkGrayColor()
        self.presentViewController(next, animated: true, completion: nil)*/

    }
    
    
    // ********************* Upload rc click ***************************

    
    @IBAction func rc_pressed(sender: AnyObject) {
        GlobalVariables.i = 2
        
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
       /* let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: UploadDialogController = storyboard.instantiateViewControllerWithIdentifier("UploadDialogController") as! UploadDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        rc_btn.backgroundColor = UIColor.darkGrayColor()
        self.presentViewController(next, animated: true, completion: nil)*/

    }
    
    
    // ********************* Upload other documents click ***************************

    
  /*  @IBAction func others_pressed(sender: AnyObject) {
        GlobalVariables.i = 3
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: UploadDialogController = storyboard.instantiateViewControllerWithIdentifier("UploadDialogController") as! UploadDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        other_btn.backgroundColor = UIColor.darkGrayColor()
        self.presentViewController(next, animated: true, completion: nil)

    }*/
    
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if(GlobalVariables.i == 0){
            
          //  let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
       //    insuranceimage.contentMode = .ScaleAspectFit
            insuranceimage.image =  self.RBResizeImage(image, targetSize: CGSize(width: self.view.frame.size.width/3,height: 70))
            
            GlobalVariables.insurance = self.RBResizeImage(image, targetSize: CGSize(width: self.view.frame.size.width/3,height: 70))

           // dismissViewcontroller()
            
        }
        else if(GlobalVariables.i == 1){
            
          //   licenseimage.contentMode = .ScaleAspectFit
            licenseimage.image = self.RBResizeImage(image, targetSize: CGSize(width: self.view.frame.size.width/3,height:70))
            
            GlobalVariables.license = self.RBResizeImage(image, targetSize: CGSize(width: self.view.frame.size.width/3,height: 70))

            //dismissViewcontroller()
            
        }
        else if(GlobalVariables.i == 2){
            
          //  rcimage.contentMode = .ScaleAspectFit
            rcimage.image = self.RBResizeImage(image, targetSize: CGSize(width: self.view.frame.size.width/3,height: 70))

            
            GlobalVariables.registration = self.RBResizeImage(image, targetSize: CGSize(width: self.view.frame.size.width/3,height: 70))
           // dismissViewcontroller()
            
        }
        else{
            GlobalVariables.otherDocument = image
           // dismissViewcontroller()
            
        }
        
     /*   imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        imageName = imageURL.path!
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        localPath = documentDirectory.stringByAppendingString(imageName)
        
        data = UIImagePNGRepresentation(image)!
        data.writeToFile(localPath, atomically: true)
        
        
        photoURL = NSURL(fileURLWithPath: localPath)
        path = photoURL.relativeString!*/
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    
    
    
    // ********** Ok button click to give confirmation all documents are uploaded **************

    
    @IBAction func ok_pressed(sender: AnyObject) {
        
        if GlobalVariables.insurance == "" {
            let alert = UIAlertController(title: NSLocalizedString("Upload Documents", comment: ""), message: NSLocalizedString("Please upload insurance copy ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}

        }
        else if GlobalVariables.license == "" {
            let alert = UIAlertController(title:  NSLocalizedString("Upload Documents", comment: ""), message: NSLocalizedString("Please upload licence copy ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
        }

        else if GlobalVariables.registration == "" {
            let alert = UIAlertController(title:  NSLocalizedString("Upload Documents", comment: ""), message: NSLocalizedString("Please upload rc copy ", comment: ""), preferredStyle: .Alert)
            let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
        }
        
      /*  else if GlobalVariables.otherDocument == "" {
            let alert = UIAlertController(title: "Upload Documents", message:"Please upload other document copy ", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
        }*/
        else {
            
            
            
            APIManager.sharedInstance.delegate = self
            APIManager.sharedInstance.uploaddriverdocument(defaultdriverid, InsuranceImage: GlobalVariables.insurance, LicenseImage: GlobalVariables.license, RCImage: GlobalVariables.registration)
            
           // uploaddriverdocument

        //dismissViewcontroller()
        }
    }
    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
                    
            self.data = data as! RegisterDriver
        
        
        
        if(self.data.result == 419){
            
            NsUserDefaultManager.SingeltonInstance.logOut()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
            self.presentViewController(next, animated: true, completion: nil)
            
               
        }else if(self.data.result == 1){
                
                NsUserDefaultManager.SingeltonInstance.registerDriver((self.data.details?.insurance!)!, rc: (self.data.details?.rc!)!, licence: (self.data.details?.license!)!, did: (self.data.details?.deviceId!)!, carModelId: (self.data.details?.carModelId!)!, otherDoc: (self.data.details?.otherDocs!)!, driverId: (self.data.details?.driverId!)!, driverImg: (self.data.details?.driverImage!)!, driverEmail: (self.data.details?.driverEmail!)!, driverName: (self.data.details?.driverName!)!, flag: (self.data.details?.flag!)!, long: (self.data.details?.currentLong!)!, cityid: (self.data.details?.cityId!)!, carNo: (self.data.details?.carNumber!)!, password: (self.data.details?.driverPassword!)!, lat: (self.data.details?.currentLat!)!, phoneNo: (self.data.details?.driverPhone!)!, carType: (self.data.details?.carTypeId!)!, onOff: (self.data.details?.onlineOffline!)!, status: (self.data.details?.status!)!, loginLogout: (self.data.details?.loginLogout!)!,driverToken: (self.data.details?.driverToken!)!,detailStatus : (self.data.details?.detailStatus)!,carmodelname : (self.data.details?.carModelName!)! , cartypename : (self.data.details?.carTypeName!)!)
                
                
                let alert = UIAlertController(title:  NSLocalizedString("Registration Successful", comment: ""), message:"", preferredStyle: .Alert)
                let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                    
                    
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let revealViewController:OnLineController = storyBoard.instantiateViewControllerWithIdentifier("OnLineController") as! OnLineController
                    
                    self.presentViewController(revealViewController, animated:true, completion:nil)
            }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            }
            else{
                
                let alert = UIAlertController(title:  NSLocalizedString("Unable to register!", comment: ""), message: self.data.msg!, preferredStyle: .Alert)
                let action = UIAlertAction(title:  NSLocalizedString("OK", comment: ""), style: .Default) { _ in
                    
                }
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            }
            
        }
        

    
}


extension UploadDocumentsController
{
    
    
    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let heightInPoints = newImage.size.height
        let heightInPixels = heightInPoints * newImage.scale
        print(heightInPixels)
        
        let widthInPoints = newImage.size.width
        let widthInPixels = widthInPoints * newImage.scale
        print(widthInPixels)
        
        
        return newImage
    }
}