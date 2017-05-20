//
//  Details.swift
//
//  Created by AppOrio on 15/02/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ViewUserDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsPhoneVerifiedKey: String = "phone_verified"
	internal let kDetailsFreeRidesKey: String = "free_rides"
	internal let kDetailsUserPasswordKey: String = "user_password"
	internal let kDetailsUserPhoneKey: String = "user_phone"
	internal let kDetailsFacebookTokenKey: String = "facebook_token"
	internal let kDetailsTokenCreatedKey: String = "token_created"
	internal let kDetailsRatingKey: String = "rating"
	internal let kDetailsUserImageKey: String = "user_image"
	internal let kDetailsUserNameKey: String = "user_name"
	internal let kDetailsFlagKey: String = "flag"
	internal let kDetailsEmailVerifiedKey: String = "email_verified"
	internal let kDetailsGoogleTokenKey: String = "google_token"
	internal let kDetailsReferralCodeSendKey: String = "referral_code_send"
	internal let kDetailsRegisterDateKey: String = "register_date"
	internal let kDetailsDeviceIdKey: String = "device_id"
	internal let kDetailsUserEmailKey: String = "user_email"
	internal let kDetailsUserIdKey: String = "user_id"
	internal let kDetailsCouponCodeKey: String = "coupon_code"
	internal let kDetailsLoginLogoutKey: String = "login_logout"
	internal let kDetailsStatusKey: String = "status"
	internal let kDetailsReferralCodeKey: String = "referral_code"
	internal let kDetailsPasswordCreatedKey: String = "password_created"


    // MARK: Properties
	public var phoneVerified: String?
	public var freeRides: String?
	public var userPassword: String?
	public var userPhone: String?
	public var facebookToken: String?
	public var tokenCreated: String?
	public var rating: String?
	public var userImage: String?
	public var userName: String?
	public var flag: String?
	public var emailVerified: String?
	public var googleToken: String?
	public var referralCodeSend: String?
	public var registerDate: String?
	public var deviceId: String?
	public var userEmail: String?
	public var userId: String?
	public var couponCode: String?
	public var loginLogout: String?
	public var status: String?
	public var referralCode: String?
	public var passwordCreated: String?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		phoneVerified = json[kDetailsPhoneVerifiedKey].string
		freeRides = json[kDetailsFreeRidesKey].string
		userPassword = json[kDetailsUserPasswordKey].string
		userPhone = json[kDetailsUserPhoneKey].string
		facebookToken = json[kDetailsFacebookTokenKey].string
		tokenCreated = json[kDetailsTokenCreatedKey].string
		rating = json[kDetailsRatingKey].string
		userImage = json[kDetailsUserImageKey].string
		userName = json[kDetailsUserNameKey].string
		flag = json[kDetailsFlagKey].string
		emailVerified = json[kDetailsEmailVerifiedKey].string
		googleToken = json[kDetailsGoogleTokenKey].string
		referralCodeSend = json[kDetailsReferralCodeSendKey].string
		registerDate = json[kDetailsRegisterDateKey].string
		deviceId = json[kDetailsDeviceIdKey].string
		userEmail = json[kDetailsUserEmailKey].string
		userId = json[kDetailsUserIdKey].string
		couponCode = json[kDetailsCouponCodeKey].string
		loginLogout = json[kDetailsLoginLogoutKey].string
		status = json[kDetailsStatusKey].string
		referralCode = json[kDetailsReferralCodeKey].string
		passwordCreated = json[kDetailsPasswordCreatedKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if phoneVerified != nil {
			dictionary.updateValue(phoneVerified!, forKey: kDetailsPhoneVerifiedKey)
		}
		if freeRides != nil {
			dictionary.updateValue(freeRides!, forKey: kDetailsFreeRidesKey)
		}
		if userPassword != nil {
			dictionary.updateValue(userPassword!, forKey: kDetailsUserPasswordKey)
		}
		if userPhone != nil {
			dictionary.updateValue(userPhone!, forKey: kDetailsUserPhoneKey)
		}
		if facebookToken != nil {
			dictionary.updateValue(facebookToken!, forKey: kDetailsFacebookTokenKey)
		}
		if tokenCreated != nil {
			dictionary.updateValue(tokenCreated!, forKey: kDetailsTokenCreatedKey)
		}
		if rating != nil {
			dictionary.updateValue(rating!, forKey: kDetailsRatingKey)
		}
		if userImage != nil {
			dictionary.updateValue(userImage!, forKey: kDetailsUserImageKey)
		}
		if userName != nil {
			dictionary.updateValue(userName!, forKey: kDetailsUserNameKey)
		}
		if flag != nil {
			dictionary.updateValue(flag!, forKey: kDetailsFlagKey)
		}
		if emailVerified != nil {
			dictionary.updateValue(emailVerified!, forKey: kDetailsEmailVerifiedKey)
		}
		if googleToken != nil {
			dictionary.updateValue(googleToken!, forKey: kDetailsGoogleTokenKey)
		}
		if referralCodeSend != nil {
			dictionary.updateValue(referralCodeSend!, forKey: kDetailsReferralCodeSendKey)
		}
		if registerDate != nil {
			dictionary.updateValue(registerDate!, forKey: kDetailsRegisterDateKey)
		}
		if deviceId != nil {
			dictionary.updateValue(deviceId!, forKey: kDetailsDeviceIdKey)
		}
		if userEmail != nil {
			dictionary.updateValue(userEmail!, forKey: kDetailsUserEmailKey)
		}
		if userId != nil {
			dictionary.updateValue(userId!, forKey: kDetailsUserIdKey)
		}
		if couponCode != nil {
			dictionary.updateValue(couponCode!, forKey: kDetailsCouponCodeKey)
		}
		if loginLogout != nil {
			dictionary.updateValue(loginLogout!, forKey: kDetailsLoginLogoutKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kDetailsStatusKey)
		}
		if referralCode != nil {
			dictionary.updateValue(referralCode!, forKey: kDetailsReferralCodeKey)
		}
		if passwordCreated != nil {
			dictionary.updateValue(passwordCreated!, forKey: kDetailsPasswordCreatedKey)
		}

        return dictionary
    }

}
