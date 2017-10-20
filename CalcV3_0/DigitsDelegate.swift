//
//  DigitsDelegate.swift
//  CalcV3_0
//
//  Created by adminaccount on 10/6/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation

protocol DigitsDelegate:class{
    //var customInput = [String]() {get set}
    func refreshLabel(_ symbol: String)
}
protocol ResultDelegate:class{
    func display(_ result: String)
}
protocol ProcessDelegate:class{
    func processing(input: [String])->Double
}
enum TeslaError: Error {
    case lostGPS
    case lowBattery
}
enum Result<T> {
    case Success(T)
    case Failure(String)
}
/*
 
 var result = divide(2.5, by:3)
 
 switch result {
 case Success(let quotient):
 doSomethingWithResult(quotient)
 case Failure(let errString):
 println(errString)
 }
 *********
protocol OperationStructure{
    var priopity: Int {get set}
    var operation: (Double, Double)->Double {get set}
}
 */
/*
 let willbeNumber = getNextItem()!
 let a = Double(willbeNumber)
 
 let o = getNextItem()!
 
 let willbeNumberTwo = getNextItem()!
 let b = Double(willbeNumberTwo)*/
/*var verTwo = argumentTwo
 print("begin")
 if initStack.isEmpty {
 print("end")
 return (operationStack[typeOfOperation]?.operation(argumentOne, argumentTwo))!
 //why????
 }
 else {
 print("full")
 let nextOperation = getNextItem()!
 if nextOperation == ")" {
 return (operationStack[typeOfOperation]?.operation(argumentOne, argumentTwo))!
 }
 var willbeNumber = getNextItem()!
 
 if willbeNumber == "(" {
 let beNumber = getNextItem()!
 let newNumber = Double(beNumber)
 //here might be sin
 let nextBracketOperation = getNextItem()!
 //if nextBracketOperation == ")" { return newNumber}
 
 willbeNumber = getMiddleResult(argumentOne:newNumber, typeOfOperation:nextBracketOperation, argumentTwo:)
 }
 
 let nextNumber = Double(willbeNumber)
 
 if (operationStack[nextOperation]?.priopity)! > (operationStack[typeOfOperation]?.priopity)! {
 verTwo = getMiddleResult(argumentOne: argumentTwo, typeOfOperation: nextOperation, argumentTwo:nextNumber!)
 print("higher \(verTwo)")
 //return make (operationStack[typeOfOperation]?.operation(argumentOne, argumentTwo))!
 }
 print("not")
 return getMiddleResult(argumentOne:(operationStack[typeOfOperation]?.operation(argumentOne, verTwo))!, typeOfOperation: nextOperation, argumentTwo: nextNumber!)
 
 }
 func makeOperation(firstArgument: Double, operationType: String, secondArgument: Double)->Double{
 switch operationType{
 case "*":
 return firstArgument*secondArgument
 case "/":
 return firstArgument/secondArgument
 case "-":
 return firstArgument - secondArgument
 case "+":
 return firstArgument + secondArgument
 case "%":
 return secondArgument*firstArgument/100
 case "^":
 var result = firstArgument
 var count  = secondArgument - 1
 while count>0{
 result *= firstArgument
 count = count - 1
 }
 return result
 case "!":
 var result = firstArgument
 result *= result
 //for {}
 return result
 default:
 print("something went very wrong...")
 return 0
 }
 }
 */
/*
 need to put it somewhere else!!!
 let willbeNumber = getNextItem()!
 let first = Double(willbeNumber)
 
 let notNumber = getNextItem()!
 if notNumber == ")" {return willbeNumber}
 
 let willbeNumberTwo = getNextItem()!
 let second = Double(willbeNumberTwo)
 
 return getMiddleResult(firstArgument: first!, operationType: notNumber, secondArgument: second!)*/
/*
 struct addition: OperationStructure {
 var priopity = 1
 var operation = additionFunc
 }
 struct subtraction: OperationStructure {
 var priopity = 1
 var operation = subtractionFunc
 }
 struct multiplication: OperationStructure {
 var priopity = 2
 var operation = multiplicationFunc
 }
 struct division: OperationStructure {
 var priopity = 2
 var operation = divisionFunc
 }
 struct percent: OperationStructure {
 var priopity = 3
 var operation = percentFunc
 }
 struct powerTo: OperationStructure {
 var priopity = 3
 var operation = powerToFunc
 }*/

