//
//  Message.swift
//
//  Created by AppOrio on 23/08/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class NearCarMessage: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMessageLongKey: String = "long"
	internal let kMessageDriverNameKey: String = "driver_name"
	internal let kMessageDistanceKey: String = "distance"
	internal let kMessageCarNumberKey: String = "car_number"
	internal let kMessageCityIdKey: String = "city_id"
	internal let kMessagePhoneNumberKey: String = "phone_number"
	internal let kMessageDurationKey: String = "duration"
	internal let kMessageDriverIdKey: String = "driver_id"
	internal let kMessageLatKey: String = "lat"
	internal let kMessageDriverImageKey: String = "driver_image"


    // MARK: Properties
	public var long: String?
	public var driverName: String?
	public var distance: String?
	public var carNumber: String?
	public var cityId: String?
	public var phoneNumber: String?
	public var duration: String?
	public var driverId: String?
	public var lat: String?
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
		long = json[kMessageLongKey].string
		driverName = json[kMessageDriverNameKey].string
		distance = json[kMessageDistanceKey].string
		carNumber = json[kMessageCarNumberKey].string
		cityId = json[kMessageCityIdKey].string
		phoneNumber = json[kMessagePhoneNumberKey].string
		duration = json[kMessageDurationKey].string
		driverId = json[kMessageDriverIdKey].string
		lat = json[kMessageLatKey].string
		driverImage = json[kMessageDriverImageKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if long != nil {
			dictionary.updateValue(long!, forKey: kMessageLongKey)
		}
		if driverName != nil {
			dictionary.updateValue(driverName!, forKey: kMessageDriverNameKey)
		}
		if distance != nil {
			dictionary.updateValue(distance!, forKey: kMessageDistanceKey)
		}
		if carNumber != nil {
			dictionary.updateValue(carNumber!, forKey: kMessageCarNumberKey)
		}
		if cityId != nil {
			dictionary.updateValue(cityId!, forKey: kMessageCityIdKey)
		}
		if phoneNumber != nil {
			dictionary.updateValue(phoneNumber!, forKey: kMessagePhoneNumberKey)
		}
		if duration != nil {
			dictionary.updateValue(duration!, forKey: kMessageDurationKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId!, forKey: kMessageDriverIdKey)
		}
		if lat != nil {
			dictionary.updateValue(lat!, forKey: kMessageLatKey)
		}
		if driverImage != nil {
			dictionary.updateValue(driverImage!, forKey: kMessageDriverImageKey)
		}

        return dictionary
    }

}
