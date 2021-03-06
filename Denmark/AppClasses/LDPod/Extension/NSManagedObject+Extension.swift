//
//  NSManagedObject+Extension.swift
//  Pods
//
//  Created by Lokesh on 09/05/16.
//
//

import Foundation
import CoreData


// MARK: - NSManagedObject Extension -
extension NSManagedObject{
    
    // Class method that transforms NSObjects from Dictionaries into NSManagedObjects. the method creates an NSObject which is then populated
    class func createNewObject<T:NSManagedObject>(_ context: NSManagedObjectContext)-> T {
        let name = self.classForCoder().description().pathExtension!
        let newObject =  NSEntityDescription.insertNewObject(forEntityName: name, into: context) as! T
        return newObject
    }
}
