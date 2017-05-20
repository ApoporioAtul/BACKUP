//
//  Details.swift
//
//  Created by AppOrio on 20/02/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DriverTrackDetails: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDetailsRideTrackIdKey: String = "ride_track_id"
	internal let kDetailsDriverLocationKey: String = "driver_location"
	internal let kDetailsUserIdKey: String = "user_id"
	internal let kDetailsDriverLatKey: String = "driver_lat"
	internal let kDetailsDriverIdKey: String = "driver_id"
	internal let kDetailsRideIdKey: String = "ride_id"
	internal let kDetailsDriverLongKey: String = "driver_long"


    // MARK: Properties
	public var rideTrackId: String?
	public var driverLocation: String?
	public var userId: String?
	public var driverLat: String?
	public var driverId: String?
	public var rideId: String?
	public var driverLong: String?


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
		rideTrackId = json[kDetailsRideTrackIdKey].string
		driverLocation = json[kDetailsDriverLocationKey].string
		userId = json[kDetailsUserIdKey].string
		driverLat = json[kDetailsDriverLatKey].string
		driverId = json[kDetailsDriverIdKey].string
		rideId = json[kDetailsRideIdKey].string
		driverLong = json[kDetailsDriverLongKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if rideTrackId != nil {
			dictionary.updateValue(rideTrackId!, forKey: kDetailsRideTrackIdKey)
		}
		if driverLocation != nil {
			dictionary.updateValue(driverLocation!, forKey: kDetailsDriverLocationKey)
		}
		if userId != nil {
			dictionary.updateValue(userId!, forKey: kDetailsUserIdKey)
		}
		if driverLat != nil {
			dictionary.updateValue(driverLat!, forKey: kDetailsDriverLatKey)
		}
		if driverId != nil {
			dictionary.updateValue(driverId!, forKey: kDetailsDriverIdKey)
		}
		if rideId != nil {
			dictionary.updateValue(rideId!, forKey: kDetailsRideIdKey)
		}
		if driverLong != nil {
			dictionary.updateValue(driverLong!, forKey: kDetailsDriverLongKey)
		}

        return dictionary
    }

}
