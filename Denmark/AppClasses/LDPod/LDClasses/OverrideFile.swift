//
//  OverrideFile.swift
//  Pods
//
//  Created by Lokesh on 05/05/16.
//
//

import Foundation

// MARK: infix operator
infix operator <->
infix operator ++=
infix operator ++
infix operator --
infix operator --=

//MARK: - Date -
func <= (lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
}
func >= (lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
}
func > (lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
}
func < (lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}
func + (date: Date, tuple: (value: Int, unit: Calendar.Component)) -> Date {
    return Calendar.current.date(byAdding: tuple.unit, value: tuple.value, to: date, wrappingComponents: true)!
}
func - (date: Date, tuple: (value: Int, unit: Calendar.Component)) -> Date {
    return Calendar.current.date(byAdding: tuple.unit, value: -tuple.value, to: date, wrappingComponents: true)!
}
func += ( date: inout Date, tuple: (value: Int, unit: Calendar.Component)) {
    date =  Calendar.current.date(byAdding: tuple.unit, value: tuple.value, to: date, wrappingComponents: true)!
}
func -= ( date: inout Date, tuple: (value: Int, unit: Calendar.Component)) {
    date =  Calendar.current.date(byAdding: tuple.unit, value: -tuple.value, to: date, wrappingComponents: true)!
}


//MARK: - String -
func <-> (lhs: String, rhs: String) -> Bool {
    return (lhs.lowercased() == rhs.lowercased())
}
func + (lhs: NSArray, rhs: NSObject) -> NSArray {
    return lhs.adding(rhs) as NSArray
}
func + <T : Equatable>( lhs: inout [T], rhs: T) {
    lhs.append(rhs)
}
func - <T : Equatable>( lhs: inout [T], rhs: T) {
    if let index = lhs.index(of: rhs) {
        lhs.remove(at: index)
    }
}
func += ( array: inout NSArray, object: NSObject) {
    array = array + object
}
func - (array: NSArray, object: NSObject) -> NSArray {
    let mutableArray = NSMutableArray(array: array)
    mutableArray.remove(object)
    return NSArray(array: mutableArray)
}
func -= ( array: inout NSArray, object: NSObject) {
    array = array - object
}
func ++ (left: NSArray, right: NSArray) -> NSArray {
    return left.addingObjects(from: right as [AnyObject]) as NSArray
}
func ++= ( left: inout NSArray, right: NSArray) {
    left = left ++ right
}
func + (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.adding(right)
}

func + (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    let decimalRight:NSDecimalNumber = NSDecimalNumber(value: right.doubleValue)
    return left.adding(decimalRight);
}
func + (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    let decimalLeft:NSDecimalNumber = NSDecimalNumber(value: left.doubleValue);
    return decimalLeft.adding(right);
}
func - (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.subtracting(right)
}
func - (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    let decimalRight:NSDecimalNumber = NSDecimalNumber(value: right.doubleValue);
    return left.subtracting(decimalRight);
}
func - (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    let decimalLeft:NSDecimalNumber = NSDecimalNumber(value: left.doubleValue);
    return decimalLeft.subtracting(right);
}
func * (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return right.multiplying(by: right)
}
func * (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    let decimalRight:NSDecimalNumber = NSDecimalNumber(value: right.doubleValue);
    return left.multiplying(by: decimalRight);
}
func * (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    let decimalLeft:NSDecimalNumber = NSDecimalNumber(value: left.doubleValue);
    return decimalLeft.multiplying(by: right);
}
func / (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.dividing(by: right)
}
func / (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    let decimalRight:NSDecimalNumber = NSDecimalNumber(value: right.doubleValue);
    return left.dividing(by: decimalRight);
}
func / (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    let decimalLeft:NSDecimalNumber = NSDecimalNumber(value: left.doubleValue);
    return decimalLeft.dividing(by: right);
}
func += ( left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left + right
}
func -= ( left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left - right
}
func *= ( left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left * right
}
func /= ( left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left / right
}
prefix func ++ ( operand: inout NSDecimalNumber) -> NSDecimalNumber {
    operand += NSDecimalNumber.one
    return operand
}
postfix func ++ ( operand: inout NSDecimalNumber) -> NSDecimalNumber {
    let previousOperand = operand;
    ++operand
    return previousOperand
}
prefix func -- ( operand: inout NSDecimalNumber) -> NSDecimalNumber {
    operand -= NSDecimalNumber.one
    return operand
}
postfix func -- ( operand: inout NSDecimalNumber) -> NSDecimalNumber {
    let previousOperand = operand;
    --operand
    return previousOperand
}
func + (left: NSNumber, right: NSNumber) -> NSNumber {
    return left + right
}
func - (left: NSNumber, right: NSNumber) -> NSNumber {
    return left - right
}
func * (left: NSNumber, right: NSNumber) -> NSNumber {
    return left * right
}
func / (left: NSNumber, right: NSNumber) -> NSNumber {
    return left / right
}
func += ( left: inout NSNumber, right: NSNumber) {
    left = left + right
}
func -= ( left: inout NSNumber, right: NSNumber) {
    left = left - right
}
func *= ( left: inout NSNumber, right: NSNumber) {
    left = left * right
}
func /= ( left: inout NSNumber, right: NSNumber) {
    left = left / right
}
prefix func ++ ( operand: inout NSNumber) -> NSNumber {
    operand = operand + 1.0
    return operand
}
postfix func ++ ( operand: inout NSNumber) -> NSNumber {
    let previousOperand = operand;
    ++operand
    return previousOperand
}
prefix func -- ( operand: inout NSNumber) -> NSNumber {
    operand = operand - 1.0
    return operand
}
postfix func -- ( operand: inout NSNumber) -> NSNumber {
    let previousOperand = operand;
    --operand
    return previousOperand
}
func + (set: NSSet, object: NSObject) -> NSSet {
    return set.adding(object) as NSSet
}
func += ( set: inout NSSet, object: NSObject) {
    set = set + object
}
func - (set: NSSet, object: NSObject) -> NSSet {
    let mutableSet = NSMutableSet(set: set)
    mutableSet.remove(object)
    return mutableSet
}
func -= ( set: inout NSSet, object: NSObject) {
    set = set - object
}
func ++ (left: NSSet, right: NSSet) -> NSSet {
    return left.adding(right) as NSSet
}

func ++ (left: NSSet, right: NSArray) -> NSSet {
    return left.adding(right) as NSSet
}
func ++= ( left: inout NSSet, right: NSSet) {
    left = left ++ right
}
func ++= ( left: inout NSSet, right: NSArray) {
    left = left ++ right
}
func -- (left: NSSet, right: NSSet) -> NSSet {
    let resultSet = NSMutableSet(set: left)
    resultSet.minus(right as Set<NSObject>)
    return NSSet(set: resultSet)
}
func -- (left: NSSet, right: NSArray) -> NSSet {
    let resultSet = NSMutableSet(set: left)
    resultSet.minus(Set(arrayLiteral: right))
    return NSSet(set: resultSet)
}
func --= ( left: inout NSSet, right: NSSet) {
    left = left -- right
}
func --= ( left: inout NSSet, right: NSArray) {
    left = left -- right
}
func + (dictionary: NSDictionary, tuple: (NSObject: NSCopying, NSObject)) -> NSDictionary {
    let resultDictionary = NSMutableDictionary(dictionary: dictionary as! [AnyHashable : Any])
    resultDictionary.setObject(tuple.1, forKey: tuple.0)
    return resultDictionary
}
func += ( dictionary: inout NSDictionary, tuple: (NSObject: NSCopying, NSObject)) {
    dictionary = dictionary + tuple
}
func ++ (left: NSDictionary, right: NSDictionary) -> NSDictionary {
    let resultDictionary = NSMutableDictionary(dictionary: left as! [AnyHashable : Any])
    resultDictionary.addEntries(from: right as! [AnyHashable: Any])
    return resultDictionary
}
func ++= ( left: inout NSDictionary, right: NSDictionary) {
    left = left ++ right
}
func - ( lhs: inout String, rhs: String) {
    lhs = lhs.replacingOccurrences(of: rhs, with: "")
}
func uniq<S: Sequence, E: Hashable>(_ source: S) -> [E] where E==S.Iterator.Element {
    var seen: [E:Bool] = [:]
    return source.filter { seen.updateValue(true, forKey: $0) == nil }
}
