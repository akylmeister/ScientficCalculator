//
//  CalcModel.swift
//  Calculator
//
//  Created by admin on 19.09.2021.
//
// Nuli, posl operacia, tancossin,to4ka

import Foundation
enum Operation{
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double,Double)->Double)
    case equals
}
func tangents(value:Double) -> Double{
    let tangent = tan(value * Double.pi / 180)
    return tangent
}
func sinus(value:Double) -> Double{
    let sinus = sin(value*Double.pi / 180)
    return sinus
}
func cosinus(value:Double) -> Double{
    let cosinus = cos(value * Double.pi / 180)
    return cosinus
}
struct CalculatorModel {
    var my_operation: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√x": Operation.unaryOperation(sqrt),
        "∛x": Operation.unaryOperation({pow($0, 1/3)}),
        "y√x":Operation.binaryOperation({pow($0,1/$1)}),
        "+": Operation.binaryOperation({$0+$1}),
        "-": Operation.binaryOperation({$0-$1}),
        "*": Operation.binaryOperation({$0*$1}),
        "÷": Operation.binaryOperation({$0/$1}),
        "c": Operation.constant(0),
        "tan":Operation.unaryOperation(tangents),
        "cos":Operation.unaryOperation(cosinus),
        "sin":Operation.unaryOperation(sinus),
//        "tanh":
//        "cosh":
//        "sinh":
        "x^2": Operation.unaryOperation({$0*$0}),
        "x^3": Operation.unaryOperation({$0*$0*$0}),
        "x^y": Operation.binaryOperation({pow($0,$1)}),
        "e^x":Operation.unaryOperation({pow(M_E,$0)}),
        "log10":Operation.unaryOperation(log10),
        "ln":Operation.unaryOperation(log),
        "1/x":Operation.unaryOperation({1/$0}),
        "10^x":Operation.unaryOperation({pow(10, $0)}),
//        "x!":Operation.unaryOperation(),
//        "Rand":Operation.constant(),
        "=": Operation.equals,
        "±": Operation.unaryOperation({-$0}),
//        ".":Operation.constant('.')
//        "(":
//        ")":
//        "%":
        
    ]
    
    private var global_value: Double?
    mutating func setOperand(_ operand:Double){
        global_value = operand
    }
    mutating func performOperation(_ operation: String){
        let symbol = my_operation[operation]!
        switch symbol {
        case .constant(let value):
            global_value = value
        case .unaryOperation(let function):
            global_value = function(global_value!)
        case .binaryOperation(let functon):
            saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation:functon)
        case .equals:
            if global_value != nil{
                global_value = saving?.performOperationWith(secondOperand:global_value!)
            }
        }
        
    }
    var result: Double?{
        get{
            return global_value
        }
    }
    private var saving: SaveFirstOperandAndOperation?
    struct SaveFirstOperandAndOperation {
        var firstOperand: Double
        var operation: (Double,Double)->Double
        
        func performOperationWith(secondOperand op2: Double) -> Double{
            return operation(firstOperand,op2)
        }
    }
    
}
