//
//  OTPModel.swift
//
//  Created by AppOrio on 24/01/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class OTPModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kOTPModelDetailsKey: String = "details"
	internal let kOTPModelResultKey: String = "result"
	internal let kOTPModelMsgKey: String = "msg"


    // MARK: Properties
	public var details: OTPDetails?
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
		details = OTPDetails(json: json[kOTPModelDetailsKey])
		result = json[kOTPModelResultKey].int
		msg = json[kOTPModelMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if details != nil {
			dictionary.updateValue(details!.dictionaryRepresentation(), forKey: kOTPModelDetailsKey)
		}
		if result != nil {
			dictionary.updateValue(result!, forKey: kOTPModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!, forKey: kOTPModelMsgKey)
		}

        return dictionary
    }

}
