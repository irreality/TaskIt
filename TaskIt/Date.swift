//
//  Date.swift
//  TaskIt
//
//  Created by Sami on 17/03/15.
//  Copyright (c) 2015 Sami Paju. All rights reserved.
//

import Foundation

class Date {
    
    class func from (#year:Int, month: Int, day: Int) -> NSDate {
        
        // #year parametri on alla tunnistettu kuitenkin muodossa year, ilman # merkkiä. # edessä meinaa, että se näkyy jotenkin myöhemmin debuggauksessa(?) tai jotain.
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        
        var date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
    
    
    class func toString(#date:NSDate) -> String {
        
        // "NSdate formatter"
        
        let dateStringFormatter = NSDateFormatter()
        
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        // MM for months, mm for minutes.
        
        let dateString = dateStringFormatter.stringFromDate(date)

        return dateString
    }
    
    

}
