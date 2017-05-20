//
//  NsUserDefaultManager.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 23/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import Foundation

public class NsUserDefaultManager {
    
    
    internal static let KeyInsurance = "insurance"
    internal static let KeyRegisteration = "rc"
    internal static let KeyLicence = "license"
    internal static let KeyDeviceId = "deviceId"
    internal static let KeyCarModelid = "carModelId"
    internal static let KeyOtherDoc = "otherDocs"
    internal static let KeyDriverid = "driverId"
    internal static let KeyDriverImage = "driverImage"
    internal static let KeyDriverEmail = "driverEmail"
    internal static let KeyDrivername = "driverName"
    internal static let KeyFlag = "flag"
    internal static let KeyCurrentLong = "currentLong"
    internal static let KeyCityId = "cityId"
    internal static let KeyCarNo = "carNumber"
    internal static let KeyPassword = "driverPassword"
    internal static let KeyCurrentLat = "currentLat"
    internal static let KeyPhoneno = "driverPhone"
    internal static let KeyCarType = "carTypeId"
    internal static let KeyOnOff = "onlineOffline"
    internal static let KeyStatus = "status"
    internal static let KeyLoginState = "LoginState"
    internal static let KeyDriverToken = "driverToken"
    internal static let KeyDetailStatus = "detailStatus"
    internal static let KeyLoginLogout = "loginLogout"
    internal static let KeyCarName = "cartypename"
    internal static let KeyCarModelName = "carmodelname"
    
    internal static let SingeltonInstance  = NsUserDefaultManager()
    
    
    func registerDriver(insurance : String  , rc : String  ,  licence : String , did : String , carModelId : String , otherDoc : String , driverId : String , driverImg : String , driverEmail : String  , driverName: String ,  flag : String  ,  long : String , cityid : String , carNo : String , password : String , lat : String , phoneNo : String , carType : String , onOff : String , status : String , loginLogout : String,driverToken : String,detailStatus : String,carmodelname : String , cartypename : String){
        
        NSUserDefaults.standardUserDefaults().setValue(insurance, forKey: "insurance")
        NSUserDefaults.standardUserDefaults().setValue(rc, forKey: "rc")
        NSUserDefaults.standardUserDefaults().setValue(licence, forKey: "license")
        NSUserDefaults.standardUserDefaults().setValue(did, forKey: "deviceId")
        
        NSUserDefaults.standardUserDefaults().setValue(carModelId, forKey: "carModelId")
        NSUserDefaults.standardUserDefaults().setValue(otherDoc, forKey: "otherDocs")
        NSUserDefaults.standardUserDefaults().setValue(driverId, forKey: "driverId")
        NSUserDefaults.standardUserDefaults().setValue(driverImg, forKey: "driverImage")
        NSUserDefaults.standardUserDefaults().setValue(driverEmail, forKey: "driverEmail")
        NSUserDefaults.standardUserDefaults().setValue(driverName, forKey: "driverName")
        NSUserDefaults.standardUserDefaults().setValue(flag, forKey: "flag")
        NSUserDefaults.standardUserDefaults().setValue(long, forKey: "currentLong")
        NSUserDefaults.standardUserDefaults().setValue(cityid, forKey: "cityId")
        NSUserDefaults.standardUserDefaults().setValue(carNo, forKey: "carNumber")
        NSUserDefaults.standardUserDefaults().setValue(password, forKey: "driverPassword")
        NSUserDefaults.standardUserDefaults().setValue(lat, forKey: "currentLat")
        NSUserDefaults.standardUserDefaults().setValue(phoneNo, forKey: "driverPhone")
        NSUserDefaults.standardUserDefaults().setValue(carType, forKey: "carTypeId")
        NSUserDefaults.standardUserDefaults().setValue(onOff, forKey: "onlineOffline")
        NSUserDefaults.standardUserDefaults().setValue(status, forKey: "status")
        NSUserDefaults.standardUserDefaults().setValue(loginLogout, forKey: "loginLogout")
        NSUserDefaults.standardUserDefaults().setValue(driverToken, forKey: "driverToken")
        NSUserDefaults.standardUserDefaults().setValue(detailStatus, forKey: "detailStatus")
        NSUserDefaults.standardUserDefaults().setValue(cartypename, forKey: "carmodelname")
        NSUserDefaults.standardUserDefaults().setValue(carmodelname, forKey: "cartypename")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey:"LoginState")
        
        //
        print("data saved")
        
    }
    
    
    func isloggedin() -> Bool{
        
        let  loginstate  = NSUserDefaults.standardUserDefaults().boolForKey("LoginState")
        
        if loginstate  {
            return true
        }else{
            return false
        }
    }
    
    func logOut(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("insurance")
        defaults.removeObjectForKey("rc")
        defaults.removeObjectForKey("license")
        defaults.removeObjectForKey("deviceId")
        defaults.removeObjectForKey("loginLogout")
        defaults.removeObjectForKey("carModelId")
        defaults.removeObjectForKey("otherDocs")
        defaults.removeObjectForKey("driverId")
        defaults.removeObjectForKey("driverImage")
        defaults.removeObjectForKey("driverEmail")
        defaults.removeObjectForKey("driverName")
        defaults.removeObjectForKey("flag")
        defaults.removeObjectForKey("currentLong")
        defaults.removeObjectForKey("cityId")
        defaults.removeObjectForKey("carNumber")
        defaults.removeObjectForKey("driverPassword")
        defaults.removeObjectForKey("currentLat")
        defaults.removeObjectForKey("driverPhone")
        defaults.removeObjectForKey("carTypeId")
        defaults.removeObjectForKey("onlineOffline")
        defaults.removeObjectForKey("status")
        defaults.removeObjectForKey("driverToken")
        defaults.removeObjectForKey("cartypename")
        defaults.removeObjectForKey("carmodelname")

        
        defaults.setBool(false, forKey:"LoginState")
    }
    
    func getuserdetails (key : String)-> String?
    {
        
        return NSUserDefaults.standardUserDefaults().stringForKey(key)!
    }
    
//    func saveImage(image: String){
//        NSUserDefaults.standardUserDefaults().setValue(image, forKey: "proImage")
//    }
    
    
}
