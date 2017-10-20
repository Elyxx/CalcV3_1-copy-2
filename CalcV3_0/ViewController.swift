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
    var bracketsCount = 0
    
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
        case "c":
            tmpLabel = ""
            customInput = []
            dotWasPressed = false
        case "=":
            let tmpNumber = calculator.processing(input: customInput)
            customInput = []
            
            ///if != nil
            if tmpNumber == Double(Int(tmpNumber)){
                  tmpLabel = String(Int(tmpNumber))
            }
            else {tmpLabel = String(tmpNumber)}
            //if tmpNumber != 0 {customInput.insert(String(tmpNumber), at: 0)}
            case "<-":
                if customInput.isEmpty {print("no-no")}
                else {
                    if (customInput[0] != "0")&&(customInput[0] != "0")&&(customInput[0] != "2")&&(customInput[0] != "3")&&(customInput[0] != "4")&&(customInput[0] != "5")&&(customInput[0] != "6")&&(customInput[0] != "7")&&(customInput[0] != "8")&&(customInput[0] != "9"){
                        dotWasPressed = true
                    }
                    customInput.remove(at:0)
                }
                tmpLabel = ""
                for item in customInput.reversed(){
                    tmpLabel+=item
                }
        default:
            if customInput.isEmpty{
                tmpLabel = tmpLabel + symbol
                customInput.insert(symbol, at:0)
            }
            else{
                switch customInput[0]{
                case nil:
                    print("this is the beggining")
                case "sin", "cos", "tg", "√"://"log"
                    if (symbol == "(")||(symbol == "0")||(symbol == "1")||(symbol == "2")||(symbol == "3")||(symbol == "4")||(symbol == "5")||(symbol == "6")||(symbol == "7")||(symbol == "8")||(symbol == "9")||(symbol == "e")||(symbol == "π")||(symbol == "-"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                    }
                case "-", "+", "*", "/", "%", "^":
                    if (symbol != "-")&&(symbol != "+")&&(symbol != "/")&&(symbol != "*")&&(symbol != "%")&&(symbol != "^")&&(symbol != ".")&&(symbol != "!"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                    }
                case ".":
                     if (symbol == "0")||(symbol == "1")||(symbol == "2")||(symbol == "3")||(symbol == "4")||(symbol == "5")||(symbol == "6")||(symbol == "7")||(symbol == "8")||(symbol == "9"){
                        //34.45.56!!!!!
                        dotWasPressed = true
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                        }
                case "(":
                    if (symbol != "+")&&(symbol != "/")&&(symbol != "*")&&(symbol != "%")&&(symbol != "^")&&(symbol != "."){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                    }
                case ")":
                    if (symbol == "-")||(symbol == "+")||(symbol == "/")||(symbol == "*")||(symbol == "%")||(symbol == "^")||(symbol == "!")||(symbol == ")"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                    }
                case "!":
                    if (symbol != "sin")&&(symbol != "cos")&&(symbol != "tg")&&(symbol != "log")&&(symbol != "√")&&(symbol != "(")&&(symbol != "."){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                    }
                case "π" , "e":
                    if (symbol == "-")||(symbol == "+")||(symbol == "/")||(symbol == "*")||(symbol == "%")||(symbol == "^")||(symbol == ")"){
                        dotWasPressed = false
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                    }
                default:
                    if (symbol != "sin")&&(symbol != "cos")&&(symbol != "tg")&&(symbol != "log")&&(symbol != "√")&&(symbol != "(")&&((symbol != ".")||(dotWasPressed==false)){
                        tmpLabel = tmpLabel + symbol
                        customInput.insert(symbol, at:0)
                    }
                    
                }
            }
           // tmpLabel = tmpLabel + symbol
           // customInput.insert(symbol, at:0)
        }
        outputViewController?.display(tmpLabel)
        //currentInput = symbol
    }
    
    
}

