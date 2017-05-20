//
//  Msg.swift
//
//  Created by AppOrio on 24/01/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CarsTimeMsg: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kMsgCarTypeIdKey: String = "car_type_id"
    internal let kMsgBaseFareKey: String = "base_fare"
	internal let kMsgDistanceKey: String = "distance"
	internal let kMsgCarTypeNameKey: String = "car_type_name"
	internal let kMsgCityIdKey: String = "city_id"
	internal let kMsgCarTypeImageKey: String = "car_type_image"
    internal let kMsgCarNameOtherKey: String = "car_name_other"

    // MARK: Properties
	public var carTypeId: String?
    public var baseFare: String?
	public var distance: String?
	public var carTypeName: String?
	public var cityId: String?
	public var carTypeImage: String?
   public var carNameOther: String?


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
		carTypeId = json[kMsgCarTypeIdKey].string
        baseFare = json[kMsgBaseFareKey].string
		distance = json[kMsgDistanceKey].string
		carTypeName = json[kMsgCarTypeNameKey].string
		cityId = json[kMsgCityIdKey].string
		carTypeImage = json[kMsgCarTypeImageKey].string
        carNameOther = json[kMsgCarNameOtherKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if carTypeId != nil {
			dictionary.updateValue(carTypeId!, forKey: kMsgCarTypeIdKey)
		}
        if baseFare != nil {
            dictionary.updateValue(baseFare!, forKey: kMsgBaseFareKey)
        }
		if distance != nil {
			dictionary.updateValue(distance!, forKey: kMsgDistanceKey)
		}
		if carTypeName != nil {
			dictionary.updateValue(carTypeName!, forKey: kMsgCarTypeNameKey)
		}
		if cityId != nil {
			dictionary.updateValue(cityId!, forKey: kMsgCityIdKey)
		}
		if carTypeImage != nil {
			dictionary.updateValue(carTypeImage!, forKey: kMsgCarTypeImageKey)
		}
        if carNameOther != nil {
            dictionary.updateValue(carNameOther!, forKey: kMsgCarNameOtherKey)
        }

        return dictionary
    }

}
