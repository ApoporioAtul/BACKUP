//
//  DocumentTypeController.swift
//  TaxiApp Driver
//
//  Created by Rakesh kumar on 31/01/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

class DocumentTypeController: UIViewController, UITableViewDataSource, UITableViewDelegate, ParsingStates {
    
    
    var driverid = ""
    var data: DocumentType!
    var SIZE = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       APIManager.sharedInstance.delegate = self
       APIManager.sharedInstance.docType()
        
        driverid = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
        
           }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    
    // ********************* TableView datasource methods ***************************
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SIZE
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("docCell", forIndexPath: indexPath) as! DocumentCellController
        
        cell.selectionStyle = .None
        
       
        
        
        return cell
    }
    

    
    
    func onSuccessState(data: AnyObject , resultCode: Int) {
        
        self.data = data as! DocumentType
        
        if(self.data.result == 419){
            
            NsUserDefaultManager.SingeltonInstance.logOut()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let next: MainScreenController = storyboard.instantiateViewControllerWithIdentifier("MainScreenController") as! MainScreenController
            self.presentViewController(next, animated: true, completion: nil)
            
            
            
        }else if (self.data.result == 1){
            if let size = (self.data.msg?.count){
                SIZE = size
            }
        }
        
        
    }
    
}