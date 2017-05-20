//
//  Details.swift
//
//  Created by Rakesh kumar on 19/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DetailsAbout: NSObject {

    // MARK: Declaration for string constants to be used to decode and also serialize.

    
    internal let kDetailsTitleKey: String = "title"
    internal let kDetailsPageIdKey: String = "page_id"
    internal let kDetailsDescriptionOtherKey: String = "description_other"
    internal let kDetailsTitleOtherKey: String = "title_other"
    internal let kDetailsDescriptionValueKey: String = "description"
    
    
    // MARK: Properties
    public var title: String?
    public var pageId: String?
    public var descriptionOther: String?
    public var titleOther: String?
    public var descriptionValue: String?
    
    
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
        title = json[kDetailsTitleKey].string
        pageId = json[kDetailsPageIdKey].string
        descriptionOther = json[kDetailsDescriptionOtherKey].string
        titleOther = json[kDetailsTitleOtherKey].string
        descriptionValue = json[kDetailsDescriptionValueKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if title != nil {
            dictionary.updateValue(title!, forKey: kDetailsTitleKey)
        }
        if pageId != nil {
            dictionary.updateValue(pageId!, forKey: kDetailsPageIdKey)
        }
        if descriptionOther != nil {
            dictionary.updateValue(descriptionOther!, forKey: kDetailsDescriptionOtherKey)
        }
        if titleOther != nil {
            dictionary.updateValue(titleOther!, forKey: kDetailsTitleOtherKey)
        }
        if descriptionValue != nil {
            dictionary.updateValue(descriptionValue!, forKey: kDetailsDescriptionValueKey)
        }
        
        return dictionary
    }
    
}



/*	internal let kDetailsTitleKey: String = "title"
	internal let kDetailsPageIdKey: String = "page_id"
	internal let kDetailsDescKey: String = "description"
	internal let kDetailsTitleArabicKey: String = "title_arabic"
	internal let kDetailsTitleDescriptionKey: String = "title_description"


    // MARK: Properties
	public var title: String?
	public var pageId: String?
	public var desc: String?
	public var titleArabic: String?
	public var titleDescription: String?


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
		title = json[kDetailsTitleKey].string
		pageId = json[kDetailsPageIdKey].string
		desc = json[kDetailsDescKey].string
		titleArabic = json[kDetailsTitleArabicKey].string
		titleDescription = json[kDetailsTitleDescriptionKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if title != nil {
			dictionary.updateValue(title!, forKey: kDetailsTitleKey)
		}
		if pageId != nil {
			dictionary.updateValue(pageId!, forKey: kDetailsPageIdKey)
		}
		if desc != nil {
			dictionary.updateValue(desc!, forKey: kDetailsDescKey)
		}
		if titleArabic != nil {
			dictionary.updateValue(titleArabic!, forKey: kDetailsTitleArabicKey)
		}
		if titleDescription != nil {
			dictionary.updateValue(titleDescription!, forKey: kDetailsTitleDescriptionKey)
		}

        return dictionary
    }

}*/
