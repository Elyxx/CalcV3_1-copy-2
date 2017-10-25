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
        ["+": OperationStructure(priority:1, operation:additionFunc),
         "-": OperationStructure(priority:1, operation:subtractionFunc),
         "*": OperationStructure(priority:2, operation:multiplicationFunc),
         "/": OperationStructure(priority:2, operation:divisionFunc),
         "%": OperationStructure(priority:3, operation:percentFunc),
         "^": OperationStructure(priority:3, operation:powerToFunc),
         "√": OperationStructure(priority:4, operation:sqrDouble),
         "sin": OperationStructure(priority:4, operation:trigSin),
         "cos": OperationStructure(priority:4, operation:trigCos),
         "tg": OperationStructure(priority:4, operation:trigTg),
         "log": OperationStructure(priority:4, operation:trigLog),
         "!": OperationStructure(priority:5, operation:factorial)]
    
    init(){
        //Operation.minus(value: "-", priopity: 1, operation: divisionFunc(first:second:))
    }
    func processing(input: [String])->Double{
        
        if input.isEmpty {return 0}
        initStack = []
        
        for item in input{
            
            switch item{
            case "sin", "cos", "tg", "log", "√":
                initStack.insert(item, at: 0)
                initStack.insert("1", at:0)
            case "!":
                initStack.insert("1", at:0)
                initStack.insert("!", at:0)
            default:
                initStack.insert(item, at:0)
            }
        }
        print("this is new stack")
        
        if initStack[0] == "-" {
            initStack.insert("0", at: 0)
        }
        if initStack[0] == "(" {
            initStack.insert("+", at: 0)
            initStack.insert("0", at: 0)
        }
        for item in initStack{            print(item)        }
        print("end of stack... i cannot wait for this DEMO to come... ")
        ///end of formatting
        return getMiddleResult(argument: Double(getNextItem())!)
    }
    
    func getNextItem()->String{
        if initStack.isEmpty {
            print("stack is empty")
            return "0"
        }
        var tmp = initStack.removeFirst()
        
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
            if initStack.isEmpty { return tmp }
            
            while (initStack[0] == "0")||(initStack[0] == "1")||(initStack[0] == "2")||(initStack[0] == "3")||(initStack[0] == "4")||(initStack[0] == "5")||(initStack[0] == "6")||(initStack[0] == "7")||(initStack[0] == "8")||(initStack[0] == "9")||(initStack[0] == "."){
                tmp = initStack.removeFirst()
                newNumber += tmp
                if initStack.isEmpty { return newNumber }
            }
            return newNumber
        }
        
    }
    
    func getMiddleResult(argument: Double)->Double{
        if initStack.isEmpty {
            return argument
        }
        var currentOperation = getNextItem()
        if currentOperation == ")" {         return argument        }
        var argumentSecond = 0.0
        
        if initStack[0] == "(" {
            initStack.removeFirst()
            while initStack.isEmpty == false && initStack[0] == "(" {
                initStack.removeFirst()
            }
            if initStack[0] == "-" {
                initStack.removeFirst()
                argumentSecond = getMiddleResult(argument: (-1)*Double(getNextItem())!)
            }
            else {
                argumentSecond = getMiddleResult(argument: Double(getNextItem())!)
            }
        }
        else {
            if initStack[0] == "-" {
                initStack.removeFirst()
                argumentSecond = (-1) * Double(getNextItem())!
            }
            else {
                argumentSecond = Double(getNextItem())!
            }
        }
        if initStack.isEmpty {
            return operationStack[currentOperation]!.operation(argument, argumentSecond)
        }
        if initStack[0] == ")" {
            initStack.removeFirst()
            while initStack.isEmpty == false && initStack[0] == ")" {
                initStack.removeFirst()
            }
            return operationStack[currentOperation]!.operation(argument, argumentSecond)
        }
        
        if (currentOperation == "-"){
            currentOperation = "+"
            argumentSecond = argumentSecond * (-1)
        }
        if  operationStack[currentOperation]!.priority >= operationStack[initStack[0]]!.priority{
            return getMiddleResult(argument: operationStack[currentOperation]!.operation(argument, argumentSecond))
        }
        return operationStack[currentOperation]!.operation(argument, getMiddleResult(argument: argumentSecond))
        
    }
    
    //func formatStack(input: [String]){    }
    
    
}
//end of class - how this happend??
func additionFunc(first:Double, second:Double)->Double{
    return first+second
}
func subtractionFunc(first:Double, second:Double)->Double{
    return first-second
}
func multiplicationFunc(first:Double, second:Double)->Double{
    return first*second
}
func divisionFunc(first:Double, second:Double)->Double {
    return first/second
}
func percentFunc(first:Double, second:Double)->Double{
    return first*second/100
}
func powerToFunc(first:Double, second:Double)->Double{
    if second == 0 { return 1 }
    var result = first
    var count  = second - 1
    while count>0{
        result *= first
        count = count - 1
    }
    if second < 0 {result = 1/result}
    return result
}
//////////////////////////////
func trigSin(_ : Double, argument :Double)->Double{
    return sin(argument)
}
func trigCos(_ : Double, argument :Double)->Double{
    return cos(argument)
}
func trigTg(_ : Double, argument :Double)->Double{
    return tan(argument)
}
func trigLog(_ : Double, argument :Double)->Double{
    return log(argument)
}
func sqrDouble(_ : Double, argument :Double)->Double{
    return sqrt(argument)
}
////////////////
func factorial(argument:Double, _ :Double)->Double{
    var result = argument
    var count = argument - 1
    //if not int
    while count > 1 {
        result = result*count
        count = count - 1
    }
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
    var priority: Int
    var operation: (Double, Double)->Double
}

enum ComputingError: Error{
    case outOfMemory
    case dividingWithZero
    case valueExistNot
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

