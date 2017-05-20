//
//  Details.swift
//
//  Created by AppOrio on 20/12/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RateCardDetails: NSObject {


    internal let kDetailsBaseWatingPriceKey: String = "base_wating_price"
    internal let kDetailsPricePerRideMinuteKey: String = "price_per_ride_minute"
    internal let kDetailsCityIdKey: String = "city_id"
    internal let kDetailsBaseRideMinutePriceKey: String = "base_ride_minute_price"
    internal let kDetailsWatingPriceMinuteKey: String = "wating_price_minute"
    internal let kDetailsCarTypeIdKey: String = "car_type_id"
    internal let kDetailsRateCardIdKey: String = "rate_card_id"
    internal let kDetailsBaseMilesKey: String = "base_miles"
    internal let kDetailsBasePriceMilesKey: String = "base_price_miles"
    internal let kDetailsBaseWatingTimeKey: String = "base_wating_time"
    internal let kDetailsBaseRideMinutesKey: String = "base_ride_minutes"
    internal let kDetailsBasePricePerUnitKey: String = "base_price_per_unit"
    
    
    // MARK: Properties
    public var baseWatingPrice: String?
    public var pricePerRideMinute: String?
    public var cityId: String?
    public var baseRideMinutePrice: String?
    public var watingPriceMinute: String?
    public var carTypeId: String?
    public var rateCardId: String?
    public var baseMiles: String?
    public var basePriceMiles: String?
    public var baseWatingTime: String?
    public var baseRideMinutes: String?
    public var basePricePerUnit: String?
    
    
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
        baseWatingPrice = json[kDetailsBaseWatingPriceKey].string
        pricePerRideMinute = json[kDetailsPricePerRideMinuteKey].string
        cityId = json[kDetailsCityIdKey].string
        baseRideMinutePrice = json[kDetailsBaseRideMinutePriceKey].string
        watingPriceMinute = json[kDetailsWatingPriceMinuteKey].string
        carTypeId = json[kDetailsCarTypeIdKey].string
        rateCardId = json[kDetailsRateCardIdKey].string
        baseMiles = json[kDetailsBaseMilesKey].string
        basePriceMiles = json[kDetailsBasePriceMilesKey].string
        baseWatingTime = json[kDetailsBaseWatingTimeKey].string
        baseRideMinutes = json[kDetailsBaseRideMinutesKey].string
        basePricePerUnit = json[kDetailsBasePricePerUnitKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if baseWatingPrice != nil {
            dictionary.updateValue(baseWatingPrice!, forKey: kDetailsBaseWatingPriceKey)
        }
        if pricePerRideMinute != nil {
            dictionary.updateValue(pricePerRideMinute!, forKey: kDetailsPricePerRideMinuteKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId!, forKey: kDetailsCityIdKey)
        }
        if baseRideMinutePrice != nil {
            dictionary.updateValue(baseRideMinutePrice!, forKey: kDetailsBaseRideMinutePriceKey)
        }
        if watingPriceMinute != nil {
            dictionary.updateValue(watingPriceMinute!, forKey: kDetailsWatingPriceMinuteKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId!, forKey: kDetailsCarTypeIdKey)
        }
        if rateCardId != nil {
            dictionary.updateValue(rateCardId!, forKey: kDetailsRateCardIdKey)
        }
        if baseMiles != nil {
            dictionary.updateValue(baseMiles!, forKey: kDetailsBaseMilesKey)
        }
        if basePriceMiles != nil {
            dictionary.updateValue(basePriceMiles!, forKey: kDetailsBasePriceMilesKey)
        }
        if baseWatingTime != nil {
            dictionary.updateValue(baseWatingTime!, forKey: kDetailsBaseWatingTimeKey)
        }
        if baseRideMinutes != nil {
            dictionary.updateValue(baseRideMinutes!, forKey: kDetailsBaseRideMinutesKey)
        }
        if basePricePerUnit != nil {
            dictionary.updateValue(basePricePerUnit!, forKey: kDetailsBasePricePerUnitKey)
        }
        
        return dictionary
    }
    
}


    // MARK: Declaration for string constants to be used to decode and also serialize.
   /* internal let kDetailsBasePriceMinuteKey: String = "base_price_minute"
    internal let kDetailsRateCardIdKey: String = "rate_card_id"
    internal let kDetailsBasePriceMinuteWaitingKey: String = "base_price_minute_waiting"
    internal let kDetailsExtraChargesKey: String = "extra_charges"
    internal let kDetailsBaseMinutesKey: String = "base_minutes"
    internal let kDetailsCityIdKey: String = "city_id"
    internal let kDetailsPricePerMileKey: String = "price_per_mile"
    internal let kDetailsCarTypeIdKey: String = "car_type_id"
    internal let kDetailsBaseMilesKey: String = "base_miles"
    internal let kDetailsBasePriceMilesKey: String = "base_price_miles"
    internal let kDetailsPricePerMinuteKey: String = "price_per_minute"
    internal let kDetailsPricePerMinuteWaitingKey: String = "price_per_minute_waiting"
    internal let kDetailsBaseWaitingMinutesKey: String = "base_waiting_minutes"
    
    
    // MARK: Properties
    public var basePriceMinute: String?
    public var rateCardId: String?
    public var basePriceMinuteWaiting: String?
    public var extraCharges: String?
    public var baseMinutes: String?
    public var cityId: String?
    public var pricePerMile: String?
    public var carTypeId: String?
    public var baseMiles: String?
    public var basePriceMiles: String?
    public var pricePerMinute: String?
    public var pricePerMinuteWaiting: String?
    public var baseWaitingMinutes: String?
    
    
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
        basePriceMinute = json[kDetailsBasePriceMinuteKey].string
        rateCardId = json[kDetailsRateCardIdKey].string
        basePriceMinuteWaiting = json[kDetailsBasePriceMinuteWaitingKey].string
        extraCharges = json[kDetailsExtraChargesKey].string
        baseMinutes = json[kDetailsBaseMinutesKey].string
        cityId = json[kDetailsCityIdKey].string
        pricePerMile = json[kDetailsPricePerMileKey].string
        carTypeId = json[kDetailsCarTypeIdKey].string
        baseMiles = json[kDetailsBaseMilesKey].string
        basePriceMiles = json[kDetailsBasePriceMilesKey].string
        pricePerMinute = json[kDetailsPricePerMinuteKey].string
        pricePerMinuteWaiting = json[kDetailsPricePerMinuteWaitingKey].string
        baseWaitingMinutes = json[kDetailsBaseWaitingMinutesKey].string
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if basePriceMinute != nil {
            dictionary.updateValue(basePriceMinute!, forKey: kDetailsBasePriceMinuteKey)
        }
        if rateCardId != nil {
            dictionary.updateValue(rateCardId!, forKey: kDetailsRateCardIdKey)
        }
        if basePriceMinuteWaiting != nil {
            dictionary.updateValue(basePriceMinuteWaiting!, forKey: kDetailsBasePriceMinuteWaitingKey)
        }
        if extraCharges != nil {
            dictionary.updateValue(extraCharges!, forKey: kDetailsExtraChargesKey)
        }
        if baseMinutes != nil {
            dictionary.updateValue(baseMinutes!, forKey: kDetailsBaseMinutesKey)
        }
        if cityId != nil {
            dictionary.updateValue(cityId!, forKey: kDetailsCityIdKey)
        }
        if pricePerMile != nil {
            dictionary.updateValue(pricePerMile!, forKey: kDetailsPricePerMileKey)
        }
        if carTypeId != nil {
            dictionary.updateValue(carTypeId!, forKey: kDetailsCarTypeIdKey)
        }
        if baseMiles != nil {
            dictionary.updateValue(baseMiles!, forKey: kDetailsBaseMilesKey)
        }
        if basePriceMiles != nil {
            dictionary.updateValue(basePriceMiles!, forKey: kDetailsBasePriceMilesKey)
        }
        if pricePerMinute != nil {
            dictionary.updateValue(pricePerMinute!, forKey: kDetailsPricePerMinuteKey)
        }
        if pricePerMinuteWaiting != nil {
            dictionary.updateValue(pricePerMinuteWaiting!, forKey: kDetailsPricePerMinuteWaitingKey)
        }
        if baseWaitingMinutes != nil {
            dictionary.updateValue(baseWaitingMinutes!, forKey: kDetailsBaseWaitingMinutesKey)
        }
        
        return dictionary
    }
    
}*/

