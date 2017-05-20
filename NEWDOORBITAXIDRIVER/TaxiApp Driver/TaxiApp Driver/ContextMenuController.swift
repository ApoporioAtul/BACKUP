//
//  ContextMenuController.swift
//  TaxiApp Driver
//
//  Created by Rakesh kumar on 19/12/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

class ContextMenuController: UIViewController , ParsingStates {
    
    
    var driverid = ""
    var data: OnLineOffline!
    
    var defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
    

    
    @IBOutlet weak var on_off_text: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ContextMenuController.viewTapped(_:)))
        mainView.addGestureRecognizer(tapGestureRecognizer)
     
    
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
       
    }

    @IBAction func on_off_click(sender: AnyObject) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: CustomerInfoController = storyboard.instantiateViewControllerWithIdentifier("CustomerInfoController") as! CustomerInfoController
        
        self.presentViewController(next, animated: true, completion: nil)

    }
    
    
    
    @IBAction func cancelridebtn(sender: AnyObject) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next: ReasonDialogController = storyboard.instantiateViewControllerWithIdentifier("ReasonDialogController") as! ReasonDialogController
        next.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(next, animated: true, completion: nil)

        
        
        
    }
    
    func viewTapped(view: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! OnLineOffline
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}