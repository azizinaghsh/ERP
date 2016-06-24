//: Playground - noun: a place where people can play

import Cocoa

class A : NSObject
{
        override init ()
        {
            
    }
    
    static func TestType<T> (type : T.Type)
    {
        if (type is A)
        {
            print ("IS A")
            return
        }
        print ("NOT A")
    }
}
var B : A = A()

A.TestType(A.self)
