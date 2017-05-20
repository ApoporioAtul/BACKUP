//
//  SocialTokenModel.swift
//
//  Created by AppOrio on 24/01/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class SocialTokenModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSocialTokenModelResultKey: String = "result"
	internal let kSocialTokenModelMsgKey: String = "msg"


    // MARK: Properties
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
		result = json[kSocialTokenModelResultKey].int
		msg = json[kSocialTokenModelMsgKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if result != nil {
			dictionary.updateValue(result!, forKey: kSocialTokenModelResultKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!, forKey: kSocialTokenModelMsgKey)
		}

        return dictionary
    }

}
