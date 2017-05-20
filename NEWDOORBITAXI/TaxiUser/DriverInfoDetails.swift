//
//  Details.swift
//
//  Created by AppOrio on 21/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DriverInfoDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.

    
    internal let kDetailsBeginLocationKey: String = "begin_location"
    internal let kDetailsPaymentStatusKey: String = "payment_status"
    internal let kDetailsDriverRatingKey: String = "driver_rating"
    internal let kDetailsBeginLongKey: String = "begin_long"
    internal let kDetailsTimeKey: String = "time"
    internal let kDetailsEndLocationKey: String = "end_location"
    internal let kDetailsDriverImageKey: String = "driver_image"
    internal let kDetailsCarModelNameKey: String = "car_model_name"
    internal let kDetailsDriverNameKey: String = "driver_name"
    internal let kDetailsDistanceKey: String = "distance"
    internal let kDetailsRideDateKey: String = "ride_date"
    internal let kDetailsArrivedTimeKey: String = "arrived_time"
    internal let kDetailsRideStatusKey: String = "ride_status"
    internal let kDetailsRideImageKey: String = "ride_image"
    internal let kDetailsDropLocationKey: String = "drop_location"
    internal let kDetailsAmountKey: String = "amount"
    internal let kDetailsBeginLatKey: String = "begin_lat"
    internal let kDetailsRideTimeKey: String = "ride_time"
    internal let kDetailsCarTypeNameKey: String = "car_type_name"
    internal let kDetailsCarTypeImageKey: String = "car_type_image"
    internal let kDetailsPickupLocationKey: String = "pickup_location"
    internal let kDetailsDriverLocationKey: String = "driver_location"
    internal let kDetailsBeginTimeKey: String = "begin_time"
    internal let kDetailsDropLatKey: String = "drop_lat"
    internal let kDetailsRideTypeKey: String = "ride_type"
    internal let kDetailsRideIdKey: String = "ride_id"
    internal let kDetailsCarNumberKey: String = "car_number"
    internal let kDetailsDriverPhoneKey: String = "driver_phone"
    internal let kDetailsDoneRideIdKey: String = "done_ride_id"
    internal let kDetailsDriverLongKey: String = "driver_long"
    internal let kDetailsUserIdKey: String = "user_id"
    internal let kDetailsDriverLatKey: String = "driver_lat"
    internal let kDetailsPickupLatKey: String = "pickup_lat"
    internal let kDetailsDropLongKey: String = "drop_long"
    internal let kDetailsPickupLongKey: String = "pickup_long"
    
    
    // MARK: Properties
    public var beginLocation: String?
    public var paymentStatus: String?
    public var driverRating: String?
    public var beginLong: String?
    public var time: String?
    public var endLocation: String?
    public var driverImage: String?
    public var carModelName: String?
    public var driverName: String?
    public var distance: String?
    public var rideDate: String?
    public var arrivedTime: String?
    public var rideStatus: String?
    public var rideImage: String?
    public var dropLocation: String?
    public var amount: String?
    public var beginLat: String?
    public var rideTime: String?
    public var carTypeName: String?
    public var carTypeImage: String?
    public var pickupLocation: String?
    public var driverLocation: String?
    public var beginTime: String?
    public var dropLat: String?
    public var rideType: String?
    public var rideId: String?
    public var carNumber: String?
    public var driverPhone: String?
    public var doneRideId: String?
    public var driverLong: String?
    public var userId: String?
    public var driverLat: String?
    public var pickupLat: String?
    public var dropLong: String?
    public var pickupLong: String?
    
    
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
        beginLocation = json[kDetailsBeginLocationKey].string
        paymentStatus = json[kDetailsPaymentStatusKey].string
        driverRating = json[kDetailsDriverRatingKey].string
        beginLong = json[kDetailsBeginLongKey].string
        time = json[kDetailsTimeKey].string
        endLocation = json[kDetailsEndLocationKey].string
        driverImage = json[kDetailsDriverImageKey].string
        carModelName = json[kDetailsCarModelNameKey].string
        driverName = json[kDetailsDriverNameKey].string
        distance = json[kDetailsDistanceKey].string
        rideDate = json[kDetailsRideDateKey].string
        arrivedTime = json[kDetailsArrivedTimeKey].string
        rideStatus = json[kDetailsRideStatusKey].string
        rideImage = json[kDetailsRideImageKey].string
        dropLocation = json[kDetailsDropLocationKey].string
        amount = json[kDetailsAmountKey].string
        beginLat = json[kDetailsBeginLatKey].string
        rideTime = json[kDetailsRideTimeKey].string
        carTypeName = json[kDetailsCarTypeNameKey].string
        carTypeImage = json[kDetailsCarTypeImageKey].string
        pickupLocation = json[kDetailsPickupLocationKey].string
        driverLocation = json[kDetailsDriverLocationKey].string
        beginTime = json[kDetailsBeginTimeKey].string
        dropLat = json[kDetailsDropLatKey].string
        rideType = json[kDetailsRideTypeKey].string
        rideId = json[kDetailsRideIdKey].string
        carNumber = json[kDetailsCarNumberKey].string
        driverPhone = json[kDetailsDriverPhoneKey].string
        doneRideId = json[kDetailsDoneRideIdKey].string
        driverLong = json[kDetailsDriverLongKey].string
        userId = json[kDetailsUserIdKey].string
        driverLat = json[kDetailsDriverLatKey].string
        pickupLat = json[kDetailsPickupLatKey].string
        dropLong = json[kDetailsDropLongKey].string
        pickupLong = json[kDetailsPickupLongKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if beginLocation != nil {
            dictionary.updateValue(beginLocation!, forKey: kDetailsBeginLocationKey)
        }
        if paymentStatus != nil {
            dictionary.updateValue(paymentStatus!, forKey: kDetailsPaymentStatusKey)
        }
        if driverRating != nil {
            dictionary.updateValue(driverRating!, forKey: kDetailsDriverRatingKey)
        }
        if beginLong != nil {
            dictionary.updateValue(beginLong!, forKey: kDetailsBeginLongKey)
        }
        if time != nil {
            dictionary.updateValue(time!, forKey: kDetailsTimeKey)
        }
        if endLocation != nil {
            dictionary.updateValue(endLocation!, forKey: kDetailsEndLocationKey)
        }
        if driverImage != nil {
            dictionary.updateValue(driverImage!, forKey: kDetailsDriverImageKey)
        }
        if carModelName != nil {
            dictionary.updateValue(carModelName!, forKey: kDetailsCarModelNameKey)
        }
        if driverName != nil {
            dictionary.updateValue(driverName!, forKey: kDetailsDriverNameKey)
        }
        if distance != nil {
            dictionary.updateValue(distance!, forKey: kDetailsDistanceKey)
        }
        if rideDate != nil {
            dictionary.updateValue(rideDate!, forKey: kDetailsRideDateKey)
        }
        if arrivedTime != nil {
            dictionary.updateValue(arrivedTime!, forKey: kDetailsArrivedTimeKey)
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
        if amount != nil {
            dictionary.updateValue(amount!, forKey: kDetailsAmountKey)
        }
        if beginLat != nil {
            dictionary.updateValue(beginLat!, forKey: kDetailsBeginLatKey)
        }
        if rideTime != nil {
            dictionary.updateValue(rideTime!, forKey: kDetailsRideTimeKey)
        }
        if carTypeName != nil {
            dictionary.updateValue(carTypeName!, forKey: kDetailsCarTypeNameKey)
        }
        if carTypeImage != nil {
            dictionary.updateValue(carTypeImage!, forKey: kDetailsCarTypeImageKey)
        }
        if pickupLocation != nil {
            dictionary.updateValue(pickupLocation!, forKey: kDetailsPickupLocationKey)
        }
        if driverLocation != nil {
            dictionary.updateValue(driverLocation!, forKey: kDetailsDriverLocationKey)
        }
        if beginTime != nil {
            dictionary.updateValue(beginTime!, forKey: kDetailsBeginTimeKey)
        }
        if dropLat != nil {
            dictionary.updateValue(dropLat!, forKey: kDetailsDropLatKey)
        }
        if rideType != nil {
            dictionary.updateValue(rideType!, forKey: kDetailsRideTypeKey)
        }
        if rideId != nil {
            dictionary.updateValue(rideId!, forKey: kDetailsRideIdKey)
        }
        if carNumber != nil {
            dictionary.updateValue(carNumber!, forKey: kDetailsCarNumberKey)
        }
        if driverPhone != nil {
            dictionary.updateValue(driverPhone!, forKey: kDetailsDriverPhoneKey)
        }
        if doneRideId != nil {
            dictionary.updateValue(doneRideId!, forKey: kDetailsDoneRideIdKey)
        }
        if driverLong != nil {
            dictionary.updateValue(driverLong!, forKey: kDetailsDriverLongKey)
        }
        if userId != nil {
            dictionary.updateValue(userId!, forKey: kDetailsUserIdKey)
        }
        if driverLat != nil {
            dictionary.updateValue(driverLat!, forKey: kDetailsDriverLatKey)
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
        
        return dictionary
    }
    
}


  /*  internal let kDetailsPaymentStatusKey: String = "payment_status"
    internal let kDetailsDriverRatingKey: String = "driver_rating"
    internal let kDetailsBeginLongKey: String = "begin_long"
    internal let kDetailsTimeKey: String = "time"
    internal let kDetailsEndLocationKey: String = "end_location"
    internal let kDetailsDriverImageKey: String = "driver_image"
    internal let kDetailsRideDateKey: String = "ride_date"
    internal let kDetailsCarModelNameKey: String = "car_model_name"
    internal let kDetailsDriverNameKey: String = "driver_name"
    internal let kDetailsArrivedTimeKey: String = "arrived_time"
    internal let kDetailsDistanceKey: String = "distance"
    internal let kDetailsRideStatusKey: String = "ride_status"
    internal let kDetailsDropLocationKey: String = "drop_location"
    internal let kDetailsAmountKey: String = "amount"
    internal let kDetailsBeginLatKey: String = "begin_lat"
    internal let kDetailsRideTimeKey: String = "ride_time"
    internal let kDetailsCarTypeNameKey: String = "car_type_name"
    internal let kDetailsCarTypeImageKey: String = "car_type_image"
    internal let kDetailsPickupLocationKey: String = "pickup_location"
    internal let kDetailsDriverLocationKey: String = "driver_location"
    internal let kDetailsBeginTimeKey: String = "begin_time"
    internal let kDetailsRideTypeKey: String = "ride_type"
    internal let kDetailsRideIdKey: String = "ride_id"
    internal let kDetailsCarNumberKey: String = "car_number"
    internal let kDetailsDriverPhoneKey: String = "driver_phone"
    internal let kDetailsUserIdKey: String = "user_id"
    internal let kDetailsDoneRideIdKey: String = "done_ride_id"
    internal let kDetailsDriverLongKey: String = "driver_long"
    internal let kDetailsPickupLatKey: String = "pickup_lat"
    internal let kDetailsDriverLatKey: String = "driver_lat"
    internal let kDetailsPickupLongKey: String = "pickup_long"
    internal let kDetailsBeginLocationKey: String = "begin_location"
    
    
    // MARK: Properties
    public var paymentStatus: String?
    public var driverRating: String?
    public var beginLong: String?
    public var time: String?
    public var endLocation: String?
    public var driverImage: String?
    public var rideDate: String?
    public var carModelName: String?
    public var driverName: String?
    public var arrivedTime: String?
    public var distance: String?
    public var rideStatus: String?
    public var dropLocation: String?
    public var amount: String?
    public var beginLat: String?
    public var rideTime: String?
    public var carTypeName: String?
    public var carTypeImage: String?
    public var pickupLocation: String?
    public var driverLocation: String?
    public var beginTime: String?
    public var rideType: String?
    public var rideId: String?
    public var carNumber: String?
    public var driverPhone: String?
    public var userId: String?
    public var doneRideId: String?
    public var driverLong: String?
    public var pickupLat: String?
    public var driverLat: String?
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
        driverRating = json[kDetailsDriverRatingKey].string
        beginLong = json[kDetailsBeginLongKey].string
        time = json[kDetailsTimeKey].string
        endLocation = json[kDetailsEndLocationKey].string
        driverImage = json[kDetailsDriverImageKey].string
        rideDate = json[kDetailsRideDateKey].string
        carModelName = json[kDetailsCarModelNameKey].string
        driverName = json[kDetailsDriverNameKey].string
        arrivedTime = json[kDetailsArrivedTimeKey].string
        distance = json[kDetailsDistanceKey].string
        rideStatus = json[kDetailsRideStatusKey].string
        dropLocation = json[kDetailsDropLocationKey].string
        amount = json[kDetailsAmountKey].string
        beginLat = json[kDetailsBeginLatKey].string
        rideTime = json[kDetailsRideTimeKey].string
        carTypeName = json[kDetailsCarTypeNameKey].string
        carTypeImage = json[kDetailsCarTypeImageKey].string
        pickupLocation = json[kDetailsPickupLocationKey].string
        driverLocation = json[kDetailsDriverLocationKey].string
        beginTime = json[kDetailsBeginTimeKey].string
        rideType = json[kDetailsRideTypeKey].string
        rideId = json[kDetailsRideIdKey].string
        carNumber = json[kDetailsCarNumberKey].string
        driverPhone = json[kDetailsDriverPhoneKey].string
        userId = json[kDetailsUserIdKey].string
        doneRideId = json[kDetailsDoneRideIdKey].string
        driverLong = json[kDetailsDriverLongKey].string
        pickupLat = json[kDetailsPickupLatKey].string
        driverLat = json[kDetailsDriverLatKey].string
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
        if driverRating != nil {
            dictionary.updateValue(driverRating!, forKey: kDetailsDriverRatingKey)
        }
        if beginLong != nil {
            dictionary.updateValue(beginLong!, forKey: kDetailsBeginLongKey)
        }
        if time != nil {
            dictionary.updateValue(time!, forKey: kDetailsTimeKey)
        }
        if endLocation != nil {
            dictionary.updateValue(endLocation!, forKey: kDetailsEndLocationKey)
        }
        if driverImage != nil {
            dictionary.updateValue(driverImage!, forKey: kDetailsDriverImageKey)
        }
        if rideDate != nil {
            dictionary.updateValue(rideDate!, forKey: kDetailsRideDateKey)
        }
        if carModelName != nil {
            dictionary.updateValue(carModelName!, forKey: kDetailsCarModelNameKey)
        }
        if driverName != nil {
            dictionary.updateValue(driverName!, forKey: kDetailsDriverNameKey)
        }
        if arrivedTime != nil {
            dictionary.updateValue(arrivedTime!, forKey: kDetailsArrivedTimeKey)
        }
        if distance != nil {
            dictionary.updateValue(distance!, forKey: kDetailsDistanceKey)
        }
        if rideStatus != nil {
            dictionary.updateValue(rideStatus!, forKey: kDetailsRideStatusKey)
        }
        if dropLocation != nil {
            dictionary.updateValue(dropLocation!, forKey: kDetailsDropLocationKey)
        }
        if amount != nil {
            dictionary.updateValue(amount!, forKey: kDetailsAmountKey)
        }
        if beginLat != nil {
            dictionary.updateValue(beginLat!, forKey: kDetailsBeginLatKey)
        }
        if rideTime != nil {
            dictionary.updateValue(rideTime!, forKey: kDetailsRideTimeKey)
        }
        if carTypeName != nil {
            dictionary.updateValue(carTypeName!, forKey: kDetailsCarTypeNameKey)
        }
        if carTypeImage != nil {
            dictionary.updateValue(carTypeImage!, forKey: kDetailsCarTypeImageKey)
        }
        if pickupLocation != nil {
            dictionary.updateValue(pickupLocation!, forKey: kDetailsPickupLocationKey)
        }
        if driverLocation != nil {
            dictionary.updateValue(driverLocation!, forKey: kDetailsDriverLocationKey)
        }
        if beginTime != nil {
            dictionary.updateValue(beginTime!, forKey: kDetailsBeginTimeKey)
        }
        if rideType != nil {
            dictionary.updateValue(rideType!, forKey: kDetailsRideTypeKey)
        }
        if rideId != nil {
            dictionary.updateValue(rideId!, forKey: kDetailsRideIdKey)
        }
        if carNumber != nil {
            dictionary.updateValue(carNumber!, forKey: kDetailsCarNumberKey)
        }
        if driverPhone != nil {
            dictionary.updateValue(driverPhone!, forKey: kDetailsDriverPhoneKey)
        }
        if userId != nil {
            dictionary.updateValue(userId!, forKey: kDetailsUserIdKey)
        }
        if doneRideId != nil {
            dictionary.updateValue(doneRideId!, forKey: kDetailsDoneRideIdKey)
        }
        if driverLong != nil {
            dictionary.updateValue(driverLong!, forKey: kDetailsDriverLongKey)
        }
        if pickupLat != nil {
            dictionary.updateValue(pickupLat!, forKey: kDetailsPickupLatKey)
        }
        if driverLat != nil {
            dictionary.updateValue(driverLat!, forKey: kDetailsDriverLatKey)
        }
        if pickupLong != nil {
            dictionary.updateValue(pickupLong!, forKey: kDetailsPickupLongKey)
        }
        if beginLocation != nil {
            dictionary.updateValue(beginLocation!, forKey: kDetailsBeginLocationKey)
        }
        
        return dictionary
    }
    
}*/


 