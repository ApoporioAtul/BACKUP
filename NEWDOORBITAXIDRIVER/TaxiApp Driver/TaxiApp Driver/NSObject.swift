//
//  NSObject.swift
//  TaxiAppDriver
//
//  Created by Rakesh kumar on 23/08/16.
//  Copyright © 2016 Apporio. All rights reserved.
//

import KVNProgress

extension NSObject
    
{
    
    func onProgressState(value: Int) {
        
        
        if (value == 0)
        {
            KVNProgress.show()
        }
        
        
        if (value == 1)
        {
            KVNProgress.dismiss()
        }
        
    }
    
    func onErrorsState(message: String, errorCode: Int) {
        
        
        print("error Code is " , errorCode)
        
        KVNProgress.dismiss()
        
        if(errorCode == -1009)
        {
            KVNProgress.showErrorWithStatus(NSLocalizedString("The Internet connection appears to be offline", comment: ""))
            
            
        }
        if (errorCode == -1001)
        {
            KVNProgress.showErrorWithStatus(NSLocalizedString("The request timed out.", comment: ""))
            
            
        }
            
        else if(errorCode == -1012)
        {
            KVNProgress.showErrorWithStatus(NSLocalizedString("The operation couldn't be completed.", comment: ""))
            
            
        }
            
        else if(errorCode == -2102)
        {
            KVNProgress.showErrorWithStatus(NSLocalizedString("The request timed out.", comment: ""))
            
            
        }
            
            
        else if(errorCode == -1005)
        {
            KVNProgress.showErrorWithStatus(NSLocalizedString("The network connection was lost.", comment: ""))
            
            
        }
        else if(errorCode == -1003)
        {
            KVNProgress.showErrorWithStatus(NSLocalizedString("A server with the specified hostname could not be found.", comment: ""))
            
            
        }
            
            
        else {
            
            KVNProgress.showErrorWithStatus(NSLocalizedString("There Is SomeThing Wrong", comment: ""))
        }
        
        
        print(message)
        
        
        
    }
    
}