//
//  DriverSyncModel.swift
//
//  Created by AppOrio on 10/03/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DriverSyncModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDriverSyncModelDetailsKey: String = "details"
	internal let kDriverSyncModelResultKey: String = "result"
	internal let kDriverSyncModelMsgKey: String = "msg"


    // MARK: Properties
	public var details: DriverSyncDetails?
	public var result: Int?
	public var msg: String?


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
		details = DriverSyncDetails(json: json[kDriverSyncModelDetailsKey])
		result = json[kDriverSyncModelResultKey].int
		msg = json[kDriverSyncModelMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if details != nil {
			dictionary.updateValue(details!.dictionaryRepresentation(), forKey: kDriverSyncModelDetailsKey)
		}
		if result != nil {
			dictionary.updateValue(result!, forKey: kDriverSyncModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!, forKey: kDriverSyncModelMsgKey)
		}

        return dictionary
    }

}
