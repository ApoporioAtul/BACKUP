//
//  Msg.swift
//
//  Created by AppOrio on 07/02/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllRidesMsg: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMsgBeginLatKey: String = "begin_lat"
	internal let kMsgRideTimeKey: String = "ride_time"
	internal let kMsgPaymentStatusKey: String = "payment_status"
	internal let kMsgBeginLongKey: String = "begin_long"
	internal let kMsgTimeKey: String = "time"
	internal let kMsgPickupLocationKey: String = "pickup_location"
	internal let kMsgEndLocationKey: String = "end_location"
	internal let kMsgBeginTimeKey: String = "begin_time"
	internal let kMsgDropLatKey: String = "drop_lat"
	internal let kMsgDriverIdKey: String = "driver_id"
	internal let kMsgRideIdKey: String = "ride_id"
	internal let kMsgRideTypeKey: String = "ride_type"
	internal let kMsgRideDateKey: String = "ride_date"
	internal let kMsgArrivedTimeKey: String = "arrived_time"
	internal let kMsgDistanceKey: String = "distance"
	internal let kMsgRideStatusKey: String = "ride_status"
	internal let kMsgDropLocationKey: String = "drop_location"
	internal let kMsgUserIdKey: String = "user_id"
	internal let kMsgAmountKey: String = "amount"
	internal let kMsgPickupLatKey: String = "pickup_lat"
	internal let kMsgDropLongKey: String = "drop_long"
	internal let kMsgPickupLongKey: String = "pickup_long"
	internal let kMsgBeginLocationKey: String = "begin_location"


    // MARK: Properties
	public var beginLat: String?
	public var rideTime: String?
	public var paymentStatus: String?
	public var beginLong: String?
	public var time: String?
	public var pickupLocation: String?
	public var endLocation: String?
	public var beginTime: String?
	public var dropLat: String?
	public var driverId: String?
	public var rideId: String?
	public var rideType: String?
	public var rideDate: String?
	public var arrivedTime: String?
	public var distance: String?
	public var rideStatus: String?
	public var dropLocation: String?
	public var userId: String?
	public var amount: String?
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
		beginLat = json[kMsgBeginLatKey].string
		rideTime = json[kMsgRideTimeKey].string
		paymentStatus = json[kMsgPaymentStatusKey].string
		beginLong = json[kMsgBeginLongKey].string
		time = json[kMsgTimeKey].string
		pickupLocation = json[kMsgPickupLocationKey].string
		endLocation = json[kMsgEndLocationKey].string
		beginTime = json[kMsgBeginTimeKey].string
		dropLat = json[kMsgDropLatKey].string
		driverId = json[kMsgDriverIdKey].string
		rideId = json[kMsgRideIdKey].string
		rideType = json[kMsgRideTypeKey].string
		rideDate = json[kMsgRideDateKey].string
		arrivedTime = json[kMsgArrivedTimeKey].string
		distance = json[kMsgDistanceKey].string
		rideStatus = json[kMsgRideStatusKey].string
		dropLocation = json[kMsgDropLocationKey].string
		userId = json[kMsgUserIdKey].string
		amount = json[kMsgAmountKey].string
		pickupLat = json[kMsgPickupLatKey].string
		dropLong = json[kMsgDropLongKey].string
		pickupLong = json[kMsgPickupLongKey].string
		beginLocation = json[kMsgBeginLocationKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if beginLat != nil {
			dictionary.updateValue(beginLat!, forKey: kMsgBeginLatKey)
		}
		if rideTime != nil {
			dictionary.updateValue(rideTime!, forKey: kMsgRideTimeKey)
		}
		if paymentStatus != nil {
			dictionary.updateValue(paymentStatus!, forKey: kMsgPaymentStatusKey)
		}
		if beginLong != nil {
			dictionary.updateValue(beginLong!, forKey: kMsgBeginLongKey)
		}
		if time != nil {
			dictionary.updateValue(time!, forKey: kMsgTimeKey)
		}
		if pickupLocation != nil {
			dictionary.updateValue(pickupLocation!, forKey: kMsgPickupLocationKey)
		}
		if endLocation != nil {
			dictionary.updateValue(endLocation!, forKey: kMsgEndLocationKey)
		}
		if beginTime != nil {
			dictionary.updateValue(beginTime!, forKey: kMsgBeginTimeKey)
		}
		if dropLat != nil {
			dictionary.updateValue(dropLat!, forKey: kMsgDropLatKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId!, forKey: kMsgDriverIdKey)
		}
		if rideId != nil {
			dictionary.updateValue(rideId!, forKey: kMsgRideIdKey)
		}
		if rideType != nil {
			dictionary.updateValue(rideType!, forKey: kMsgRideTypeKey)
		}
		if rideDate != nil {
			dictionary.updateValue(rideDate!, forKey: kMsgRideDateKey)
		}
		if arrivedTime != nil {
			dictionary.updateValue(arrivedTime!, forKey: kMsgArrivedTimeKey)
		}
		if distance != nil {
			dictionary.updateValue(distance!, forKey: kMsgDistanceKey)
		}
		if rideStatus != nil {
			dictionary.updateValue(rideStatus!, forKey: kMsgRideStatusKey)
		}
		if dropLocation != nil {
			dictionary.updateValue(dropLocation!, forKey: kMsgDropLocationKey)
		}
		if userId != nil {
			dictionary.updateValue(userId!, forKey: kMsgUserIdKey)
		}
		if amount != nil {
			dictionary.updateValue(amount!, forKey: kMsgAmountKey)
		}
		if pickupLat != nil {
			dictionary.updateValue(pickupLat!, forKey: kMsgPickupLatKey)
		}
		if dropLong != nil {
			dictionary.updateValue(dropLong!, forKey: kMsgDropLongKey)
		}
		if pickupLong != nil {
			dictionary.updateValue(pickupLong!, forKey: kMsgPickupLongKey)
		}
		if beginLocation != nil {
			dictionary.updateValue(beginLocation!, forKey: kMsgBeginLocationKey)
		}

        return dictionary
    }

}
