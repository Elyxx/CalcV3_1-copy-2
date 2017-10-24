//
//  ViewController.swift
//  CalcV3_0
//
//  Created by adminaccount on 10/6/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DigitsDelegate {

    var dotWasPressed = false
    var bracketsCount = -1
    
    weak var delegate: ResultDelegate?
    var outputViewController:OutputViewController? = nil
    
    var customInput = [String]()
    //weak var calculator: ProcessDelegate?
    var calculator = CalcBrain()
    var tmpLabel: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToNumbers") || (segue.identifier == "ToLeft") || (segue.identifier == "ToHidden") || (segue.identifier == "ToOperButtons") || (segue.identifier == "ToMidButtons"){
            
            let inputViewController = segue.destination as? InputDigitsViewController
            inputViewController?.delegate = self
        }
        else if segue.identifier == "ToOutPut"{
            outputViewController = segue.destination as? OutputViewController
        }
        
    }
    
    func refreshLabel(_ symbol: String) {
        
        switch symbol{
        case "M+":
            print("nan")
        case "M-":
            print("nan")
        case "MR":
            print("nan")
        case "MS":
            print("nan")
        case "MC":
            print("nan")
        case "c":
            bracketsCount = -1
            tmpLabel = ""
            customInput = []
            dotWasPressed = false
            outputViewController?.display("0")
        case "=":
            if customInput[0] == ")" { bracketsCount = bracketsCount - 1 }
            if customInput.isEmpty == false  && bracketsCount == -1 {
                if (customInput[0] == "0") || (customInput[0] == "1") || (customInput[0] == "2") || (customInput[0] == "3") || (customInput[0] == "4") || (customInput[0] == "5") || (customInput[0] == "6") || (customInput[0] == "7") || (customInput[0] == "8") || (customInput[0] == "9") || (customInput[0] == "!") || (customInput[0] == ")") || (customInput[0] == "π") || (customInput[0] == "e"){
     
                    let resultNumber = calculator.processing(input: customInput)
                    customInput = []
                    
                    ///if != nil
                    tmpLabel = String(resultNumber)
                    if tmpLabel.hasSuffix(".0"){
                        tmpLabel.removeLast()
                        tmpLabel.removeLast()
                        print(tmpLabel)
                    }
                    //else  tmpLabel = String(resultNumber) }
                           
                    outputViewController?.display(tmpLabel)
                }
            }
       case "<-":
                if customInput.isEmpty {print("no-no")}
                else {
                    if customInput[0] == ")" { bracketsCount = bracketsCount + 1 }
                    if customInput[0] == "(" { bracketsCount = bracketsCount - 1 }
                    if (customInput[0] != "0")&&(customInput[0] != "0")&&(customInput[0] != "2")&&(customInput[0] != "3")&&(customInput[0] != "4")&&(customInput[0] != "5")&&(customInput[0] != "6")&&(customInput[0] != "7")&&(customInput[0] != "8")&&(customInput[0] != "9"){
                        dotWasPressed = true
                    }
                    
                    customInput.remove(at:0)
                    //outputViewController?.display(tmpLabel)
                }
                
                tmpLabel = ""
                if customInput.isEmpty {
                    outputViewController?.display("0")
                }
                else {
                    for item in customInput.reversed(){
                        tmpLabel+=item
                    }
                    outputViewController?.display(tmpLabel)
                }
        default:
            if customInput.isEmpty{
                if tmpLabel != "" {
                    switch symbol {
                    case "+", "-", "*", "/", "%", "^":
                        customInput.insert(tmpLabel, at: 0)
                        customInput.insert(symbol, at:0)
                        tmpLabel = tmpLabel + symbol
                        outputViewController?.display(tmpLabel)
                    case ")", ".":
                         tmpLabel = ""
                         outputViewController?.display("0")
                    default:
                        customInput.insert(symbol, at:0)
                        tmpLabel = symbol
                        outputViewController?.display(tmpLabel)
                    }
                }
                else{
                    if symbol != ")" {
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                        //if symbol == "(" {bracketsCount = bracketsCount + 1}
                    }
                }
            }
            else{
                
                switch customInput[0]{
              
                case "√", "log":
                    if (symbol == "(")||(symbol == "0")||(symbol == "1")||(symbol == "2")||(symbol == "3")||(symbol == "4")||(symbol == "5")||(symbol == "6")||(symbol == "7")||(symbol == "8")||(symbol == "9")||(symbol == "e")||(symbol == "π"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                case "sin", "cos", "tg":
                    if (symbol == "(")||(symbol == "0")||(symbol == "1")||(symbol == "2")||(symbol == "3")||(symbol == "4")||(symbol == "5")||(symbol == "6")||(symbol == "7")||(symbol == "8")||(symbol == "9")||(symbol == "e")||(symbol == "π")||(symbol == "-")
                    || (symbol == "√"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                case "*", "/", "^":
                    if (symbol != "+")&&(symbol != "/")&&(symbol != "*")&&(symbol != "%")&&(symbol != "^")&&(symbol != ".")&&(symbol != "!")&&(symbol != ")"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                case "-", "+", "%":
                    if (symbol != "+")&&(symbol != "/")&&(symbol != "*")&&(symbol != "%")&&(symbol != "^")&&(symbol != ".")&&(symbol != "!")&&(symbol != ")")&&(symbol != "-"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                case ".":
                     if (symbol == "0")||(symbol == "1")||(symbol == "2")||(symbol == "3")||(symbol == "4")||(symbol == "5")||(symbol == "6")||(symbol == "7")||(symbol == "8")||(symbol == "9"){
                        //34.45.56!!!!!
                        dotWasPressed = true
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                        }
                case "(":
                    bracketsCount = bracketsCount + 1
                    if (symbol != "+")&&(symbol != "/")&&(symbol != "*")&&(symbol != "%")&&(symbol != "^")&&(symbol != ".")&&(symbol != ")")&&(symbol != "!"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                case ")":
                    bracketsCount = bracketsCount - 1
                    
                    if (symbol == "-")||(symbol == "+")||(symbol == "/")||(symbol == "*")||(symbol == "%")||(symbol == "^")||(symbol == "!")||((symbol == ")")&&(bracketsCount > 0)){
                        
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                case "!":
                    if (bracketsCount > -1 || symbol != ")")&&(symbol != "sin")&&(symbol != "cos")&&(symbol != "tg")&&(symbol != "log")&&(symbol != "√")&&(symbol != "(")&&(symbol != "."){
                       
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                case "π" , "e":
                    if (symbol == "-")||(symbol == "+")||(symbol == "/")||(symbol == "*")||(symbol == "%")||(symbol == "^")||((symbol == ")")&&(bracketsCount>0)){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                default:
                    /*if bracketsCount == 0 && symbol == ")" {
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }*/
                    if (bracketsCount > -1 || symbol != ")")&&(symbol != "sin")&&(symbol != "cos")&&(symbol != "tg")&&(symbol != "log")&&(symbol != "√")&&(symbol != "(")&&((symbol != ".")||(dotWasPressed==false)){
                        
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        outputViewController?.display(tmpLabel)
                    }
                    
                }
            }
        }
    }
    
    
}

