//
//  CalculatorBrain.swift
//  CalcV3_0
//
//  Created by adminaccount on 10/6/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import Foundation

// =======
// Requirements: (* - is required, o - optional)
// (*) 1. Implement given interfaces
// (*) 2. Implement CalculatorInterface using:
//        - Reverse Polish notation algorithm
//        - NSExpression
//        - other ways are also possible
// (*) 3. Use child view controllers (input and output contollers)
// (o) 4. Cover BL with Unit tests
// (o) 5. Use UIStackView for buttons layout
// (o) 6. Additional panel with functions in landscape. Implement using Size Classes
// (*) 7. Add animation on button press (using CoreAnimation)
// (o) 8. Graphics of Function.sin, Function.cos, Function.tan (using CoreGraphics)

// MARK: Operations

//weak var delegate

class CalcBrain: ProcessDelegate {
    var initStack = [String]()
    var operationStack: [String: OperationStructure] =
        ["+": OperationStructure(priopity:1, operation:additionFunc),
         "-": OperationStructure(priopity:1, operation:subtractionFunc),
         "*": OperationStructure(priopity:2, operation:multiplicationFunc),
         "/": OperationStructure(priopity:2, operation:divisionFunc),
         "%": OperationStructure(priopity:3, operation:percentFunc),
         "^": OperationStructure(priopity:3, operation:powerToFunc),
         "√": OperationStructure(priopity:4, operation:sqrDouble),
         "sin": OperationStructure(priopity:4, operation:trigSin),
         "cos": OperationStructure(priopity:4, operation:trigCos),
         "tg": OperationStructure(priopity:4, operation:trigTg),
         "log": OperationStructure(priopity:4, operation:trigLog) ]

    init(){
         //Operation.minus(value: "-", priopity: 1, operation: divisionFunc(first:second:))
    }
    
    func getNextItem()->String{
        //if initStack.isEmpty {return 0}
        var tmp = initStack.removeLast()
        switch tmp{
        case "*", "/", "+", "-", "%", "^", ")":
            return tmp
        case "sin", "cos", "tg", "log", "√":
             return tmp
        case "!":
            return tmp
        case "(":
            return tmp
        case "π":
            return "3.14159"
        case "e":
            return "2.71828"
        default:
            var newNumber = tmp
            if initStack.isEmpty { return newNumber}
            else {tmp = initStack.removeLast()}
            while (tmp == "0")||(tmp == "1")||(tmp == "2")||(tmp == "3")||(tmp == "4")||(tmp == "5")||(tmp == "6")||(tmp == "7")||(tmp == "8")||(tmp == "9")||(tmp == "."){
                newNumber += tmp
                print(newNumber)
                if initStack.isEmpty { return newNumber}
                else { tmp = initStack.removeLast() }
            }
            initStack.append(tmp)
            return newNumber
        }
        
    }
    
    func getMiddleResult(argument: Double)->Double{
        if initStack.isEmpty {//error
            return 0//operationStack[currentOperation]!.operation(argument, argumentSecond)
        }
        var argumentSecond = 0.0
        var nextOperation = ""
        
        
        var currentOperation = getNextItem()
        
        
        if currentOperation == "!" {
             argumentSecond = 1.0
        }
        else{}
        let checkIfNumber = getNextItem()
        
        if (checkIfNumber == "sin")||(checkIfNumber == "cos")||(checkIfNumber == "tg")||(checkIfNumber == "log")||(checkIfNumber == "√"){
            //really need to fix this
            argumentSecond = 1.0
            nextOperation = checkIfNumber
        }
        else {
            argumentSecond = Double(checkIfNumber)!
            nextOperation = getNextItem()
        }
        
        if initStack.isEmpty {
            print(argument)
            return operationStack[currentOperation]!.operation(argument, argumentSecond)
        }
        if (currentOperation == "-"){
            currentOperation = "+"
            argumentSecond = argumentSecond * (-1)
        }
        
        if  operationStack[currentOperation]!.priopity >= operationStack[nextOperation]!.priopity{
            initStack.append(nextOperation)
            return getMiddleResult(argument: operationStack[currentOperation]!.operation(argument, argumentSecond))
        }
        initStack.append(nextOperation) 
        
        return operationStack[currentOperation]!.operation(argument, getMiddleResult(argument: argumentSecond))
        
    }
    
    func processing(input: [String])->Double{
        initStack = input
        if initStack.isEmpty {return 0}
        let first = getNextItem()
        if first == "-" {
            initStack.append(first)
            return getMiddleResult(argument: 0)
        }
        else{
            return getMiddleResult(argument: Double(first)!)
        }
     }
    
}

func additionFunc(first:Double, second:Double)->Double{
    return first+second
}
func subtractionFunc(first:Double, second:Double)->Double{
    return first-second
}
func multiplicationFunc(first:Double, second:Double)->Double{
    return first*second
}
func divisionFunc(first:Double, second:Double)->Double{
   /* var result = first/second
    
    switch result {
    case Success(let quotient):
        doSomethingWithResult(quotient)
    case Failure(let errString):
        println(errString)
    }
    
    //0000!!!!!
    if(second == 0) {
        print("error")
        return 0
        
    }*/
    return first/second
}
func percentFunc(first:Double, second:Double)->Double{
    return first*second/100
}
func powerToFunc(first:Double, second:Double)->Double{
    if second < 0 {return 0}
    if second == 0 { return 1 }
    var result = Double(Int64.max)
    result = first
    var count  = second - 1
    while count>0{
        result *= first
        count = count - 1
    }
    return result
}
//////////////////////////////
func trigSin(argument: Double, _ :Double)->Double{
    return sin(argument)
}
func trigCos(argument: Double, _ :Double)->Double{
    return cos(argument)
}
func trigTg(argument: Double, _ :Double)->Double{
    return tan(argument)
}
func trigLog(argument: Double, _ :Double)->Double{
    return log(argument)
}
func sqrDouble(argument: Double, _ :Double)->Double{
    return sqrt(argument)
}
////////////////
func factorial(argument:Double)->Double{
    let result:Double = 1
    
    return result
}
/*
enum Result<T> {
    case Success(T)
    case Failure(String)
}
*/
////////////

struct OperationStructure{
    var priopity: Int
    var operation: (Double, Double)->Double
}

enum Operation {
    /*struct plus{
        var value: String = "+"
        var priopity: Int = 2
        func additionFunc(first:Double, second:Double)->Double{
            return first+second
        }
    }*/
    case minus(
        value: String,
        priopity: Int,
        operation: (Double, Double)->Double
    )
    case mult(
        value: String,
        priopity: Int,
        operation: (Double, Double)->Double
    )
    case div(
        value: String,
        priopity: Int,
        operation: (Double, Double)->Double
    )
    case exp(
        value: String,
        priopity: Int,
        operation: (Double, Double)->Double
    )
    case percent(
        value: String,
        priopity: Int,
        operation: (Double, Double)->Double
    )
 
}



enum Function: String {
    case sqrt    = "√"
    case sin     = "sin"
    case cos     = "cos"
    case tan     = "tan"
    case sinh    = "sinh"
    case cosh    = "cosh"
    case tanh    = "tanh"
    case ln      = "ln"
    case log     = "log"
    case fact    = "x!"
    case sign    = "+/-"
}

enum Memory: String {
    case memoryClean  = "mc"
    case memoryAdd    = "m+"
    case memoryRemove = "m-"
    case clean        = "C"
    case allClean     = "AC"
}

enum Utility: String {
    case dot          = "."
    case leftBracket  = "("
    case rightBracket = ")"
}

enum Constants: String {
    case pi = "π"
    case e  = "e"
}

/*
// MARK: Protocols
protocol InputInterface {
    func symbolPressed(_ symbol: String)
}

protocol OutputInterface {
    func display(_ result: String)
}

protocol CalculatorInterface {
    func digit(_ value: Double)
    func operation(_ operation: Operation)
    func function(_ function: Function)
    func memory(_ memory: Memory)
    func utility(_ utility: Utility)
    var resultClosure: ((Double?, Error?) -> Void) { get set }
}
*/
