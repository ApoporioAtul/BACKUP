//
//  APIManager.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 23/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

//
//  APIManager.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 23/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import SwiftyJSON
import Alamofire


protocol ParsingStates {
    
    
    func onProgressState(value: Int)
    
    func onErrorsState(message: String , errorCode: Int)
    
    func onSuccessState(data: AnyObject , resultCode: Int)
    
}

class APIManager
    
{
    
    let qualityOfServiceClass = QOS_CLASS_BACKGROUND
    
    
    static let sharedInstance = APIManager()
    var delegate : ParsingStates! = nil
    
    
    
//     ************************ View Car Models API Parsing *********************************
    
    
    func viewCarModels(carTypeid: String)
        
    {
        
        var url = ""
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
        
         url =  (API_URLs.ViewcarModels + carTypeid + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
            
        }else{
            url =  (API_URLs.ViewcarModels + carTypeid + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")

        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print("Car Models Url ***************  \(url1)")
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(CarModel(json: JSON(data)) , resultCode: 11)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
            
        })
        
        
    }
    
    // ************************ View CarType API Parsing *********************************
    
    func viewCarType(cityname: String)
        
    {
        var url = ""
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.Viewcars + cityname + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
         url =  (API_URLs.Viewcars + cityname + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Car Type Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(CarType(json: JSON(data)) , resultCode: 22)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    
    
    func viewcityType()
        
    {
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.ViewCity + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
            
        }else{
            url =  (API_URLs.ViewCity + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Car Type Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(CityTypeModel(json: JSON(data)) , resultCode: 1003)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    

    
    // ************************ Register API Parsing *********************************
    
    
    func registerDriver(email: String , phone: String , pass: String , name: String , cartype_id: String ,  carmodelId: String , carnumber: String , cityid: String)
    {
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

          url =  (API_URLs.Register + email + "&driver_phone=" + phone + "&driver_password=" + pass + "&driver_name=" + name + "&car_type_id=" + cartype_id + "&car_model_id=" + carmodelId + "&car_number=" + carnumber + "&city_id=" + cityid + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        
        url =  (API_URLs.Register + email + "&driver_phone=" + phone + "&driver_password=" + pass + "&driver_name=" + name + "&car_type_id=" + cartype_id + "&car_model_id=" + carmodelId + "&car_number=" + carnumber + "&city_id=" + cityid + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Register Url ***************  \(url1)")
        
        self.delegate.onProgressState(0)
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.POST, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(RegisterDriver(json: JSON(data)) , resultCode: 33)
                        
                        if(RegisterDriver(json: JSON(data)).result == 1){
                            self.sendDeviceId()
                        }else if (RegisterDriver(json: JSON(data)).result == 0){
                            print("unable to send device id because of login state equal to 0")
                        }
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    
    
    
    func uploaddriverdocument(driverId: String, InsuranceImage: UIImage,LicenseImage: UIImage,RCImage : UIImage)
    {
       var URL = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

       URL = API_URLs.register2 + driverId + "&language_id=" + "1"
            
        }else{
            URL = API_URLs.register2 + driverId + "&language_id=" + "2"

        
        }
        
        Alamofire.upload(.POST, URL, multipartFormData: { MultipartFormData in
            
            
            if  let imageData = UIImageJPEGRepresentation(InsuranceImage, 0.5) {
                MultipartFormData.appendBodyPart(data: imageData, name: "insurance", fileName: "file.png", mimeType: "image/png")
            }
            
            if  let imageData1 = UIImageJPEGRepresentation(LicenseImage, 0.5) {
                MultipartFormData.appendBodyPart(data: imageData1, name: "license", fileName: "file.png", mimeType: "image/png")
            }

            
            if  let imageData2 = UIImageJPEGRepresentation(RCImage, 0.5) {
                MultipartFormData.appendBodyPart(data: imageData2, name: "rc", fileName: "file.png", mimeType: "image/png")
            }

            
            self.delegate.onProgressState(0)
            
                        
          /* for (key, value) in parameters {
                
                print("Key is: \(key)")
                print("Value is: \(value)")
                MultipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }*/
            
            
            },encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    
                case .Success(let data , _ , _) :
                    
                    data.responseJSON { response in
                        print("Url is: \(URL)")
                        print("Response is: \(response)")
                        
                        
                        self.delegate.onProgressState(1)
                        
                        if let DATA =  response.result.value
                            
                        {
                            print(DATA)
                            
                            self.delegate.onSuccessState(RegisterDriver(json: JSON(DATA)), resultCode: 1004)
                            
                        }
                        
                    }
                    
                case .Failure(let error):
                    
                    //self.delegate.onErrorsState(String(error), errorCode: 90)
                    
                    print("Request failed with error: \(error)")
                }
                
        })
        
        
    }
    
    
    
    // ************************ Login API Parsing *********************************
    
    
    
    func loginDriver(emailPhone: String , password: String)
        
    {
        
        var url = ""
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.loginMobile + emailPhone + "&driver_password=" + password + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
            
        }else{
            url =  (API_URLs.loginMobile + emailPhone + "&driver_password=" + password + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")

        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print("Login Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.POST, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(RegisterDriver(json: JSON(data)) , resultCode: 44)
                        
                        if(RegisterDriver(json: JSON(data)).result == 1){
                            self.sendDeviceId()
                        }else if (RegisterDriver(json: JSON(data)).result == 0){
                            print("unable to send device id because of login state equal to 0")
                        }
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    // ************************ Device Id Parsing *********************************
    
    func sendDeviceId()
    {
        
        let driverid: String  = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverid)!
     let deviceid: String  =  NSUserDefaults.standardUserDefaults().valueForKey("device_key")! as! String
    
                                   
        let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
         var url = ""
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

            
         url = API_URLs.AddDeviceID + driverid  + "&device_id=" + deviceid  + "&flag=" + "1" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1"
            
        }
        else{
        
            url = API_URLs.AddDeviceID + driverid  + "&device_id=" + deviceid  + "&flag=" + "1" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2"

        
        }
            print("sending device token *****************  \(url)")
        
        
        Alamofire.request(.GET, url)
            .validate()
            .responseJSON { response in
                // debugPrint(response)
                print (response)
                
                
                
                switch response.result {
                    
                case .Success(let data):
                    
                    
                    let datatoparse  =  JSON(data)
                    print("data after executing device id API  \(datatoparse)")
                case .Failure(let error):
                    
                    self.delegate.onErrorsState(String(error), errorCode: error.code)
                    
                }
                
        }
        
    }
    
    
    // ************************ Edit Profile Parsing *********************************
    
    
    
    
    func uploadRequest(parameters: [String: String] , driverImage: UIImage)
    {
        var URL = ""
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

             URL = API_URLs.Editprofile + "&language_id=" + "1"
            
        }else{
        
         URL = API_URLs.Editprofile + "&language_id=" + "2"
        }
        
        Alamofire.upload(.POST, URL, multipartFormData: { MultipartFormData in
            
            
         if  let imageData = UIImageJPEGRepresentation(driverImage, 0.5) {
                MultipartFormData.appendBodyPart(data: imageData, name: "driver_image", fileName: "file.png", mimeType: "image/png")
            }   
            
            self.delegate.onProgressState(0)
            
            for (key, value) in parameters {
                
                print("Key is: \(key)")
                print("Value is: \(value)")
                MultipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            
            },encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    
                case .Success(let data , _ , _) :
                    
                    data.responseJSON { response in
                        print("Url is: \(URL)")
                         print("Response is: \(response)")
                        
                        
                        self.delegate.onProgressState(1)
                        
                        if let DATA =  response.result.value
                            
                        {
                            print(DATA)
                            
                            self.delegate.onSuccessState(ViewProfile(json: JSON(DATA)), resultCode: 55)
                            
                        }
                        
                    }
                    
                case .Failure(let error):
                    
                    //self.delegate.onErrorsState(String(error), errorCode: 90)
                    
                    print("Request failed with error: \(error)")
                }
                
        })
        
        
    }
    
    
    // ************************ Change Password Parsing *********************************
    
    
    func changePassword(driverid: String , oldPwd: String , newPwd: String)
        
    {
        
         let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
        
        var url = ""
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.ChangePassword + driverid + "&old_password=" + oldPwd + "&new_password=" + newPwd + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        else{
        url =  (API_URLs.ChangePassword + driverid + "&old_password=" + oldPwd + "&new_password=" + newPwd + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Change Password Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.POST, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(ChangePassword(json: JSON(data)) , resultCode: 66)
                        
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    
    func forgotPassword(driveremail: String)
        
    {
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.forgotpassword + driveremail + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
          url =  (API_URLs.forgotpassword + driveremail + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Forgot Password Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(ForgotPassword(json: JSON(data)) , resultCode: 77)
                        
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    //   ************************ Online/Offline Parsing *********************************
    
    
    func goOnline(driverid: String , onlineOffline: String,  driverToken: String)
        
    {
        var url = ""
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.GoOnline + driverid + "&online_offline=" + onlineOffline + "&driver_token=" + driverToken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
         url =  (API_URLs.GoOnline + driverid + "&online_offline=" + onlineOffline + "&driver_token=" + driverToken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Online/Offline Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(OnLineOffline(json: JSON(data)) , resultCode: 88)
                        
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    // ************************ About US Parsing *********************************
    
    
    func aboutUs()
        
    {
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        url =  (API_URLs.Aboutus + "language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
          url =  (API_URLs.Aboutus + "language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print("About us Url ***************  \(url1)")
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(AboutUs(json: JSON(data)) , resultCode: 99)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
            
        })
        
        
    }
    
    // ************************ About US Parsing *********************************
    
    
    func tc()
        
    {
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
       url =  (API_URLs.TermsAndConditions + "language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
            url =  (API_URLs.TermsAndConditions + "language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")

        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print("Terms And Conditions Url ***************  \(url1)")
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(TCClass(json: JSON(data)) , resultCode: 110)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
            
        })
        
        
    }

    
    // ************************ Document Type Parsing *********************************
    
    
    func docType()
        
    {
        
        let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.documentType + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        else{
            url =  (API_URLs.documentType + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")

        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Document Type Url ***************  \(url1)")
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(DocumentType(json: JSON(data)) , resultCode: 231)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
        })
        
    }
    
    
    // ************************ Driver Home Parsing *********************************
    
    
    func goDriverHome(driverid: String , currentLat: String , currentLong: String, currentLoc: String,driverToken: String)
        
    {
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.DriverHome + driverid + "&current_lat=" + currentLat + "&current_long=" + currentLong + "&current_location=" + currentLoc + "&driver_token=" + driverToken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
         url =  (API_URLs.DriverHome + driverid + "&current_lat=" + currentLat + "&current_long=" + currentLong + "&current_location=" + currentLoc + "&driver_token=" + driverToken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Driver Home Url ***************  \(url)")
        
        
      //  self.delegate.onProgressState(0)
        
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                //self.delegate.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    
                    
                    let dataToParse = JSON(value)
                    print(dataToParse)
                    let  ParsedData = DriverHome(json: dataToParse)
                   // self.delegate.onProgressState(1)
                    self.delegate.onSuccessState(ParsedData, resultCode: 121)
                }
        }
        
        
    }
    
    
    
    func ContactApi()-> JSON{
        
        
        var dataToParse:JSON=nil
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
        url = API_URLs.callSupport + "language_id=" + "1"
        }
        else{
        
         url = API_URLs.callSupport + "language_id=" + "2"
        }
        
        var finishFlag = 0
        Alamofire.request(.GET , url)
            
            .responseJSON { response in
                
                
                if let value = response.result.value{
                    dataToParse = JSON(value)
                    finishFlag = 1
                    
                    
                    GlobalVariables.contactTelephone  =  value["details"]!!["desc"] as! String
                    
                    
                    
                }
                
        }
        
        while finishFlag == 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
        }
        
        
        
        return dataToParse
        
    }
    
    
    // ************************ View UserInfo Parsing *********************************
    
    func viewUserInfo(userid: String)
        
    {
        
        
        let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.ViewUserInfo + userid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
            
        }else{
          url =  (API_URLs.ViewUserInfo + userid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        print("User Info Url ***************  \(url)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(ViewUser(json: JSON(data)) , resultCode: 132)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    // ************************ View RideInfo Parsing *********************************
    
    func viewRideInfo(rideid: String)
        
    {
        
        let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.ViewRideInfo + rideid  + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        url =  (API_URLs.ViewRideInfo + rideid  + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print("Ride info Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(ViewRide(json: JSON(data)) , resultCode: 143)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    
    // ************************ Rate Customer Parsing *********************************
    
    func rateCustomer( driverid: String ,customerid: String , rating: String , comment: String,RideId: String)
        
    {
        let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        url =  (API_URLs.RateCustomer + driverid + "&user_id=" + customerid + "&rating_star=" + rating + "&comment=" + comment + "&driver_token=" + defaultdrivertoken + "&ride_id=" + RideId + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        
          url =  (API_URLs.RateCustomer + driverid + "&user_id=" + customerid + "&rating_star=" + rating + "&comment=" + comment + "&driver_token=" + defaultdrivertoken + "&ride_id=" + RideId + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print("Rate Customer Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(RateCustomer(json: JSON(data)) , resultCode: 154)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    // ************************ Accept Ride Parsing *********************************
    
    func acceptRide(rideid: String , driverid: String)
        
    {
        
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.AcceptRide + rideid + "&driver_id=" + driverid + "&ride_status=" + "3" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        url =  (API_URLs.AcceptRide + rideid + "&driver_id=" + driverid + "&ride_status=" + "3" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Ride Accept Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(RideAccept(json: JSON(data)) , resultCode: 165)
                        
                        
                        
                    case .Failure(let error):
                        
                        //self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    // ************************ Reject Ride Parsing *********************************
    
    func rejectRide(rideid: String , driverid: String)
        
    {
        
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.RejectRide + rideid + "&driver_id=" + driverid + "&ride_status=" + "4" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
            
        }
        else{
            url =  (API_URLs.RejectRide + rideid + "&driver_id=" + driverid + "&ride_status=" + "4" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
            

        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Ride Reject Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(RideReject(json: JSON(data)) , resultCode: 176)
                        
                        
                    case .Failure(let error):
                        
                       // self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
        })
        
    }
    
    
    // ************************ Logout Parsing *********************************
    
    
    
    func logOut(driverid: String)
        
    {
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.logoutDriver + driverid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
         url =  (API_URLs.logoutDriver + driverid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("LogOut Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(LogOut(json: JSON(data)) , resultCode: 187)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
        })
        
    }
    
    
    
    // ************************  Driver Arrived Parsing *********************************
    
    
    
    func driverArrived(rideid: String , driverid: String , arrTime: String)
        
    {
        
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.DriverArrived + rideid + "&driver_id=" + driverid + "&arrived_time=" + arrTime + "&ride_status=" + "5" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        else{
        
            url =  (API_URLs.DriverArrived + rideid + "&driver_id=" + driverid + "&arrived_time=" + arrTime + "&ride_status=" + "5" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")

        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print(" Driver Arrived Url ***************  \(url1)")
        

        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(Arrived(json: JSON(data)) , resultCode: 198)
                        
                        
                    case .Failure(let error):
                        
                        //self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
        })

        
    }
    
    
    
    func rideEnd( rideId: String , bLat: String , bLong: String , bLocation: String , eLat: String , eLong: String , eLocation: String , eTime: String , driverid: String ,  waitingTime: String , rideTime: String , dist: String)
        
    {
        
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.RideEnd + rideId  + "&begin_lat=" + bLat + "&begin_long=" + bLong + "&begin_location=" + bLocation + "&end_lat=" + eLat + "&end_long=" + eLong + "&end_location=" + eLocation + "&end_time=" + eTime + "&driver_id=" + driverid + "&ride_status=" + "7" + "&waiting_time=" + waitingTime + "&ride_time=" + rideTime + "&distance=" + dist + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1")
        }else{
          url =  (API_URLs.RideEnd + rideId  + "&begin_lat=" + bLat + "&begin_long=" + bLong + "&begin_location=" + bLocation + "&end_lat=" + eLat + "&end_long=" + eLong + "&end_location=" + eLocation + "&end_time=" + eTime + "&driver_id=" + driverid + "&ride_status=" + "7" + "&waiting_time=" + waitingTime + "&ride_time=" + rideTime + "&distance=" + dist + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2")
        
        }
        print(" Ride End Url ***************  \(url)")
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        self.delegate.onProgressState(0)
        
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                //self.delegate.onSuccessExecution("API is succesfully Executed")
                
                if let value = response.result.value{
                    
                    
                    let dataToParse = JSON(value)
                    print(dataToParse)
                    let  ParsedData = RideEnd(json: dataToParse)
                    self.delegate.onProgressState(1)
                    self.delegate.onSuccessState(ParsedData, resultCode: 209)
                }
        }
    

    }
    
    
    func rideBegin(rideid: String ,bLat: String , bLong: String , bLocation: String , bTime: String , driverId: String)
        
    {
        
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
        
         url =  (API_URLs.RideBegin + rideid + "&begin_lat=" + bLat + "&begin_long=" + bLong + "&begin_location=" + bLocation + "&begin_time=" + bTime + "&driver_id=" + driverId + "&ride_status=" + "6" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1")
        }else{
          url =  (API_URLs.RideBegin + rideid + "&begin_lat=" + bLat + "&begin_long=" + bLong + "&begin_location=" + bLocation + "&begin_time=" + bTime + "&driver_id=" + driverId + "&ride_status=" + "6" + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2")
        
        }
       
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
         print(" Ride Begin Url ***************  \(url1)")
        
        self.delegate.onProgressState(0)
        
        Alamofire.request(.GET , url1)
            .responseJSON { response in
                
                
                
                if let value = response.result.value{
                    
                    
                    let dataToParse = JSON(value)
                    print(dataToParse)
                    let  ParsedData = RideBegin(json: dataToParse)
                    self.delegate.onProgressState(1)
                    self.delegate.onSuccessState(ParsedData, resultCode: 220)
                }
                
        }
    }
    
    
    
    
    func viewProfile(driverid: String)
        
    {
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

       url =  (API_URLs.viewProfile + driverid + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        
        url =  (API_URLs.viewProfile + driverid + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("view profile url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.POST, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(ViewProfile(json: JSON(data)) , resultCode: 242)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }

    
    // ************************ Track ride to calculate distance ****************************
    
    
    
        func trackRide(tripid: String , driverid: String , driverLat: String , driverLong: String)
    
        {
            
              let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
            var url = ""
            if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

             url =  (API_URLs.trackRide + tripid + "&driver_id=" + driverid + "&driver_lat=" + driverLat + "&driver_long=" + driverLong + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
            }else{
            
                url =  (API_URLs.trackRide + tripid + "&driver_id=" + driverid + "&driver_lat=" + driverLat + "&driver_long=" + driverLong + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
            }
            let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            print("Ride track to calculate distance Url ***************  \(url1)")
    
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
    
            dispatch_async(backgroundQueue, {
    
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                   // self.delegate.onProgressState(0)
    
                })
    
    
                Alamofire.request(.GET, url1
                    )
                    .validate()
                    .responseJSON { response in
                        // debugPrint(response)
    
                        switch response.result {
    
                        case .Success(let data):
    
                            print(response)
                         //   self.delegate.onProgressState(1)
                            self.delegate.onSuccessState(TrackRide(json: JSON(data)) , resultCode: 253)
    
    
                        case .Failure(let error):
    
                            self.delegate.onErrorsState(String(error), errorCode: error.code)
    
                            print("Request failed with error: \(error)")
                        }
    
                }
    
            })
    
        }
    
    
    
    // ************************ Update driver location ****************************
    
    
    
    func updateDriverLocation(tripid: String , driverid: String , userid: String , driverLat: String , driverLong: String)
        
    {
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
         url =  (API_URLs.UpdateDriverLocation + tripid + "&driver_id=" + driverid + "&user_id=" + userid + "&driver_lat=" + driverLat + "&driver_long=" + driverLong + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        url =  (API_URLs.UpdateDriverLocation + tripid + "&driver_id=" + driverid + "&user_id=" + userid + "&driver_lat=" + driverLat + "&driver_long=" + driverLong + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print("Update driver location url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
             //   self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                       // self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(UpdateDriverLocation(json: JSON(data)) , resultCode: 264)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
            }
            
        })
        
    }
    
    
    
    
    func ShowAllRides( driverid: String){
        
        
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
        url =  (API_URLs.yourride + driverid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        
         url =  (API_URLs.yourride + driverid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("view profile url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.POST, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(AllRides(json: JSON(data)) , resultCode: 1001)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        

    }
    
    
    
    func DriverEarning( driverid: String){
        
          let defaultdrivertoken = NsUserDefaultManager.SingeltonInstance.getuserdetails(NsUserDefaultManager.KeyDriverToken)!
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
       url =  (API_URLs.driverearning + driverid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
        
         url =  (API_URLs.driverearning + driverid + "&driver_token=" + defaultdrivertoken + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("view profile url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.POST, url1)
                .validate()
                .responseJSON { response in
                    
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(DriverEarningModel(json: JSON(data)) , resultCode: 1002)
                        
                        
                    case .Failure(let error):
                        
                        self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
        
    }

    func reasonCancel()
        
    {
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

         url =  (API_URLs.drivercancelreason + "language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }
        else{
         url =  (API_URLs.drivercancelreason + "language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        print("Reason Cancel Url ***************  \(url1)")
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(ReasonModel(json: JSON(data)) , resultCode: 1005)
                        
                        
                        
                    case .Failure(let error):
                        
                        //self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    func CancelDriver(RIDEID: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){

        
        url =  (API_URLs.Cancelbydriver + RIDEID + "&ride_status=" + "9" + "&reason_id=" + GlobalVariables.cancelId + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
            
            url =  (API_URLs.Cancelbydriver + RIDEID + "&ride_status=" + "9" + "&reason_id=" + GlobalVariables.cancelId + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
        
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(CancelRideModel(json: JSON(data)) , resultCode: 1006)
                        
                        
                    case .Failure(let error):
                        
                        //self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
    
    func DriverSync(RIDEID: String,DriverId: String){
        
        var url = ""
        if(NSUserDefaults.standardUserDefaults().objectForKey("PreferredLanguage") as! String == "en"){
            
            
            url =  (API_URLs.driversync + RIDEID + "&driver_id=" + DriverId + "&language_id=" + "1").stringByReplacingOccurrencesOfString("", withString: "%20")
        }else{
            
            url =  (API_URLs.driversync + RIDEID + "&driver_id=" + DriverId + "&language_id=" + "2").stringByReplacingOccurrencesOfString("", withString: "%20")
            
        }
        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url1)
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(DriverSyncModel(json: JSON(data)) , resultCode: 2006)
                        
                        
                    case .Failure(let error):
                        
                        //self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }
    
// 4&name=1&email=12&phone=&query=hello

    
    func CustomerSupportApi(DriverId: String,Name: String,Email: String,Phone: String,Query: String){
        
        
      let  url =  (API_URLs.customersupport + DriverId + "&name=" + Name + "&email=" + Email + "&phone=" + Phone + "&query=" + Query).stringByReplacingOccurrencesOfString("", withString: "%20")

        
        let url1 = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        print(url1)
        
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate.onProgressState(0)
                
            })
            
            
            Alamofire.request(.GET, url1
                )
                .validate()
                .responseJSON { response in
                    // debugPrint(response)
                    
                    switch response.result {
                        
                    case .Success(let data):
                        
                        print(response)
                        self.delegate.onProgressState(1)
                        self.delegate.onSuccessState(CustomerSupportModel(json: JSON(data)) , resultCode: 5555)
                        
                        
                    case .Failure(let error):
                        
                        //self.delegate.onErrorsState(String(error), errorCode: error.code)
                        
                        print("Request failed with error: \(error)")
                    }
                    
                    
                    
            }
            
            
        })
        
    }

    
    
    
    
    
}