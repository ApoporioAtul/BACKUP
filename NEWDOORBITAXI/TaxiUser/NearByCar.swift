//
//  NearByCar.swift
//
//  Created by AppOrio on 23/08/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class NearByCar: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kNearByCarResponseKey: String = "response"


    // MARK: Properties
	public var response: Response?


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
		response = Response(json: json[kNearByCarResponseKey])

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if response != nil {
			dictionary.updateValue(response!.dictionaryRepresentation(), forKey: kNearByCarResponseKey)
		}

        return dictionary
    }

}
