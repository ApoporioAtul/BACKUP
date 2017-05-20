//
//  Response.swift
//
//  Created by AppOrio on 23/08/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Response: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kResponseResultKey: String = "result"
	internal let kResponseMessageKey: String = "Message"


    // MARK: Properties
	public var result: Int?
	public var message: [NearCarMessage]?


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
		result = json[kResponseResultKey].int
		message = []
		if let items = json[kResponseMessageKey].array {
			for item in items {
				message?.append(NearCarMessage(json: item))
			}
		} else {
			message = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if result != nil {
			dictionary.updateValue(result!, forKey: kResponseResultKey)
		}
		if message?.count > 0 {
			var temp: [AnyObject] = []
			for item in message! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kResponseMessageKey)
		}

        return dictionary
    }

}
