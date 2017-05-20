//
//  DialogViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 30/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

class DialogViewController: UIViewController {
    
    var first2title = ""
    var after2title  = ""
    var waittitle = ""

    
    @IBOutlet weak var first2kmlabel: UILabel!
    
    @IBOutlet weak var innerview: UIView!
    @IBOutlet weak var outerview: UIView!
    @IBOutlet weak var after2kmlabel: UILabel!
    
    @IBOutlet weak var waitchargelabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
        //self.outerview.addGestureRecognizer(tapGesture)
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleFrontTap:"))
        outerview.addGestureRecognizer(tap)

        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        if(first2title == ""){
        
        first2kmlabel.text = ""
        after2kmlabel.text = ""
        waitchargelabel.text = ""
        
        
        }
        else{
        first2kmlabel.text = first2title
        after2kmlabel.text = after2title
        waitchargelabel.text = waittitle
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleFrontTap(gestureRecognizer: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   

  
}
