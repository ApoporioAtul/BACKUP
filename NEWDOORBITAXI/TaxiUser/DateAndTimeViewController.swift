//
//  DateAndTimeViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 30/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

class DateAndTimeViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var dateTimeDisplay: UILabel!
   
    let dateFormatter = NSDateFormatter()
    
    
    var year = 0
    var month = 0
    var day = 0
    

    let timeFormatter = NSDateFormatter()
    
    @IBAction func cancelbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func Okbtn(sender: AnyObject) {
        GlobalVarible.OKBtnString = "OkClick"
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        year =  components.year
        month = components.month
        day = components.day
        
        
        
        let minDate =  calendar.dateFromComponents(components)
        
        self.datePicker.minimumDate = minDate
        

        timePicker.datePickerMode = UIDatePickerMode.Time
        
       
        
        
        
      //  var calendar:NSCalendar = NSCalendar.currentCalendar()
      
        
     //   let components1 = calendar.components(NSCalendarUnit.HourCalendarUnit , fromDate: NSDate())
        
        
            //   timePicker.setDate(calendar.dateFromComponents(components1)!, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerChanged(sender: AnyObject) {
        setDateAndTime()
    }
    
    @IBAction func timePickerChanged(sender: AnyObject) {
        setDateAndTime()
    }

    
    func setDateAndTime() {
        
        
       // dateFormatter.locale = NSLocale.init(localeIdentifier: "fr")
        //let frenchDate       = dateFormatter.stringFromDate(date!)
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            GlobalVarible.SelectDate = dateFormatter.stringFromDate(datePicker.date)
            GlobalVarible.SelectTime = timeFormatter.stringFromDate(timePicker.date)
            
            dateTimeDisplay.text = dateFormatter.stringFromDate(datePicker.date) + " " + timeFormatter.stringFromDate(timePicker.date)
        

        }else{
        
        dateFormatter.locale = NSLocale.init(localeIdentifier: "fr")
            timeFormatter.locale = NSLocale.init(localeIdentifier: "fr_FR")
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
          GlobalVarible.SelectDate = dateFormatter.stringFromDate(datePicker.date)
            GlobalVarible.SelectTime = timeFormatter.stringFromDate(timePicker.date)
            
            dateTimeDisplay.text = dateFormatter.stringFromDate(datePicker.date) + " " + timeFormatter.stringFromDate(timePicker.date)
        
        }
        
      /*  dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        GlobalVarible.SelectDate = dateFormatter.stringFromDate(datePicker.date)
        GlobalVarible.SelectTime = timeFormatter.stringFromDate(timePicker.date)
        
        dateTimeDisplay.text = dateFormatter.stringFromDate(datePicker.date) + " " + timeFormatter.stringFromDate(timePicker.date)*/
    }

   
}
