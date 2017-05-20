//
//  CalenderViewController.swift
//  TaxiApp
//
//  Created by AppOrio on 30/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calender: FSCalendar!
     @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var year = 0
    var month = 0
    var day = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calender.scrollDirection = .Vertical
        calender.appearance.caseOptions = [.HeaderUsesUpperCase,.WeekdayUsesUpperCase]
       
        //        calendar.scope = .Week
        calender.scopeGesture.enabled = true
 

        // Do any additional setup after loading the view.
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        year =  components.year
        month = components.month
        day = components.day
         calender.selectDate(calender.dateWithYear(year, month: month, day: day))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func minimumDateForCalendar(calendar: FSCalendar) -> NSDate {
        return calendar.dateWithYear(year, month: month, day: day)
    }
    
    func maximumDateForCalendar(calendar: FSCalendar) -> NSDate {
        return calendar.dateWithYear(2018, month: 10, day: 31)
    }
    
    func calendar(calendar: FSCalendar, numberOfEventsForDate date: NSDate) -> Int {
        let day = calendar.dayOfDate(date)
        return day % 5 == 0 ? day/5 : 0;
    }
    
    func calendarCurrentPageDidChange(calendar: FSCalendar) {
        NSLog("change page to \(calendar.stringFromDate(calendar.currentPage))")
    }
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        NSLog("calendar did select date \(calendar.stringFromDate(date))")
    }
    
    func calendar(calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(calendar: FSCalendar, imageForDate date: NSDate) -> UIImage? {
        return [13,24].containsObject(calendar.dayOfDate(date)) ? UIImage(named: "icon_cat") : nil
    }
    @IBAction func okbtn(sender: AnyObject) {
        
    }
    
    @IBAction func cancekbtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
