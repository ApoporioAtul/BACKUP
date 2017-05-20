//
//  API_URLs.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 22/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//


    
    public class API_URLs {
        
        public static var basedomain = "http://apporio.org/doorbi/api/"
        public static var imagedomain = "http://apporio.org/doorbi/"
      // http://apporio.co.uk/apporiotaximulti/
        public static var Register = basedomain + "register_driver.php?driver_email="
        public static var register2 = basedomain + "register_driver_docs.php?driver_id="
       // public static var registerTesting = basedomain + "register_driver_testing.php?driver_email="
        public static var documentType = basedomain + "document_type.php?"
        public static var loginMobile = basedomain + "login_driver.php?driver_email_phone="
        public static var ChangePassword = basedomain + "change_password_driver.php?driver_id="
        public static var forgotpassword = basedomain + "forgot_password_driver.php?driver_email="
        public static var Editprofile = basedomain + "edit_profile_driver.php?"
        public static var viewProfile = basedomain + "view_profile_driver.php?driver_id="
        public static var GoOnline = basedomain + "online_offline.php?driver_id="
        public static var logoutDriver = basedomain + "logout_driver.php?driver_id="
        public static var ViewUserInfo = basedomain + "view_user_info.php?user_id="
        
        public static var DriverHome = basedomain + "driver_latlong.php?driver_id="
        public static var DriverArrived = basedomain + "ride_arrived.php?ride_id="
        public static var RideEnd = basedomain + "ride_end.php?ride_id="
        public static var RideBegin = basedomain + "ride_start.php?ride_id="
        public static var UpdateDriverLocation = basedomain + "ride_lat_long.php?ride_id="
        public static var trackRide = basedomain + "track_latlong.php?ride_id="
        
        public static var AddDeviceID = basedomain + "deviceid_driver.php?driver_id="
        
        public static var ViewRideInfo = basedomain + "view_ride_info_driver.php?ride_id="
        public static var AcceptRide = basedomain + "ride_accept.php?ride_id="
        public static var RejectRide = basedomain + "ride_reject.php?ride_id="
        
        public static var RateCustomer = basedomain + "rating_driver.php?driver_id="
        
        
        public static var TermsAndConditions = basedomain + "tc.php?"
        public static var Aboutus = basedomain + "about.php?"
        
        public static var ViewcarModels = basedomain + "car_model.php?car_type_id="
        
        public static var ViewCity = basedomain + "city.php?"

        
        public static var Viewcars = basedomain + "car_by_city.php?city="
        public static var callSupport = basedomain + "call_support.php?"
        public static var yourride = basedomain + "view_rides_driver.php?driver_id="
        public static var driverearning = basedomain + "driver_earnings.php?driver_id="
        
        public static var drivercancelreason = basedomain + "cancel_reason_driver.php?"
        
        public static var Cancelbydriver = basedomain + "ride_cancel_driver.php?ride_id="
        
        public static var driversync = basedomain + "new_ride_sync.php?ride_id="
        
        public static var customersupport = basedomain + "customer_support.php?driver_id="

}