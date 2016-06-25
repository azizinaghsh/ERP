//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let date : NSDate = NSDate ()
let dateString : String = NSDateFormatter.localizedStringFromDate(date, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
let format : NSDateFormatter = NSDateFormatter ()

let RFC3339DateFormatter = NSDateFormatter()
//RFC3339DateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
RFC3339DateFormatter.dateStyle = .MediumStyle
RFC3339DateFormatter.timeStyle = .ShortStyle

let date2 = RFC3339DateFormatter.dateFromString(dateString)
