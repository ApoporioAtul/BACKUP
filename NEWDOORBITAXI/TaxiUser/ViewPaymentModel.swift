//
//  ViewPaymentModel.swift
//
//  Created by AppOrio on 01/03/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class ViewPaymentModel: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kViewPaymentModelResultKey: String = "result"
	internal let kViewPaymentModelMsgKey: String = "msg"


    // MARK: Properties
	public var result: Int?
	public var msg: [ViewPaymentMsg]?


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
		result = json[kViewPaymentModelResultKey].int
		msg = []
		if let items = json[kViewPaymentModelMsgKey].array {
			for item in items {
				msg?.append(ViewPaymentMsg(json: item))
			}
		} else {
			msg = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if result != nil {
			dictionary.updateValue(result!, forKey: kViewPaymentModelResultKey)
		}
		if msg?.count > 0 {
			var temp: [AnyObject] = []
			for item in msg! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kViewPaymentModelMsgKey)
		}

        return dictionary
    }

}
