//
//  NsUserDekfaultManager.swift
//  TaxiApp
//
//  Created by AppOrio on 22/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import Foundation

 
public class NsUserDekfaultManager {


    internal static let Keyflag = "flag"
    internal static let Keyuserid = "user_id"
    internal static let Keyname = "name"
    internal static let Keyimage = "image"
    internal static let Keyemail = "email"
    internal static let Keyphonenumber = "phone_number"
    internal static let Keystatus = "status"
    internal static let Keypassword = "password"
    internal static let KeyloginState = "LoginState"


    internal static let SingeltionInstance  = NsUserDekfaultManager()
    
    
    
    
    func loginuser(flag : String  , user_id : String  ,  name : String , image : String , email : String , phonenumber : String , status :String , password : String ){
        
        
        NSUserDefaults.standardUserDefaults().setValue(flag, forKey: "flag")
        NSUserDefaults.standardUserDefaults().setValue(user_id, forKey: "user_id")
        NSUserDefaults.standardUserDefaults().setValue(name, forKey: "name")
        NSUserDefaults.standardUserDefaults().setValue(image, forKey: "image")
        NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
        NSUserDefaults.standardUserDefaults().setValue(phonenumber, forKey: "phone_number")
        NSUserDefaults.standardUserDefaults().setValue(status, forKey: "status")
        NSUserDefaults.standardUserDefaults().setValue(password, forKey: "password")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "LoginState")
    
      //  NSUserDefaults.standardUserDefaults().setBool(true, forKey: "LoginState")
        
        
    }
    
     
    
    func isloggedin() -> Bool{
        
        let  loginstate  = NSUserDefaults.standardUserDefaults().boolForKey("LoginState")
        
        if loginstate  {
            return true
        }else{
            return false
        }
    }
    

    


    func getuserdetaild (key : String)-> String?
    {
        
        return NSUserDefaults.standardUserDefaults().stringForKey(key)!
    }
    


    func logOut(){
        
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()

        GIDSignIn.sharedInstance().signOut()


        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("user_id")
        defaults.removeObjectForKey("name")
        defaults.removeObjectForKey("image")
        defaults.removeObjectForKey("email")
        defaults.removeObjectForKey("phone_number")
        defaults.removeObjectForKey("status")
        defaults.removeObjectForKey("flag")
        defaults.removeObjectForKey("password")
        defaults.setBool(false, forKey:"LoginState")
      
        
        
        
    }
    




}