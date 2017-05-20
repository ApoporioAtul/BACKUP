//
//  Details.swift
//
//  Created by Rakesh kumar on 19/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Details: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.


    
    internal let kDetailsRcKey: String = "rc"
    internal let kDetailsInsuranceKey: String = "insurance"
    internal let kDetailsLastUpdateKey: String = "last_update"
    internal let kDetailsRejectRidesKey: String = "reject_rides"
    internal let kDetailsRatingKey: String = "rating"
    internal let kDetailsDriverEmailKey: String = "driver_email"
    internal let kDetailsDriverImageKey: String = "driver_image"
    internal let kDetailsCarModelNameKey: String = "car_model_name"
    internal let kDetailsFlagKey: String = "flag"
    internal let kDetailsDriverNameKey: String = "driver_name"
    internal let kDetailsCancelledRidesKey: String = "cancelled_rides"
    internal let kDetailsDeviceIdKey: String = "device_id"
    internal let kDetailsLoginLogoutKey: String = "login_logout"
    internal let kDetailsCompletedRidesKey: String = "completed_rides"
    internal let kDetailsStatusKey: String = "status"
    internal let kDetailsBusyKey: String = "busy"
    internal let kDetailsCarModelIdKey: String = "car_model_id"
    internal let kDetailsCarTypeNameKey: String = "car_type_name"
    internal let kDetailsCurrentLocationKey: String = "current_location"
    internal let kDetailsDriverIdKey: String = "driver_id"
    internal let kDetailsDetailStatusKey: String = "detail_status"
    internal let kDetailsCarNumberKey: String = "car_number"
    internal let kDetailsLicenseKey: String = "license"
    internal let kDetailsLastUpdateDateKey: String = "last_update_date"
    internal let kDetailsDriverTokenKey: String = "driver_token"
    internal let kDetailsRegisterDateKey: String = "register_date"
    internal let kDetailsCurrentLatKey: String = "current_lat"
    internal let kDetailsCurrentLongKey: String = "current_long"
    internal let kDetailsDriverPhoneKey: String = "driver_phone"
    internal let kDetailsOnlineOfflineKey: String = "online_offline"
    internal let kDetailsCarTypeIdKey: String = "car_type_id"
    internal let kDetailsCityIdKey: String = "city_id"
    internal let kDetailsDriverPasswordKey: String = "driver_password"
    internal let kDetailsOtherDocsKey: String = "other_docs"
    
    
    // MARK: Properties
    public var rc: String?
    public var insurance: String?
    public var lastUpdate: String?
    public var rejectRides: String?
    public var rating: String?
    public var driverEmail: String?
    public var driverImage: String?
    public var carModelName: String?
    public var flag: String?
    public var driverName: String?
    public var cancelledRides: String?
    public var deviceId: String?
    public var loginLogout: String?
    public var completedRides: String?
    public var status: String?
    public var busy: String?
    public var carModelId: String?
    public var carTypeName: String?
    public var currentLocation: String?
    public var driverId: String?
    public var detailStatus: String?
    public var carNumber: String?
    public var license: String?
    public var lastUpdateDate: String?
    public var driverToken: String?
    public var registerDate: String?
    public var currentLat: String?
    public var currentLong: String?
    public var driverPhone: String?
    public var onlineOffline: String?
    public var carTypeId: String?
    public var cityId: String?
    public var driverPassword: String?
    public var otherDocs: String?
    
    
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
        rc = json[kDetailsRcKey].string
        insurance = json[kDetailsInsuranceKey].string
        lastUpdate = json[kDetailsLastUpdateKey].string
        rejectRides = json[kDetailsRejectRidesKey].string
        rating = json[kDetailsRatingKey].string
        driverEmail = json[kDetailsDriverEmailKey].string
        driverImage = json[kDetailsDriverImageKey].string
        carModelName = json[kDetailsCarModelNameKey].string
        flag = json[kDetailsFlagKey].string
        driverName = json[kDetailsDriverNameKey].string
        cancelledRides = json[kDetailsCancelledRidesKey].string
        deviceId = json[kDetailsDeviceIdKey].string
        loginLogout = json[kDetailsLoginLogoutKey].string
        completedRides = json[kDetailsCompletedRidesKey].string
        status = json[kDetailsStatusKey].string
        busy = json[kDetailsBusyKey].string
        carModelId = json[kDetailsCarModelIdKey].string
        carTypeName = json[kDetailsCarTypeNameKey].string
        currentLocation = json[kDetailsCurrentLocationKey].string
        driverId = json[kDetailsDriverIdKey].string
        detailStatus = json[kDetailsDetailStatusKey].string
        carNumber = json[kDetailsCarNumberKey].string
        license = json[kDetailsLicenseKey].string
        lastUpdateDate = json[kDetailsLastUpdateDateKey].string
        driverToken = json[kDetailsDriverTokenKey].string
        registerDate = json[kDetailsRegisterDateKey].string
        currentLat = json[kDetailsCurrentLatKey].string
        currentLong = json[kDetailsCurrentLongKey].string
        driverPhone = json[kDetailsDriverPhoneKey].string
        onlineOffline = json[kDetailsOnlineOfflineKey].string
        carTypeId = json[kDetailsCarTypeIdKey].string
        cityId = json[kDetailsCityIdKey].string
        driverPassword = json[kDetailsDriverPasswordKey].string
        otherDocs = json[kDetailsOtherDocsKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if rc != nil {
            dictionary.updateValue(rc!, forKey: kDetailsRcKey)
        }
        if insurance != nil {
            dictionary.updateValue(insurance!, forKey: kDetailsInsuranceKey)
        }
        if lastUpdate != nil {
            dictionary.updateValue(lastUpdate!, forKey: kDetailsLastUpdateKey)
        }
        if rejectRides != nil {
            dictionary.updateValue(rejectRides!, forKey: kDetailsRejectRidesKey)
        }
        if rating != nil {
            dictionary.updateValue(rating!, forKey: kDetailsRatingKey)
        }
        if driverEmail != nil {
            dictionary.updateValue(driverEmail!, forKey: kDetailsDriverEmailKey)
        }
        if driverImage != nil {
            dictionary.updateValue(driverImage!, forKey: kDetailsDriverImageKey)
        }
        if carModelName != nil {
            dictionary.updateValue(carModelName!, forKey: kDetailsCarModelNameKey)
        }
        if flag != nil {
            dictionary.updateValue(flag!, forKey: kDetailsFlagKey)
        }
        if driverName != nil {
            dictionary.updateValue(driverName!, forKey: kDetailsDriverNameKey)
        }
        if cancelledRides != nil {
            dictionary.updateValue(cancelledRides!, forKey: kDetailsCancelledRidesKey)
        }
        if deviceId != nil {
            dictionary.updateValue(deviceId!, forKey: kDetailsDeviceIdKey)
        }
        if loginLogout != nil {
            dictionary.updateValue(loginLogout!, forKey: kDetailsLoginLogoutKey)
        }
        if completedRides != nil {
            dictionary.updateValue(completedRides!, forKey: kDetailsCompletedRidesKey)
        }
        if status != nil {
            dictionary.updateValue(status!, forKey: kDetailsStatusKey)
        }
        if busy != nil {
            dictionary.updateValue(busy!, forKey: kDetailsBusyKey)
        }
        if carModelId != nil {
            dictionary.updateValue(carModelId!, forKey: kDetailsCarModelIdKey)
        }
        if carTypeName != nil {
            dictionary.updateValue(carTypeName!, forKey: kDetailsCarTypeNameKey)
        }
        if currentLocation != nil {
            dictionary.updateValue(currentLocation!, forKey: kDetailsCurrentLocationKey)
        }
        if driverId != nil {
            dictionary.updateValue(driverId!, forKey: kDetailsDriverIdKey)
        }
        if detailStatus != nil {
            dictionary.updateValue(detailStatus!, forKey: kDetailsDetailStatusKey)
        }
        if carNumber != nil {
            dictionary.updateValue(carNumber!, forKey: kDetailsCarNumberKey)
        }
        if license != nil {
            dictionary.updateValue(license!, forKey: kDetailsLicenseKey)
        }
        if lastUpdateDate != nil {
            dictionary.updateValue(lastUpdateDate!, forKey: kDetailsLastUpdateDateKey)
        }
        if driverToken != nil {
            dictionary.updateValue(driverToken!, forKey: kDetailsDriverTokenKey)
        }
        if registerDate != nil {
            dictionary.updateValue(registerDate!, forKey: kDetailsRegisterDateKey)
        }
        if currentLat != nil {
            dictionary.updateValue(currentLat!, forKey: kDetailsCurrentLatKey)
        }
        if currentLong != nil {
            dictionary.updateValue(currentLong!, forKey: kDetailsCurrentLongKey)
        }
        if driverPhone != nil {
            dictionary.updateValue(driverPhone!, forKey: kDetailsDriverPhoneKey)
        }
        if onlineOffline != nil {
            dictionary.updateValue(onlineOffline!, forKey: kDetailsOnlineOfflineKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId!, forKey: kDetailsCarTypeIdKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId!, forKey: kDetailsCityIdKey)
        }
        if driverPassword != nil {
            dictionary.updateValue(driverPassword!, forKey: kDetailsDriverPasswordKey)
        }
        if otherDocs != nil {
            dictionary.updateValue(otherDocs!, forKey: kDetailsOtherDocsKey)
        }
        
        return dictionary
    }
    
    
}

/*	internal let kDetailsRcKey: String = "rc"
	internal let kDetailsInsuranceKey: String = "insurance"
	internal let kDetailsRejectRidesKey: String = "reject_rides"
	internal let kDetailsRatingKey: String = "rating"
	internal let kDetailsDriverEmailKey: String = "driver_email"
	internal let kDetailsDriverImageKey: String = "driver_image"
	internal let kDetailsCancelledRidesKey: String = "cancelled_rides"
	internal let kDetailsDriverNameKey: String = "driver_name"
	internal let kDetailsFlagKey: String = "flag"
	internal let kDetailsDeviceIdKey: String = "device_id"
	internal let kDetailsLoginLogoutKey: String = "login_logout"
	internal let kDetailsCompletedRidesKey: String = "completed_rides"
	internal let kDetailsStatusKey: String = "status"
	internal let kDetailsCarModelIdKey: String = "car_model_id"
	internal let kDetailsBusyKey: String = "busy"
	internal let kDetailsCurrentLocationKey: String = "current_location"
	internal let kDetailsDriverIdKey: String = "driver_id"
    internal let kDetailsDetailStatusKey: String = "detail_status"
	internal let kDetailsCurrentLongKey: String = "current_long"
	internal let kDetailsCityIdKey: String = "city_id"
	internal let kDetailsRegisterDateKey: String = "register_date"
   // internal let kDetailsDriverTokenKey: String = "driver_token"
	internal let kDetailsDriverPhoneKey: String = "driver_phone"
	internal let kDetailsLicenseKey: String = "license"
	internal let kDetailsCurrentLatKey: String = "current_lat"
	internal let kDetailsCarTypeIdKey: String = "car_type_id"
	internal let kDetailsOnlineOfflineKey: String = "online_offline"
	internal let kDetailsDriverPasswordKey: String = "driver_password"
	internal let kDetailsCarNumberKey: String = "car_number"
	internal let kDetailsOtherDocsKey: String = "other_docs"


    // MARK: Properties
	public var rc: String?
	public var insurance: String?
	public var rejectRides: String?
	public var rating: String?
	public var driverEmail: String?
	public var driverImage: String?
	public var cancelledRides: String?
	public var driverName: String?
	public var flag: String?
	public var deviceId: String?
	public var loginLogout: String?
	public var completedRides: String?
	public var status: String?
	public var carModelId: String?
	public var busy: String?
	public var currentLocation: String?
	public var driverId: String?
    public var detailStatus: String?
	public var currentLong: String?
	public var cityId: String?
	public var registerDate: String?
   // public var driverToken: String?
	public var driverPhone: String?
	public var license: String?
	public var currentLat: String?
	public var carTypeId: String?
	public var onlineOffline: String?
	public var driverPassword: String?
	public var carNumber: String?
	public var otherDocs: String?


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
		rc = json[kDetailsRcKey].string
		insurance = json[kDetailsInsuranceKey].string
		rejectRides = json[kDetailsRejectRidesKey].string
		rating = json[kDetailsRatingKey].string
		driverEmail = json[kDetailsDriverEmailKey].string
		driverImage = json[kDetailsDriverImageKey].string
		cancelledRides = json[kDetailsCancelledRidesKey].string
		driverName = json[kDetailsDriverNameKey].string
		flag = json[kDetailsFlagKey].string
		deviceId = json[kDetailsDeviceIdKey].string
		loginLogout = json[kDetailsLoginLogoutKey].string
		completedRides = json[kDetailsCompletedRidesKey].string
		status = json[kDetailsStatusKey].string
		carModelId = json[kDetailsCarModelIdKey].string
		busy = json[kDetailsBusyKey].string
		currentLocation = json[kDetailsCurrentLocationKey].string
		driverId = json[kDetailsDriverIdKey].string
        detailStatus = json[kDetailsDetailStatusKey].string
		currentLong = json[kDetailsCurrentLongKey].string
		cityId = json[kDetailsCityIdKey].string
		registerDate = json[kDetailsRegisterDateKey].string
      //  driverToken = json[kDetailsDriverTokenKey].string
		driverPhone = json[kDetailsDriverPhoneKey].string
		license = json[kDetailsLicenseKey].string
		currentLat = json[kDetailsCurrentLatKey].string
		carTypeId = json[kDetailsCarTypeIdKey].string
		onlineOffline = json[kDetailsOnlineOfflineKey].string
		driverPassword = json[kDetailsDriverPasswordKey].string
		carNumber = json[kDetailsCarNumberKey].string
		otherDocs = json[kDetailsOtherDocsKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if rc != nil {
			dictionary.updateValue(rc!, forKey: kDetailsRcKey)
		}
		if insurance != nil {
			dictionary.updateValue(insurance!, forKey: kDetailsInsuranceKey)
		}
		if rejectRides != nil {
			dictionary.updateValue(rejectRides!, forKey: kDetailsRejectRidesKey)
		}
		if rating != nil {
			dictionary.updateValue(rating!, forKey: kDetailsRatingKey)
		}
		if driverEmail != nil {
			dictionary.updateValue(driverEmail!, forKey: kDetailsDriverEmailKey)
		}
		if driverImage != nil {
			dictionary.updateValue(driverImage!, forKey: kDetailsDriverImageKey)
		}
		if cancelledRides != nil {
			dictionary.updateValue(cancelledRides!, forKey: kDetailsCancelledRidesKey)
		}
		if driverName != nil {
			dictionary.updateValue(driverName!, forKey: kDetailsDriverNameKey)
		}
		if flag != nil {
			dictionary.updateValue(flag!, forKey: kDetailsFlagKey)
		}
		if deviceId != nil {
			dictionary.updateValue(deviceId!, forKey: kDetailsDeviceIdKey)
		}
		if loginLogout != nil {
			dictionary.updateValue(loginLogout!, forKey: kDetailsLoginLogoutKey)
		}
		if completedRides != nil {
			dictionary.updateValue(completedRides!, forKey: kDetailsCompletedRidesKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kDetailsStatusKey)
		}
		if carModelId != nil {
			dictionary.updateValue(carModelId!, forKey: kDetailsCarModelIdKey)
		}
		if busy != nil {
			dictionary.updateValue(busy!, forKey: kDetailsBusyKey)
		}
		if currentLocation != nil {
			dictionary.updateValue(currentLocation!, forKey: kDetailsCurrentLocationKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId!, forKey: kDetailsDriverIdKey)
		}
        if detailStatus != nil {
            dictionary.updateValue(detailStatus!, forKey: kDetailsDetailStatusKey)
        }
		if currentLong != nil {
			dictionary.updateValue(currentLong!, forKey: kDetailsCurrentLongKey)
		}
		if cityId != nil {
			dictionary.updateValue(cityId!, forKey: kDetailsCityIdKey)
		}
		if registerDate != nil {
			dictionary.updateValue(registerDate!, forKey: kDetailsRegisterDateKey)
		}
       /* if driverToken != nil {
            dictionary.updateValue(driverToken!, forKey: kDetailsDriverTokenKey)
        }*/
		if driverPhone != nil {
			dictionary.updateValue(driverPhone!, forKey: kDetailsDriverPhoneKey)
		}
		if license != nil {
			dictionary.updateValue(license!, forKey: kDetailsLicenseKey)
		}
		if currentLat != nil {
			dictionary.updateValue(currentLat!, forKey: kDetailsCurrentLatKey)
		}
		if carTypeId != nil {
			dictionary.updateValue(carTypeId!, forKey: kDetailsCarTypeIdKey)
		}
		if onlineOffline != nil {
			dictionary.updateValue(onlineOffline!, forKey: kDetailsOnlineOfflineKey)
		}
		if driverPassword != nil {
			dictionary.updateValue(driverPassword!, forKey: kDetailsDriverPasswordKey)
		}
		if carNumber != nil {
			dictionary.updateValue(carNumber!, forKey: kDetailsCarNumberKey)
		}
		if otherDocs != nil {
			dictionary.updateValue(otherDocs!, forKey: kDetailsOtherDocsKey)
		}

        return dictionary
    }

}*/
