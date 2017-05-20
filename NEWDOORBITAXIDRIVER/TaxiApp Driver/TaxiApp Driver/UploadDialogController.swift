//
//  UploadDialogController.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import UIKit

class UploadDialogController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    var imageName: String = ""
    var imageURL: NSURL = NSURL()
    var photoURL : NSURL = NSURL()
    var localPath: String = ""
    var check: Int = 0
    var path: String = ""
    var data: NSData = NSData()
    
    @IBOutlet weak var pdf: UIButton!
    @IBOutlet weak var image: UIButton!
    @IBOutlet weak var cancel_btn: UIButton!
    @IBOutlet weak var yes_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ********************* Upload image click ***************************

    
    @IBAction func upload_image(sender: AnyObject) {
        
        check = 1
        image.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
        image.layer.cornerRadius = 8
        pdf.layer.backgroundColor = UIColor.whiteColor().CGColor
    }
    
    // ********************* Upload pdf click ***************************

    
    @IBAction func upload_pdf(sender: AnyObject) {
        check = 0
        pdf.layer.cornerRadius = 8
        pdf.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
        image.layer.backgroundColor = UIColor.whiteColor().CGColor
    }
    
    
    
    // ********************* yes click to pick image ***************************

    @IBAction func yes_pressed(sender: AnyObject) {
        
        if(check == 1){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)

        }
        
    }
    
    
     // ********************* Image pick from gallery ***************************
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if(GlobalVariables.i == 0){
            
            GlobalVariables.insurance = image
            dismissViewcontroller()
            
        }
        else if(GlobalVariables.i == 1){
            
            GlobalVariables.license = image
            dismissViewcontroller()
            
        }
        else if(GlobalVariables.i == 2){
            
            GlobalVariables.registration = image
            dismissViewcontroller()
            
        }
        else{
            GlobalVariables.otherDocument = image
            dismissViewcontroller()
            
        }

            imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            imageName = imageURL.path!

            let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            localPath = documentDirectory.stringByAppendingString(imageName)

            data = UIImagePNGRepresentation(image)!
            data.writeToFile(localPath, atomically: true)
            
        
            photoURL = NSURL(fileURLWithPath: localPath)
            path = photoURL.relativeString!

        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    // ********************* yes click to pick image ***************************

    
    @IBAction func cancel_pressed(sender: AnyObject) {
        
        dismissViewcontroller()
    }
    
}