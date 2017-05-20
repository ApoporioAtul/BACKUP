//
//  Msg.swift
//
//  Created by AppOrio on 21/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DoneRideMsg: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMsgDriverNameKey: String = "driver_name"
	internal let kMsgDistanceKey: String = "distance"
	internal let kMsgTotTimeKey: String = "tot_time"
	internal let kMsgDoneRideIdKey: String = "done_ride_id"
	internal let kMsgAmountKey: String = "amount"
	internal let kMsgDriverIdKey: String = "driver_id"
    internal let kMsgRideIdKey: String = "ride_id"
    internal let kMsgPaymentOptionIdKey: String = "payment_option_id"
	internal let kMsgDriverImageKey: String = "driver_image"


    // MARK: Properties
	public var driverName: String?
	public var distance: String?
	public var totTime: String?
	public var doneRideId: String?
	public var amount: String?
	public var driverId: String?
    public var rideId: String?
    public var paymentOptionId: String?
	public var driverImage: String?


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
		driverName = json[kMsgDriverNameKey].string
		distance = json[kMsgDistanceKey].string
		totTime = json[kMsgTotTimeKey].string
		doneRideId = json[kMsgDoneRideIdKey].string
		amount = json[kMsgAmountKey].string
		driverId = json[kMsgDriverIdKey].string
        rideId = json[kMsgRideIdKey].string
        paymentOptionId = json[kMsgPaymentOptionIdKey].string
		driverImage = json[kMsgDriverImageKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if driverName != nil {
			dictionary.updateValue(driverName!, forKey: kMsgDriverNameKey)
		}
		if distance != nil {
			dictionary.updateValue(distance!, forKey: kMsgDistanceKey)
		}
		if totTime != nil {
			dictionary.updateValue(totTime!, forKey: kMsgTotTimeKey)
		}
		if doneRideId != nil {
			dictionary.updateValue(doneRideId!, forKey: kMsgDoneRideIdKey)
		}
		if amount != nil {
			dictionary.updateValue(amount!, forKey: kMsgAmountKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId!, forKey: kMsgDriverIdKey)
		}
        if rideId != nil {
            dictionary.updateValue(rideId!, forKey: kMsgRideIdKey)
        }
        if paymentOptionId != nil {
            dictionary.updateValue(paymentOptionId!, forKey: kMsgPaymentOptionIdKey)
        }
		if driverImage != nil {
			dictionary.updateValue(driverImage!, forKey: kMsgDriverImageKey)
		}

        return dictionary
    }

}
