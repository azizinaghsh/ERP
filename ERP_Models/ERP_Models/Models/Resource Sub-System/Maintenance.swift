//
//  Maintenance.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 6/25/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Cocoa

class Maintenance: NSObject {
    var maintainers : Array<HumanResource> = []
    var describe : String = ""
    var modificationDate : String
    
    init (maintainersAre maintainers : [HumanResource], descriptionIs description: String, modificationDateIs date:String?)
    {
        self.maintainers = maintainers
        describe = description
        if (date == nil)
        {
            self.modificationDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        }
        else
        {
            self.modificationDate = date!
        }
    }
    
    func SetModificationDate (setTo date:String)
    {
        modificationDate = date
    }
}
