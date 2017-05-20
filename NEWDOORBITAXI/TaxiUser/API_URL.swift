//
//  API_URL.swift
//  IZYCAB
//
//  Created by AppOrio on 23/02/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import Foundation


public class API_URL {
    
    public static var basedomain = "http://apporio.org/doorbi/api/"
    public static var imagedomain = "http://apporio.org/doorbi/"
    
    public static var Register = basedomain + "register_user.php?user_name="
   // public static var register2 = basedomain + "register_driver_docs.php?driver_id="
    // public static var registerTesting = basedomain + "register_driver_testing.php?driver_email="
    public static var verifyphone = basedomain + "phone.php?user_phone="
    public static var getotp = basedomain + "otp_sent.php?user_phone="
    public static var createpassword = basedomain + "create_password.php?user_phone="
    public static var socialtoken = basedomain + "send_social_token.php?social_token="
    public static var socialregister = basedomain + "register_user_google.php?social_token="
    public static var getcoupon = basedomain + "coupon.php?coupon_code="
     public static var Viewcars = basedomain + "car_by_city.php?city="
    
    public static var viewcarswithtime = basedomain + "car_type.php?city="
    public static var loginuser = basedomain + "login_user.php?user_email_phone="
    public static var forgetpassword = basedomain + "forgot_password_user.php?user_email="
    
    public static var changepassword = basedomain + "change_password_user.php?user_id="
    public static var EditProfile = basedomain + "edit_profile_user.php?language_id="
     public static var ViewCity = basedomain + "city.php?language_id="
    public static var viewdriverlocation = basedomain + "view_driver.php?car_type_id="
    public static var viewrides = basedomain + "view_rides_user.php?user_id="
     public static var Aboutus = basedomain + "about.php?language_id="
     public static var TermsAndConditions = basedomain + "tc.php?language_id="
     public static var callSupport = basedomain + "call_support.php?language_id="
    public static var ratecard = basedomain + "rate_card_city.php?city="
    public static var rideestimate = basedomain + "ride_estimate.php?distance="
    
    public static var RideNow = basedomain + "ride_now.php?user_id="
    
    public static var RideLater = basedomain + "ride_later.php?user_id="
    public static var Cancelbyuser = basedomain + "ride_cancel.php?ride_id="
    public static var DeviceId = basedomain + "deviceid_user.php?user_id="
    public static var driverdetails = basedomain + "view_ride_info_user.php?ride_id="
    
    public static var viewdonerideinfo = basedomain + "view_done_ride_info.php?done_ride_id="
    
    
    public static var trackride = basedomain + "view_driver_location.php?ride_id="
   
    
    public static var userrating = basedomain + "rating_user.php?user_id="
    public static var confirmpayment = basedomain + "payment_saved.php?order_id="
    
    public static var logoutuser = basedomain + "logout_user.php?user_id="
    public static var cancelreasonuser = basedomain + "cancel_reason_customer.php?language_id="
    
    public static var sendinvoice = basedomain + "resend_invoice.php?ride_id="
    
    public static var savecard = basedomain + "save_card.php?user_id="
    
    public static var viewcard = basedomain + "view_card.php?user_id="
        
    public static var deletecard = basedomain + "delete_card.php?card_id="
    
    public static var paycard = basedomain + "pay_with_card.php?ride_id="
    
    public static var viewpaymentoption = basedomain + "view_payment_option.php?language_id="
    
    public static var customersync = basedomain + "customer_sync.php?ride_id="
    
    public static var customersyncend = basedomain + "customer_sync_end.php?ride_id="
    
     public static var cancelride60sec = basedomain + "cancel_ride_user.php?ride_id="
    
    
    
    

    

    
    
}