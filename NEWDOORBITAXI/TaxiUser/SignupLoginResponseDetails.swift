//
//  Details.swift
//
//  Created by AppOrio on 05/04/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class SignupLoginResponseDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsFacebookFirstnameKey: String = "facebook_firstname"
	internal let kDetailsFreeRidesKey: String = "free_rides"
	internal let kDetailsFacebookTokenKey: String = "facebook_token"
	internal let kDetailsGoogleIdKey: String = "google_id"
	internal let kDetailsFacebookImageKey: String = "facebook_image"
	internal let kDetailsTokenCreatedKey: String = "token_created"
	internal let kDetailsRatingKey: String = "rating"
	internal let kDetailsUserImageKey: String = "user_image"
	internal let kDetailsUserNameKey: String = "user_name"
	internal let kDetailsGoogleNameKey: String = "google_name"
	internal let kDetailsFlagKey: String = "flag"
	internal let kDetailsGoogleMailKey: String = "google_mail"
	internal let kDetailsGoogleImageKey: String = "google_image"
	internal let kDetailsDeviceIdKey: String = "device_id"
	internal let kDetailsUserEmailKey: String = "user_email"
	internal let kDetailsCouponCodeKey: String = "coupon_code"
	internal let kDetailsLoginLogoutKey: String = "login_logout"
	internal let kDetailsStatusKey: String = "status"
	internal let kDetailsUserPasswordKey: String = "user_password"
	internal let kDetailsUserPhoneKey: String = "user_phone"
	internal let kDetailsFacebookMailKey: String = "facebook_mail"
	internal let kDetailsEmailVerifiedKey: String = "email_verified"
	internal let kDetailsFacebookIdKey: String = "facebook_id"
	internal let kDetailsRegisterDateKey: String = "register_date"
	internal let kDetailsReferralCodeSendKey: String = "referral_code_send"
	internal let kDetailsFacebookLastnameKey: String = "facebook_lastname"
	internal let kDetailsGoogleTokenKey: String = "google_token"
	internal let kDetailsUserIdKey: String = "user_id"
	internal let kDetailsPhoneVerifiedKey: String = "phone_verified"
	internal let kDetailsPasswordCreatedKey: String = "password_created"
	internal let kDetailsReferralCodeKey: String = "referral_code"


    // MARK: Properties
	public var facebookFirstname: String?
	public var freeRides: String?
	public var facebookToken: String?
	public var googleId: String?
	public var facebookImage: String?
	public var tokenCreated: String?
	public var rating: String?
	public var userImage: String?
	public var userName: String?
	public var googleName: String?
	public var flag: String?
	public var googleMail: String?
	public var googleImage: String?
	public var deviceId: String?
	public var userEmail: String?
	public var couponCode: String?
	public var loginLogout: String?
	public var status: String?
	public var userPassword: String?
	public var userPhone: String?
	public var facebookMail: String?
	public var emailVerified: String?
	public var facebookId: String?
	public var registerDate: String?
	public var referralCodeSend: String?
	public var facebookLastname: String?
	public var googleToken: String?
	public var userId: String?
	public var phoneVerified: String?
	public var passwordCreated: String?
	public var referralCode: String?


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
		facebookFirstname = json[kDetailsFacebookFirstnameKey].string
		freeRides = json[kDetailsFreeRidesKey].string
		facebookToken = json[kDetailsFacebookTokenKey].string
		googleId = json[kDetailsGoogleIdKey].string
		facebookImage = json[kDetailsFacebookImageKey].string
		tokenCreated = json[kDetailsTokenCreatedKey].string
		rating = json[kDetailsRatingKey].string
		userImage = json[kDetailsUserImageKey].string
		userName = json[kDetailsUserNameKey].string
		googleName = json[kDetailsGoogleNameKey].string
		flag = json[kDetailsFlagKey].string
		googleMail = json[kDetailsGoogleMailKey].string
		googleImage = json[kDetailsGoogleImageKey].string
		deviceId = json[kDetailsDeviceIdKey].string
		userEmail = json[kDetailsUserEmailKey].string
		couponCode = json[kDetailsCouponCodeKey].string
		loginLogout = json[kDetailsLoginLogoutKey].string
		status = json[kDetailsStatusKey].string
		userPassword = json[kDetailsUserPasswordKey].string
		userPhone = json[kDetailsUserPhoneKey].string
		facebookMail = json[kDetailsFacebookMailKey].string
		emailVerified = json[kDetailsEmailVerifiedKey].string
		facebookId = json[kDetailsFacebookIdKey].string
		registerDate = json[kDetailsRegisterDateKey].string
		referralCodeSend = json[kDetailsReferralCodeSendKey].string
		facebookLastname = json[kDetailsFacebookLastnameKey].string
		googleToken = json[kDetailsGoogleTokenKey].string
		userId = json[kDetailsUserIdKey].string
		phoneVerified = json[kDetailsPhoneVerifiedKey].string
		passwordCreated = json[kDetailsPasswordCreatedKey].string
		referralCode = json[kDetailsReferralCodeKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if facebookFirstname != nil {
			dictionary.updateValue(facebookFirstname!, forKey: kDetailsFacebookFirstnameKey)
		}
		if freeRides != nil {
			dictionary.updateValue(freeRides!, forKey: kDetailsFreeRidesKey)
		}
		if facebookToken != nil {
			dictionary.updateValue(facebookToken!, forKey: kDetailsFacebookTokenKey)
		}
		if googleId != nil {
			dictionary.updateValue(googleId!, forKey: kDetailsGoogleIdKey)
		}
		if facebookImage != nil {
			dictionary.updateValue(facebookImage!, forKey: kDetailsFacebookImageKey)
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
		if googleName != nil {
			dictionary.updateValue(googleName!, forKey: kDetailsGoogleNameKey)
		}
		if flag != nil {
			dictionary.updateValue(flag!, forKey: kDetailsFlagKey)
		}
		if googleMail != nil {
			dictionary.updateValue(googleMail!, forKey: kDetailsGoogleMailKey)
		}
		if googleImage != nil {
			dictionary.updateValue(googleImage!, forKey: kDetailsGoogleImageKey)
		}
		if deviceId != nil {
			dictionary.updateValue(deviceId!, forKey: kDetailsDeviceIdKey)
		}
		if userEmail != nil {
			dictionary.updateValue(userEmail!, forKey: kDetailsUserEmailKey)
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
		if userPassword != nil {
			dictionary.updateValue(userPassword!, forKey: kDetailsUserPasswordKey)
		}
		if userPhone != nil {
			dictionary.updateValue(userPhone!, forKey: kDetailsUserPhoneKey)
		}
		if facebookMail != nil {
			dictionary.updateValue(facebookMail!, forKey: kDetailsFacebookMailKey)
		}
		if emailVerified != nil {
			dictionary.updateValue(emailVerified!, forKey: kDetailsEmailVerifiedKey)
		}
		if facebookId != nil {
			dictionary.updateValue(facebookId!, forKey: kDetailsFacebookIdKey)
		}
		if registerDate != nil {
			dictionary.updateValue(registerDate!, forKey: kDetailsRegisterDateKey)
		}
		if referralCodeSend != nil {
			dictionary.updateValue(referralCodeSend!, forKey: kDetailsReferralCodeSendKey)
		}
		if facebookLastname != nil {
			dictionary.updateValue(facebookLastname!, forKey: kDetailsFacebookLastnameKey)
		}
		if googleToken != nil {
			dictionary.updateValue(googleToken!, forKey: kDetailsGoogleTokenKey)
		}
		if userId != nil {
			dictionary.updateValue(userId!, forKey: kDetailsUserIdKey)
		}
		if phoneVerified != nil {
			dictionary.updateValue(phoneVerified!, forKey: kDetailsPhoneVerifiedKey)
		}
		if passwordCreated != nil {
			dictionary.updateValue(passwordCreated!, forKey: kDetailsPasswordCreatedKey)
		}
		if referralCode != nil {
			dictionary.updateValue(referralCode!, forKey: kDetailsReferralCodeKey)
		}

        return dictionary
    }

}
