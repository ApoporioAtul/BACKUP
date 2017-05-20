//
//  Msg.swift
//
//  Created by AppOrio on 19/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DriverLocationMsg: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kMsgDriverIdKey: String = "driver_id"
    internal let kMsgDriverLatKey: String = "driver_lat"
    internal let kMsgDriverLongKey: String = "driver_long"
    
    
    // MARK: Properties
    public var driverId: String?
    public var driverLat: String?
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
        driverId = json[kMsgDriverIdKey].string
        driverLat = json[kMsgDriverLatKey].string
        driverLong = json[kMsgDriverLongKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if driverId != nil {
            dictionary.updateValue(driverId!, forKey: kMsgDriverIdKey)
        }
        if driverLat != nil {
            dictionary.updateValue(driverLat!, forKey: kMsgDriverLatKey)
        }
        if driverLong != nil {
            dictionary.updateValue(driverLong!, forKey: kMsgDriverLongKey)
        }
        
        return dictionary
    }

}
