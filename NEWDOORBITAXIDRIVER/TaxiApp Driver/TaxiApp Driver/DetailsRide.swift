//
//  Details.swift
//
//  Created by Rakesh kumar on 19/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DetailsRide: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kDetailsPaymentStatusKey: String = "payment_status"
    internal let kDetailsLaterDateKey: String = "later_date"
    internal let kDetailsLaterTimeKey: String = "later_time"
    internal let kDetailsTimeKey: String = "time"
    internal let kDetailsEndLocationKey: String = "end_location"
    internal let kDetailsRatingKey: String = "rating"
    internal let kDetailsUserImageKey: String = "user_image"
    internal let kDetailsRideDateKey: String = "ride_date"
    internal let kDetailsUserNameKey: String = "user_name"
    internal let kDetailsDistanceKey: String = "distance"
    internal let kDetailsRideStatusKey: String = "ride_status"
    internal let kDetailsRideImageKey: String = "ride_image"
    internal let kDetailsDropLocationKey: String = "drop_location"
    internal let kDetailsCouponCodeKey: String = "coupon_code"
    internal let kDetailsAmountKey: String = "amount"
    internal let kDetailsStatusKey: String = "status"
    internal let kDetailsRideTimeKey: String = "ride_time"
    internal let kDetailsUserPhoneKey: String = "user_phone"
    internal let kDetailsPickupLocationKey: String = "pickup_location"
    internal let kDetailsDropLatKey: String = "drop_lat"
    internal let kDetailsDriverIdKey: String = "driver_id"
    internal let kDetailsRideIdKey: String = "ride_id"
    internal let kDetailsRideTypeKey: String = "ride_type"
    internal let kDetailsCarTypeIdKey: String = "car_type_id"
    internal let kDetailsUserIdKey: String = "user_id"
    internal let kDetailsPickupLatKey: String = "pickup_lat"
    internal let kDetailsDropLongKey: String = "drop_long"
    internal let kDetailsPickupLongKey: String = "pickup_long"
    internal let kDetailsBeginLocationKey: String = "begin_location"
    
    
    // MARK: Properties
    public var paymentStatus: String?
    public var laterDate: String?
    public var laterTime: String?
    public var time: String?
    public var endLocation: String?
    public var rating: String?
    public var userImage: String?
    public var rideDate: String?
    public var userName: String?
    public var distance: String?
    public var rideStatus: String?
    public var rideImage: String?
    public var dropLocation: String?
    public var couponCode: String?
    public var amount: String?
    public var status: String?
    public var rideTime: String?
    public var userPhone: String?
    public var pickupLocation: String?
    public var dropLat: String?
    public var driverId: String?
    public var rideId: String?
    public var rideType: String?
    public var carTypeId: String?
    public var userId: String?
    public var pickupLat: String?
    public var dropLong: String?
    public var pickupLong: String?
    public var beginLocation: String?
    
    
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
        paymentStatus = json[kDetailsPaymentStatusKey].string
        laterDate = json[kDetailsLaterDateKey].string
        laterTime = json[kDetailsLaterTimeKey].string
        time = json[kDetailsTimeKey].string
        endLocation = json[kDetailsEndLocationKey].string
        rating = json[kDetailsRatingKey].string
        userImage = json[kDetailsUserImageKey].string
        rideDate = json[kDetailsRideDateKey].string
        userName = json[kDetailsUserNameKey].string
        distance = json[kDetailsDistanceKey].string
        rideStatus = json[kDetailsRideStatusKey].string
        rideImage = json[kDetailsRideImageKey].string
        dropLocation = json[kDetailsDropLocationKey].string
        couponCode = json[kDetailsCouponCodeKey].string
        amount = json[kDetailsAmountKey].string
        status = json[kDetailsStatusKey].string
        rideTime = json[kDetailsRideTimeKey].string
        userPhone = json[kDetailsUserPhoneKey].string
        pickupLocation = json[kDetailsPickupLocationKey].string
        dropLat = json[kDetailsDropLatKey].string
        driverId = json[kDetailsDriverIdKey].string
        rideId = json[kDetailsRideIdKey].string
        rideType = json[kDetailsRideTypeKey].string
        carTypeId = json[kDetailsCarTypeIdKey].string
        userId = json[kDetailsUserIdKey].string
        pickupLat = json[kDetailsPickupLatKey].string
        dropLong = json[kDetailsDropLongKey].string
        pickupLong = json[kDetailsPickupLongKey].string
        beginLocation = json[kDetailsBeginLocationKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if paymentStatus != nil {
            dictionary.updateValue(paymentStatus!, forKey: kDetailsPaymentStatusKey)
        }
        if laterDate != nil {
            dictionary.updateValue(laterDate!, forKey: kDetailsLaterDateKey)
        }
        if laterTime != nil {
            dictionary.updateValue(laterTime!, forKey: kDetailsLaterTimeKey)
        }
        if time != nil {
            dictionary.updateValue(time!, forKey: kDetailsTimeKey)
        }
        if endLocation != nil {
            dictionary.updateValue(endLocation!, forKey: kDetailsEndLocationKey)
        }
        if rating != nil {
            dictionary.updateValue(rating!, forKey: kDetailsRatingKey)
        }
        if userImage != nil {
            dictionary.updateValue(userImage!, forKey: kDetailsUserImageKey)
        }
        if rideDate != nil {
            dictionary.updateValue(rideDate!, forKey: kDetailsRideDateKey)
        }
        if userName != nil {
            dictionary.updateValue(userName!, forKey: kDetailsUserNameKey)
        }
        if distance != nil {
            dictionary.updateValue(distance!, forKey: kDetailsDistanceKey)
        }
        if rideStatus != nil {
            dictionary.updateValue(rideStatus!, forKey: kDetailsRideStatusKey)
        }
        if rideImage != nil {
            dictionary.updateValue(rideImage!, forKey: kDetailsRideImageKey)
        }
        if dropLocation != nil {
            dictionary.updateValue(dropLocation!, forKey: kDetailsDropLocationKey)
        }
        if couponCode != nil {
            dictionary.updateValue(couponCode!, forKey: kDetailsCouponCodeKey)
        }
        if amount != nil {
            dictionary.updateValue(amount!, forKey: kDetailsAmountKey)
        }
        if status != nil {
            dictionary.updateValue(status!, forKey: kDetailsStatusKey)
        }
        if rideTime != nil {
            dictionary.updateValue(rideTime!, forKey: kDetailsRideTimeKey)
        }
        if userPhone != nil {
            dictionary.updateValue(userPhone!, forKey: kDetailsUserPhoneKey)
        }
        if pickupLocation != nil {
            dictionary.updateValue(pickupLocation!, forKey: kDetailsPickupLocationKey)
        }
        if dropLat != nil {
            dictionary.updateValue(dropLat!, forKey: kDetailsDropLatKey)
        }
        if driverId != nil {
            dictionary.updateValue(driverId!, forKey: kDetailsDriverIdKey)
        }
        if rideId != nil {
            dictionary.updateValue(rideId!, forKey: kDetailsRideIdKey)
        }
        if rideType != nil {
            dictionary.updateValue(rideType!, forKey: kDetailsRideTypeKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId!, forKey: kDetailsCarTypeIdKey)
        }
        if userId != nil {
            dictionary.updateValue(userId!, forKey: kDetailsUserIdKey)
        }
        if pickupLat != nil {
            dictionary.updateValue(pickupLat!, forKey: kDetailsPickupLatKey)
        }
        if dropLong != nil {
            dictionary.updateValue(dropLong!, forKey: kDetailsDropLongKey)
        }
        if pickupLong != nil {
            dictionary.updateValue(pickupLong!, forKey: kDetailsPickupLongKey)
        }
        if beginLocation != nil {
            dictionary.updateValue(beginLocation!, forKey: kDetailsBeginLocationKey)
        }
        
        return dictionary
    }
    
}


/*	internal let kDetailsLaterDateKey: String = "later_date"
	internal let kDetailsRideTimeKey: String = "ride_time"
	internal let kDetailsLaterTimeKey: String = "later_time"
	internal let kDetailsPickupLocationKey: String = "pickup_location"
	internal let kDetailsDropLatKey: String = "drop_lat"
	internal let kDetailsDriverIdKey: String = "driver_id"
	internal let kDetailsRideIdKey: String = "ride_id"
	internal let kDetailsRideTypeKey: String = "ride_type"
	internal let kDetailsRideDateKey: String = "ride_date"
	internal let kDetailsRideStatusKey: String = "ride_status"
	internal let kDetailsDropLocationKey: String = "drop_location"
	internal let kDetailsUserIdKey: String = "user_id"
	internal let kDetailsCouponCodeKey: String = "coupon_code"
	internal let kDetailsPickupLatKey: String = "pickup_lat"
	internal let kDetailsDropLongKey: String = "drop_long"
	internal let kDetailsPickupLongKey: String = "pickup_long"
	internal let kDetailsStatusKey: String = "status"


    // MARK: Properties
	public var laterDate: String?
	public var rideTime: String?
	public var laterTime: String?
	public var pickupLocation: String?
	public var dropLat: String?
	public var driverId: String?
	public var rideId: String?
	public var rideType: String?
	public var rideDate: String?
	public var rideStatus: String?
	public var dropLocation: String?
	public var userId: String?
	public var couponCode: String?
	public var pickupLat: String?
	public var dropLong: String?
	public var pickupLong: String?
	public var status: String?


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
		laterDate = json[kDetailsLaterDateKey].string
		rideTime = json[kDetailsRideTimeKey].string
		laterTime = json[kDetailsLaterTimeKey].string
		pickupLocation = json[kDetailsPickupLocationKey].string
		dropLat = json[kDetailsDropLatKey].string
		driverId = json[kDetailsDriverIdKey].string
		rideId = json[kDetailsRideIdKey].string
		rideType = json[kDetailsRideTypeKey].string
		rideDate = json[kDetailsRideDateKey].string
		rideStatus = json[kDetailsRideStatusKey].string
		dropLocation = json[kDetailsDropLocationKey].string
		userId = json[kDetailsUserIdKey].string
		couponCode = json[kDetailsCouponCodeKey].string
		pickupLat = json[kDetailsPickupLatKey].string
		dropLong = json[kDetailsDropLongKey].string
		pickupLong = json[kDetailsPickupLongKey].string
		status = json[kDetailsStatusKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if laterDate != nil {
			dictionary.updateValue(laterDate!, forKey: kDetailsLaterDateKey)
		}
		if rideTime != nil {
			dictionary.updateValue(rideTime!, forKey: kDetailsRideTimeKey)
		}
		if laterTime != nil {
			dictionary.updateValue(laterTime!, forKey: kDetailsLaterTimeKey)
		}
		if pickupLocation != nil {
			dictionary.updateValue(pickupLocation!, forKey: kDetailsPickupLocationKey)
		}
		if dropLat != nil {
			dictionary.updateValue(dropLat!, forKey: kDetailsDropLatKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId!, forKey: kDetailsDriverIdKey)
		}
		if rideId != nil {
			dictionary.updateValue(rideId!, forKey: kDetailsRideIdKey)
		}
		if rideType != nil {
			dictionary.updateValue(rideType!, forKey: kDetailsRideTypeKey)
		}
		if rideDate != nil {
			dictionary.updateValue(rideDate!, forKey: kDetailsRideDateKey)
		}
		if rideStatus != nil {
			dictionary.updateValue(rideStatus!, forKey: kDetailsRideStatusKey)
		}
		if dropLocation != nil {
			dictionary.updateValue(dropLocation!, forKey: kDetailsDropLocationKey)
		}
		if userId != nil {
			dictionary.updateValue(userId!, forKey: kDetailsUserIdKey)
		}
		if couponCode != nil {
			dictionary.updateValue(couponCode!, forKey: kDetailsCouponCodeKey)
		}
		if pickupLat != nil {
			dictionary.updateValue(pickupLat!, forKey: kDetailsPickupLatKey)
		}
		if dropLong != nil {
			dictionary.updateValue(dropLong!, forKey: kDetailsDropLongKey)
		}
		if pickupLong != nil {
			dictionary.updateValue(pickupLong!, forKey: kDetailsPickupLongKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kDetailsStatusKey)
		}

        return dictionary
    }

}*/
