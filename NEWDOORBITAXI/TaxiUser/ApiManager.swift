//
//  ApiManager.swift
//  TaxiApp
//
//  Created by AppOrio on 22/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


protocol MainCategoryProtocol {
    func onProgressStatus(value : Int)
    func onerror(msg : String, errorCode: Int)
    func onSuccessExecution (msg : String)
    func onSuccessParse(data : AnyObject)
    
    
}


class ApiManager{
    
    
    
    var protocolmain_Catagory : MainCategoryProtocol! = nil
    
    static let sharedInstance = ApiManager()
    
    
    
    func VerifyPhoneNumber(PhoneNumber: String){
    
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.verifyphone + "\(PhoneNumber)&language_id=\("1")")
            
        }else{
            
            url = (API_URL.verifyphone + "\(PhoneNumber)&language_id=\("2")")
        
      
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        GlobalVarible.Api = "phonenumberverify"
                        
                        let dataToParse = JSON(value)
                        let  ParsedData = VerifyPhoneModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }

        
    }
    
    
    
    func GetOTP(PhoneNumber: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
           
            url = (API_URL.getotp + "\(PhoneNumber)&flag=\("1")&language_id=\("1")")
        
            
        }else{
            
            url = (API_URL.getotp + "\(PhoneNumber)&flag=\("1")&language_id=\("2")")
      
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                          GlobalVarible.Api = "OtpResponse"
                                               
                        let dataToParse = JSON(value)
                        let  ParsedData = OTPModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        
        
        
        
        
    }

    
    
    func CreateNewPassword(PhoneNumber: String,Password: String){
        
        var dataToParse:JSON=nil
      
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
         
            url = (API_URL.createpassword + "\(PhoneNumber)&user_password=\(Password)&language_id=\("1")")

     
        }else{
            
              url = (API_URL.createpassword + "\(PhoneNumber)&user_password=\(Password)&language_id=\("2")")
         

        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "createpassword"
                        
                        
                        dataToParse = JSON(value)
                        
                        print("JSON: \(dataToParse)")
                        
                        self.protocolmain_Catagory.onSuccessParse(value)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
        
    }
    
  

    
    func SocialToken(SOCIALTOKEN: String){
        
          var dataToParse:JSON=nil
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
        url = (API_URL.socialtoken + "\(SOCIALTOKEN)&language_id=\("1")")
            
        }else{
            
             url = (API_URL.socialtoken + "\(SOCIALTOKEN)&language_id=\("2")")
        
          

        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                       GlobalVarible.Api = "Socialtokenresponse"
                        
                        
                        dataToParse = JSON(value)
                        
                        print("JSON: \(dataToParse)")
                        
                        self.protocolmain_Catagory.onSuccessParse(value)
                        
                    }
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        
        
        
        
        
    }
    
 
    
    func SocialRegisterUser(Email: String,PhoneNumber: String,SocialToken: String,Name: String){
        
        
        var dataToParse:JSON=nil
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
         url = (API_URL.socialregister + "\(SocialToken)&user_name=\(Name)&user_email=\(Email)&user_phone=\(PhoneNumber)&social_type=\(GlobalVarible.socialtype)&language_id=\("1")")
     
        }else{
            
            url = (API_URL.socialregister + "\(SocialToken)&user_name=\(Name)&user_email=\(Email)&user_phone=\(PhoneNumber)&social_type=\(GlobalVarible.socialtype)&language_id=\("2")")
        
      
        }
        
       
        
        print(url)
        
       let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    
                    if let value = response.result.value{
                        
                        
                        dataToParse = JSON(value)
                        
                        print("JSON: \(dataToParse)")
                        
                        self.protocolmain_Catagory.onSuccessParse(value)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                    
                }
        }
        
        
        
        
    }
    
    



    

    func getcoupons(CouponCode: String)
    {
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
         url = (API_URL.getcoupon + "\(CouponCode)&language_id=\("1")")
       
        }else{
            
              url = (API_URL.getcoupon + "\(CouponCode)&language_id=\("2")")
        
     
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    let dataToParse = JSON(value)
                    let  ParsedData = Coupons(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                }
        }
        
        
        
        
    }
    
   // http://apporio.co.uk/apporiotaxi/api/car_type.php?city_id=1

    
  /*  func ViewRatecardcars(CITYID: String)
    {
        
        
        
        let url = "http://apporio.co.uk/apporiotaxi/api/car_type.php?city_id=\(CITYID)"
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                       
                        
                        let dataToParse = JSON(value)
                        let  ParsedData = CarType(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        
        
        
        
    }*/
    

    
    
    func viewcars(UserCityName: String)
    {
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
         url = (API_URL.Viewcars + "\(UserCityName)&language_id=\("1")")
        
      
        }else{
            
            url = (API_URL.Viewcars + "\(UserCityName)&language_id=\("2")")

        
         

        }
         print(url)
        
        let escapedStringUrl = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(escapedStringUrl)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , escapedStringUrl)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    GlobalVarible.Api = "getcartype"

                    let dataToParse = JSON(value)
                    let  ParsedData = CarType(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                }
        }
        
        
        
        
    }
    
    
    
    func ViewCarsWithTime(UserCityName: String, USERLAT: String, USERLNG: String){
        
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.viewcarswithtime + "\(UserCityName)&user_lat=\(USERLAT)&user_long=\(USERLNG)&language_id=\("1")")
        
            
        }else{
            
             url = (API_URL.viewcarswithtime + "\(UserCityName)&user_lat=\(USERLAT)&user_long=\(USERLNG)&language_id=\("2")")
        
   
        }
    
       
        print(url)
        
        let escapedStringUrl = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(escapedStringUrl)
        
      //  protocolmain_Catagory.onProgressStatus(1)
        
        Alamofire.request(.GET , escapedStringUrl)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                   // self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        GlobalVarible.Api = "CarsTimeModel"
                        
                        let dataToParse = JSON(value)
                        let  ParsedData = CarsTImeModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        
        
        

    
    
    
    }
    
    
    func RegisterUser(Email: String,PhoneNumber: String,Password: String,Name: String){
    
    
         var dataToParse:JSON=nil
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
           url = (API_URL.Register + "\(Name)&user_email=\(Email)&user_phone=\(PhoneNumber)&user_password=\(Password)&language_id=\("1")")
         
        }else{
            
             url = (API_URL.Register + "\(Name)&user_email=\(Email)&user_phone=\(PhoneNumber)&user_password=\(Password)&language_id=\("2")")
            
   
        
        }
        
         print(url)
    
         let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!

        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                
                if let value = response.result.value{
                    
                    
                    dataToParse = JSON(value)
                    
                    print("JSON: \(dataToParse)")
                    
                    self.protocolmain_Catagory.onSuccessParse(value)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                    
                }
        }
        
        
        
    
    }
    
    

    func loginuser(PhoneNumber: String,Password: String){
          var dataToParse:JSON=nil
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.loginuser + "\(PhoneNumber)&user_password=\(Password)&language_id=\("1")")
         }else{
         url = (API_URL.loginuser + "\(PhoneNumber)&user_password=\(Password)&language_id=\("2")")
          

        }
        
         print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                switch response.result {
                case.Success( _):
                    
                 self.protocolmain_Catagory.onProgressStatus(0)
                 self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                
                if let value = response.result.value{
                    
                    GlobalVarible.Api = "loginuser"
                    
                    dataToParse = JSON(value)
                    
                    print("JSON: \(dataToParse)")
                    
                    self.protocolmain_Catagory.onSuccessParse(value)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }
        
        
        
    }
    


   
    
    
    func forgotPassword(email:String)-> JSON{
        
        
        var dataToParse:JSON=nil
        
     
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.forgetpassword + "\(email)&language_id=\("1")")
      
        }else{
            url = (API_URL.forgetpassword + "\(email)&language_id=\("2")")
            
            
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        // protocolmain_Catagory.onProgressStatus(1)
        
         print(url)
        var finishFlag = 0
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                
                
                //self.protocolmain_Catagory.onProgressStatus(0)
                if let value = response.result.value{
                    dataToParse = JSON(value)
                    finishFlag = 1
                    
                    
                }
                
        }
        
        while finishFlag == 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
        }
        
        
        
        return dataToParse
        
    }

    
    
    
    
    func ChangePassword(UserId: String , NewPassword: String , OldPassword: String){
    
         var dataToParse:JSON=nil
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.changepassword + "\(UserId)&old_password=\(OldPassword)&new_password=\(NewPassword)&language_id=\("1")")
            
        
            
        }else{
            
            
             url = (API_URL.changepassword + "\(UserId)&old_password=\(OldPassword)&new_password=\(NewPassword)&language_id=\("2")")
        
        
        }
        
        
         let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
         print(url)
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                
                if let value = response.result.value{
                    
                    
                    dataToParse = JSON(value)
                    
                    print("JSON: \(dataToParse)")
                    
                    self.protocolmain_Catagory.onSuccessParse(value)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                    
                }
        }
        
    }
    
    
      
    
   /* func EditProfile(UserId: String , Name: String , MobileNumber: String ){
    
  //  func EditProfile(Parameters: [String: String] , Image: UIImage) {
    
        var dataToParse:JSON=nil
        
     
        
         let url = "http://apporio.in/taxi_app/api/edit_profile.php?user_id=\(UserId)&name=\(Name)&phone_number=\(MobileNumber)"
         let url1 = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                
                if let value = response.result.value{
                    
                    
                    dataToParse = JSON(value)
                    
                    print("JSON: \(dataToParse)")
                    
                    self.protocolmain_Catagory.onSuccessParse(value)
                    
                    
                    
                }
        }

    
    }*/
    
    
    
    
    func EditProfile(Parameters: [String: String] , Image: UIImage) {
    
        
        var URL = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
       URL = (API_URL.EditProfile + "\("1")")
            
        }else{
             URL = (API_URL.EditProfile + "\("2")")
            
        }
        
        Alamofire.upload(.POST, URL, multipartFormData: { MultipartFormData in
            
            
            if  let imageData = UIImageJPEGRepresentation(Image, 0.5) {
                MultipartFormData.appendBodyPart(data: imageData, name: "user_image", fileName: "file.png", mimeType: "image/png")
            }
            
            for (key, value) in Parameters {
                
                print("Key is: \(key)")
                print("Value is: \(value)")
                MultipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            
                 
            
           },encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    
                case .Success(let data ,_,_ ) :
                    
                    data.responseJSON { response in
                        print("Url is: \(URL)")
                        //  print("Response is: \(response)")
                        
                        
                      //  self.delegate.onProgressState(1)
                        
                        self.protocolmain_Catagory.onProgressStatus(0)
                        self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")

                        
                        if let DATA =  response.result.value
                            
                        {
                            print(DATA)
                            
                              self.protocolmain_Catagory.onSuccessParse(DATA)
                           // self.delegate.onSuccessState(EditProfile(json: JSON(DATA)), resultCode: 55)
                            
                        }
                        
                    }
                    
                case .Failure(let error):
                    
                    //self.delegate.onErrorsState(String(error), errorCode: 90)
                    
                    print("Request failed with error: \(error)")
                }
                
        })
        
        
    
    
    
    
    
    
    }
    
    
    
    func CityList(){
        
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
        url = (API_URL.ViewCity + "\("1")")
       
        }else{
            
            url = (API_URL.ViewCity + "\("2")")
        
      
        }
         print(url)
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    let dataToParse = JSON(value)
                    let  ParsedData = CityName(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                }
        }
        
        
        
        
    }
    
    
    func driverlocation(CarTypeId: String ,CityId: String ,USERLAT: String ,USERLNG: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.viewdriverlocation + "\(CarTypeId)&city_id=\(CityId)&user_lat=\(USERLAT)&user_long=\(USERLNG)&language_id=\("1")")
            
   
        }else{
            
               url = (API_URL.viewdriverlocation + "\(CarTypeId)&city_id=\(CityId)&user_lat=\(USERLAT)&user_long=\(USERLNG)&language_id=\("2")")
            
            
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
             
        print(url)
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        GlobalVarible.Api = "nearByCar"
                        
                        let dataToParse = JSON(value)
                        let  ParsedData = DriverLocation(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        
        
        
        
    }
    
    

    
//    func ShowRides(UserId: String, RideStatus: String){
//        
//        
//        
//         let url = "http://apporio.in/taxi_app/api/view_my_ride.php?user_id=\(UserId)&ride_status=\(RideStatus)"
//        
//        protocolmain_Catagory.onProgressStatus(1)
//        Alamofire.request(.GET , url)
//            .responseJSON { response in
//                self.protocolmain_Catagory.onProgressStatus(0)
//                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
//                
//                if let value = response.result.value{
//                    let dataToParse = JSON(value)
//                    let  ParsedData = UpComingRides(json: dataToParse)
//                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
//                }
//        }
//        
//        
//        
//        
//    }
//    
    
    

    func ShowAllRides(UserId: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.viewrides + "\(UserId)&language_id=\("1")")
            
   
        }else{
            
              url = (API_URL.viewrides + "\(UserId)&language_id=\("2")")
        
                 
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
         print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    let dataToParse = JSON(value)
                     print("JSON: \(dataToParse)")
                    let  ParsedData = AllRides(json: dataToParse)
                    GlobalVarible.RideResult = ParsedData.result!
                    
                    print(GlobalVarible.RideResult)

                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                
                }
        }
        
          
        
    }
    
    func AboutUs(){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.Aboutus + "\("1")")
            
    
        }else{
            
             url = (API_URL.Aboutus + "\("2")")
          
        }
    
     print(url)
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    let dataToParse = JSON(value)
                    let  ParsedData = TermsModel(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                }
        }
        

        
    
    }
    
    
    func TermsConditions(){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.TermsAndConditions + "\("1")")
   
        }else{
             url = (API_URL.TermsAndConditions + "\("2")")
      
        }
         print(url)
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    
                    let dataToParse = JSON(value)
                    let  ParsedData = TermsModel(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }
        

        
    
    }
    
    func ContactApi()-> JSON{
        
        
        var dataToParse:JSON=nil
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.callSupport + "\("1")")
      
        }else{
         url = (API_URL.callSupport + "\("2")")
      
        }
        // protocolmain_Catagory.onProgressStatus(1)
         print(url)
        var finishFlag = 0
        Alamofire.request(.GET , url)
            
            .responseJSON { response in
                
                
                //self.protocolmain_Catagory.onProgressStatus(0)
                if let value = response.result.value{
                    dataToParse = JSON(value)
                    finishFlag = 1
                   
                    
                    GlobalVarible.ContactTelephone  =  value["details"]!!["description"] as! String
                    
                    
                    
                }
                
        }
        
        while finishFlag == 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
        }
        
        
        
        return dataToParse
        
    }
    

    
    func RateCard(City: String , CarTypeId: String) {
        
       // http://apporio.co.uk/apporiotaxi/api/rate_card_city.php?city=dfdfdf&car_type_id=1
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.ratecard + "\(City)&car_type_id=\(CarTypeId)&language_id=\("1")")
            
           
        }else{
         url = (API_URL.ratecard + "\(City)&car_type_id=\(CarTypeId)&language_id=\("2")")
        

        }

        
  
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
         print(url)
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    let dataToParse = JSON(value)
                    let  ParsedData = RateCardModel(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }
        
        
        
    
    }
    
  
    func RideEstimatedScreen(Distance: String,CITYID: String,CARTYPEId: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.rideestimate + "\(Distance)&city_id=\(CITYID)&car_type_id=\(CARTYPEId)&language_id=\("1")")
   
          
        }else{
            
            url = (API_URL.rideestimate + "\(Distance)&city_id=\(CITYID)&car_type_id=\(CARTYPEId)&language_id=\("2")")
        
       
        }
   
        print(url)
        
      let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!

    
    print(url)
      //  protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
               // self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    
                      GlobalVarible.Api = "rideestimateresponse"
                    let dataToParse = JSON(value)
                    let  ParsedData = RideEstimate(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }
        

        
    
    }
    
    
    func ConfirmRide(USERID: String,COUPONCODE: String,USERCURRENTLAT: String,USERCURRENTLONG: String,CURRENTADDRESS: String,DROPLAT: String,DROPLNG: String,DropLOCATION: String,RIDETYPE: String,RIDESTATUS: String,CARTYPEID: String,PaymentOPtionId: String,CardId: String){
    
         var dataToParse:JSON=nil
        
       // http://apporio.co.uk/apporiotaxi/api/ride_now.php?user_id=1&coupon_code=1&pickup_lat=abc&pickup_long=a&pickup_location=1&drop_lat=1&drop_long=1&drop_location=1&ride_type=1&ride_status=1&driver_id=
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            
            url = (API_URL.RideNow + "\(USERID)&coupons_code=\(COUPONCODE)&pickup_lat=\(USERCURRENTLAT)&pickup_long=\(USERCURRENTLONG)&pickup_location=\(CURRENTADDRESS)&drop_lat=\(DROPLAT)&drop_long=\(DROPLNG)&drop_location=\(DropLOCATION)&ride_type=\(RIDETYPE)&ride_status=\(RIDESTATUS)&car_type_id=\(CARTYPEID)&payment_option_id=\(PaymentOPtionId)&card_id=\(CardId)&language_id=\("1")")
            
             }else{
            
             url = (API_URL.RideNow + "\(USERID)&coupons_code=\(COUPONCODE)&pickup_lat=\(USERCURRENTLAT)&pickup_long=\(USERCURRENTLONG)&pickup_location=\(CURRENTADDRESS)&drop_lat=\(DROPLAT)&drop_long=\(DROPLNG)&drop_location=\(DropLOCATION)&ride_type=\(RIDETYPE)&ride_status=\(RIDESTATUS)&car_type_id=\(CARTYPEID)&payment_option_id=\(PaymentOPtionId)&card_id=\(CardId)&language_id=\("2")")
        
     
        }
        
        
         print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                
                if let value = response.result.value{
                    GlobalVarible.Api = "confirmridebook"
                    
                    dataToParse = JSON(value)
                    
                    print("JSON: \(dataToParse)")
                    
                    self.protocolmain_Catagory.onSuccessParse(value)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                    
                    
                }
        }
        

        
    
    }
    
    
  func RideLaterConfirm(USERID: String,COUPONCODE: String,USERCURRENTLAT: String,USERCURRENTLONG: String,CURRENTADDRESS: String,DROPLAT: String,DROPLNG: String,DropLOCATION: String,SELECTTIME: String,SELECTDATE: String,RIDETYPE: String,RIDESTATUS: String,CARTYPEID: String,PaymentOPtionId: String,CardId: String) {
    
        
        var dataToParse:JSON=nil
    
    var url = ""
    if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
        
        
        url = (API_URL.RideLater + "\(USERID)&coupon_code=\(COUPONCODE)&pickup_lat=\(USERCURRENTLAT)&pickup_long=\(USERCURRENTLONG)&pickup_location=\(CURRENTADDRESS)&drop_lat=\(DROPLAT)&drop_long=\(DROPLNG)&drop_location=\(DropLOCATION)&later_date=\(SELECTDATE)&later_time=\(SELECTTIME)&ride_type=\(RIDETYPE)&ride_status=\(RIDESTATUS)&car_type_id=\(CARTYPEID)&payment_option_id=\(PaymentOPtionId)&card_id=\(CardId)&language_id=\("1")")
  
         }else{
        
        
        url = (API_URL.RideLater + "\(USERID)&coupon_code=\(COUPONCODE)&pickup_lat=\(USERCURRENTLAT)&pickup_long=\(USERCURRENTLONG)&pickup_location=\(CURRENTADDRESS)&drop_lat=\(DROPLAT)&drop_long=\(DROPLNG)&drop_location=\(DropLOCATION)&later_date=\(SELECTDATE)&later_time=\(SELECTTIME)&ride_type=\(RIDETYPE)&ride_status=\(RIDESTATUS)&car_type_id=\(CARTYPEID)&payment_option_id=\(PaymentOPtionId)&card_id=\(CardId)&language_id=\("2")")

   
    
    }
    
        print(url)
       
       let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                
                if let value = response.result.value{
                    GlobalVarible.Api = "RideLaterBook"
                    
                    dataToParse = JSON(value)
                    
                    print("JSON: \(dataToParse)")
                    
                    self.protocolmain_Catagory.onSuccessParse(value)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                    
                }
        }

        
    }
    
    
    
    
    func CancelRide(RIDEID: String,RIDESTATUS: String) -> JSON{
    
     var dataToParse:JSON=nil
 
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.Cancelbyuser + "\(RIDEID)&ride_status=\(RIDESTATUS)&reason_id=\(GlobalVarible.cancelId)&language_id=\("1")")
            
           
        }else{
             url = (API_URL.Cancelbyuser + "\(RIDEID)&ride_status=\(RIDESTATUS)&reason_id=\(GlobalVarible.cancelId)&language_id=\("2")")
            
            
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
         print(url)
        var finishFlag = 0
        Alamofire.request(.GET , url1)
            
            .responseJSON { response in
                
                
                
                if let value = response.result.value{
                    dataToParse = JSON(value)
                    finishFlag = 1
                    
                    
                    print(dataToParse)
                    
                    
                }
        }
        
        while finishFlag == 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
        }
        
        
        
        return dataToParse
        

    
        
    
        
    }
    
    
    func UserDeviceId(USERID: String,USERDEVICEID: String,FLAG: String){
     //   http://apporio.in/apporiotaxi/api/deviceid_user.php?user_id=7&device_id=1&flag=2
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.DeviceId + "\(USERID)&device_id=\(USERDEVICEID)&flag=\(FLAG)&language_id=\("1")")
     
        }else{
            
            url = (API_URL.DeviceId + "\(USERID)&device_id=\(USERDEVICEID)&flag=\(FLAG)&language_id=\("2")")
        
       

        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
     print(url)
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    let dataToParse = JSON(value)
                    print(dataToParse)
                    //let  ParsedData = RideEstimate(json: dataToParse)
                   // self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }
        

     
    
    }
    
    
    
    func DriverInformation(RIDEID: String)
    {
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
           url = (API_URL.driverdetails + "\(RIDEID)&language_id=\("1")")
    
        }else{
             url = (API_URL.driverdetails + "\(RIDEID)&language_id=\("2")")
            
            
        }
     print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                
                
                if let value = response.result.value{
                     GlobalVarible.Api = "DriverInformation"
                    let dataToParse = JSON(value)
                    print(dataToParse)
                    let  ParsedData = DriverInfo(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                }
                
        }
      
    }
    
    
    func ViewDoneRide(RIDEID: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
      
            url = (API_URL.viewdonerideinfo + "\(RIDEID)&language_id=\("1")")
             }else{
               url = (API_URL.viewdonerideinfo + "\(RIDEID)&language_id=\("2")")
          
        
        
        }
     print(url)
            protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                   GlobalVarible.Api = "DoneRideInformation"
                    
                    let dataToParse = JSON(value)
                    print(dataToParse)
                    let  ParsedData = DoneRideModel(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }

       
    }
    
    
    
    func TrackDriver(RIDEID: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.trackride + "\(RIDEID)&language_id=\("1")")
     
        }else{
             url = (API_URL.trackride + "\(RIDEID)&language_id=\("2")")
            
        }
         print(url)
       // protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
              //  self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    GlobalVarible.Api = "DriverTrack"
                    
                    let dataToParse = JSON(value)
                    print(dataToParse)
                    let  ParsedData = DriveTrackModel(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }
        

      
    
    }
    
    
    
    func RatingSubmitbtn(UserId: String , DriverId: String , RatingStar: String , RideId: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.userrating + "\(UserId)&driver_id=\(DriverId)&rating_star=\(RatingStar)&comment=\("")&ride_id=\(RideId)&language_id=\("1")")
   
        }else{
            
            url = (API_URL.userrating + "\(UserId)&driver_id=\(DriverId)&rating_star=\(RatingStar)&comment=\("")&ride_id=\(RideId)&language_id=\("2")")
       
  
        
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                self.protocolmain_Catagory.onProgressStatus(0)
                self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                   
                    let dataToParse = JSON(value)
                    print(dataToParse)
                   // let  ParsedData = DriveTrackModel(json: dataToParse)
                    self.protocolmain_Catagory.onSuccessParse(value)
                    
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")

                    
                }
        }

        
    
    }
    
    func ConfirmPayment(OrderId: String, UserId: String, PaymentId: String,PaymentMethod: String,PaymentPlatform: String, PaymentAmount: String, PaymentDate: String, PaymentStatus: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.confirmpayment + "\(OrderId)&user_id=\(UserId)&payment_id=\(PaymentId)&payment_method=\(PaymentMethod)&payment_platform=\(PaymentPlatform)&payment_amount=\(PaymentAmount)&payment_date_time=\(PaymentDate)&payment_status=\(PaymentStatus)&language_id=\("1")")
            
          }else{
            
             url = (API_URL.confirmpayment + "\(OrderId)&user_id=\(UserId)&payment_id=\(PaymentId)&payment_method=\(PaymentMethod)&payment_platform=\(PaymentPlatform)&payment_amount=\(PaymentAmount)&payment_date_time=\(PaymentDate)&payment_status=\(PaymentStatus)&language_id=\("2")")
    
        
        }
        
       let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        GlobalVarible.Api = "CONFIRMPAYMENT"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = CompletePayment(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
        
    }
    

    
    func FindDistance(){
    
   // key=&origins=28.4101574783944,77.0476813986897&destinations=28.4121763232743,77.0432902872562&language=en-EN
    
    let pickuplng = Double(GlobalVarible.PickUpLng)!
     let pickuplat = Double(GlobalVarible.PickUpLat)!
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?key=\("")&origins=\(pickuplat),\(pickuplng)&destinations=\(GlobalVarible.UserDropLat),\(GlobalVarible.UserDropLng)&language=\("en-EN")"
    
      let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url1)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                       GlobalVarible.Api = "distancetype"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                       let  ParsedData = DistanceModel(json: dataToParse)
                       self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }

    
    }
    
    
    
    func FindDistance1(DriverLat: String,DriverLong: String){
        
        
        let pickuplng = Double(GlobalVarible.PickUpLng)!
        let pickuplat = Double(GlobalVarible.PickUpLat)!
        
        let driverlat = Double(DriverLat)!
        let driverlong = Double(DriverLong)!
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?key=\("")&origins=\(pickuplat),\(pickuplng)&destinations=\(driverlat),\(driverlong)&language=\("en-EN")"
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url1)
        
       // protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                  //  self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        GlobalVarible.Api = "distancetypenew"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = DistanceModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
    }
    
    
    
    func FindDirectionlatlng(pickLat: Double,pickLng: Double, DropLat : Double,DropLng: Double){
        
        
           
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(pickLat),\(pickLng)&destination=\(DropLat),\(DropLng)"
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url1)
        
        // protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success(let data):
                    
                    //  self.protocolmain_Catagory.onProgressStatus(0)
                    //self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                     GlobalVarible.Api = "directionapiresult"
                    print(data)
                    
                    self.protocolmain_Catagory.onSuccessParse(data)
                    
                  /*  if let value = response.result.value{
                        GlobalVarible.Api = "distancetypenew"
                        
                       // let dataToParse = JSON(value)
                      //  print(dataToParse)
                      //  let  ParsedData = DistanceModel(json: dataToParse)
                      //  self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }*/
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
    }

    

    
    
    func logoutUser(UserId: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.logoutuser + "\(UserId)&language_id=\("1")")
            
    
        }else{
            
             url = (API_URL.logoutuser + "\(UserId)&language_id=\("2")")
         

        
        }
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "userlogout"
                        
                        let dataToParse = JSON(value)
                        let  ParsedData = LogOutModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        

       
    }
    
    
    
    func FindGooglePlaceId()
        
        
    {
        //  AIzaSyB5xfHcGWzuPesz-MegU46fAdY6ZyfCfMo
      //	AIzaSyDNZGc86UgBq1391HDNl8VUuZ5j16fIxo4
        let logoutapi = "https://maps.googleapis.com/maps/api/place/details/json?key=\("AIzaSyB5xfHcGWzuPesz-MegU46fAdY6ZyfCfMo")&placeid=\(GlobalVarible.PlaceId)"
        
        print(logoutapi)
        
        let escapedStringUrl = logoutapi.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(escapedStringUrl)
        
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , escapedStringUrl)
            .responseJSON { response in
                
                switch response.result {
                case.Success(let data):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    print(data)
                    
                    self.protocolmain_Catagory.onSuccessParse(data)
                    
                 /*   if let value = response.result.value{
                        
                        
                        let dataToParse = JSON(value)
                       // let  ParsedData = LogOutModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(value)
                    }*/
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }

        
    }
    
    func reasonCancel(){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.cancelreasonuser + "\("1")")
            
      
        }else{
          url = (API_URL.cancelreasonuser + "\("2")")
      
        }
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "cancelreason"
                        
                        let dataToParse = JSON(value)
                        let  ParsedData = ReasonModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        
        
    }
    
    
    
    func Mailinvoice(DoneRideId: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            url = (API_URL.sendinvoice + "\(DoneRideId)&language_id=\("1")")
            
      
        }else{
            
             url = (API_URL.sendinvoice + "\(DoneRideId)&language_id=\("2")")
               }
        print(url)
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "mailinvoice"
                        
                        let dataToParse = JSON(value)
                        let  ParsedData = MailInvoiceModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                }
        }
        
        
    }
    
    
    func SaveCardDetails(UserId: String , UserEmail: String , StripeToken : String){
        
        
        // &user_email=&stripe_token=
        
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.savecard + "\(UserId)&user_email=\(UserEmail)&stripe_token=\(StripeToken)&language_id=\("1")")
          
        }else{
            
            url = (API_URL.savecard + "\(UserId)&user_email=\(UserEmail)&stripe_token=\(StripeToken)&language_id=\("2")")
          
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        GlobalVarible.Api = "Savecard"
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = SaveCardModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
        
    }
    
    
    func viewcarddetails(UserId: String){
        
        
        // 3&language_id=1
        
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.viewcard + "\(UserId)&language_id=\("1")")
           
        }else{
            
            url = (API_URL.viewcard + "\(UserId)&language_id=\("2")")
          
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "viewcard"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = CardDetailsModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
        
        
    }
    
    
    func DeleteCard(CardId : String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.deletecard + "\(CardId)&language_id=\("1")")
            
        }else{
            
            url = (API_URL.deletecard + "\(CardId)&language_id=\("2")")
           
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "deletecard"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = DeleteCardModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
        
    }
    
    
    func PayPaymentCard(RideId: String,Amount: String){
        
     //   http://apporio.co.uk/apporiotaximulti/api/pay_with_card.php?ride_id=990&language_id=1&amount=1
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.paycard + "\(RideId)&amount=\(Amount)&language_id=\("1")")
            
        }else{
            
            url = (API_URL.paycard + "\(RideId)&amount=\(Amount)&language_id=\("2")")
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "paycard"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = PayCardModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }

        
    }
    
    func ViewPaymentOption(){
    
    
    
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.viewpaymentoption + "\("1")")
            
        }else{
            
            url = (API_URL.viewpaymentoption + "\("2")")
            
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                      
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = ViewPaymentModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }

        
    }
    
    
    
    func CancelRide60Sec(RideID: String){
        
        
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.cancelride60sec + "\(RideID)")
            
        }else{
            
            url = (API_URL.cancelride60sec + "\(RideID)")
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        
                        let dataToParse = JSON(value)
                        //    print(dataToParse)
                        //   let  ParsedData = ViewPaymentModel(json: dataToParse)
                        //  self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
    }

    

    func customerSync1(RideId: String,UserId: String){
        
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.customersync + "\(RideId)&user_id=\(UserId)&language_id=\("1")")
            
        }else{
            
            url = (API_URL.customersync + "\(RideId)&user_id=\(UserId)&language_id=\("2")")
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
      //  protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                  //  self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "customersync"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = CustomerSyncModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
    }
    
    
    func customerSyncEnd(RideId: String,UserId: String){
        
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            url = (API_URL.customersyncend + "\(RideId)&user_id=\(UserId)&language_id=\("1")")
            
        }else{
            
            url = (API_URL.customersyncend + "\(RideId)&user_id=\(UserId)&language_id=\("2")")
            
            
        }
        
        
        print(url)
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        protocolmain_Catagory.onProgressStatus(1)
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                switch response.result {
                case.Success( _):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    if let value = response.result.value{
                        
                        GlobalVarible.Api = "customersyncend"
                        
                        let dataToParse = JSON(value)
                        print(dataToParse)
                        let  ParsedData = CustomerSyncModel(json: dataToParse)
                        self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                    }
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                    
                    
                }
        }
        
        
    }
    
    
    
    func postData(dictonary: NSDictionary , url: String)
    {
        
       /* let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.delegate.onProgressState!(0)
                
            })*/
        
             protocolmain_Catagory.onProgressStatus(1)
            
            
            Alamofire.request(.POST , url , parameters: dictonary as? [String : AnyObject])
                
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                        
                    case.Success(let data):
                        
                        self.protocolmain_Catagory.onProgressStatus(0)
                        self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                        
                    // if let value = response.result.value{
                            
                           // GlobalVarible.Api = "customersyncend"
                            
                            let dataToParse = JSON(data)
                            print(dataToParse)
                            let  ParsedData = SignupLoginResponse(json: dataToParse)
                          //  self.protocolmain_Catagory.onSuccessParse(ParsedData)

                        print(ParsedData)

                         self.protocolmain_Catagory.onSuccessParse(ParsedData)
                        
                        
                    case .Failure(let error):
                        
                        self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                        
                        print("Request failed with error: \(error)")
                    }
            }
            
            
            
     //   })
        
        
    }
    
    
    func postData1(dictonary: NSDictionary , url: String)
    {
        
        /* let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
         
         dispatch_async(backgroundQueue, {
         
         dispatch_async(dispatch_get_main_queue(), { () -> Void in
         
         self.delegate.onProgressState!(0)
         
         })*/
        
        protocolmain_Catagory.onProgressStatus(1)
        
        
        Alamofire.request(.POST , url , parameters: dictonary as? [String : AnyObject])
            
            .responseJSON { response in
                
                
                switch response.result {
                    
                    
                case.Success(let data):
                    
                    self.protocolmain_Catagory.onProgressStatus(0)
                    self.protocolmain_Catagory.onSuccessExecution("API is succesfully Executed")
                    
                    // if let value = response.result.value{
                    
                    // GlobalVarible.Api = "customersyncend"
                    
                    let dataToParse = JSON(data)
                    print(dataToParse)
                    let  ParsedData = NewChangePassword(json: dataToParse)
                    //  self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    print(ParsedData)
                    
                    self.protocolmain_Catagory.onSuccessParse(ParsedData)
                    
                    
                case .Failure(let error):
                    
                    self.protocolmain_Catagory.onerror(String(error), errorCode: error.code )
                    
                    print("Request failed with error: \(error)")
                }
        }
        
        
        
        //   })
        
        
    }
    
    

    




    
    
    
 
}