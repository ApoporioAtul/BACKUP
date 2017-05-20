//
//  VerifyPhoneModel.swift
//
//  Created by AppOrio on 24/01/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class VerifyPhoneModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kVerifyPhoneModelDetailsKey: String = "details"
	internal let kVerifyPhoneModelResultKey: String = "result"
	internal let kVerifyPhoneModelMsgKey: String = "msg"


    // MARK: Properties
	public var details: VerifyPhoneDetails?
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
		details = VerifyPhoneDetails(json: json[kVerifyPhoneModelDetailsKey])
		result = json[kVerifyPhoneModelResultKey].int
		msg = json[kVerifyPhoneModelMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if details != nil {
			dictionary.updateValue(details!.dictionaryRepresentation(), forKey: kVerifyPhoneModelDetailsKey)
		}
		if result != nil {
			dictionary.updateValue(result!, forKey: kVerifyPhoneModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!, forKey: kVerifyPhoneModelMsgKey)
		}

        return dictionary
    }

}
