//
//  ViewController.swift
//  Calculator
//
//  Created by Kuan L. Chen on 03/01/2017.
//  Copyright © 2017 klchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var userIsInTheMiddleOfTyping = false
    
    private var displayValue: Double {
        set {
            numPadLabel.text = String(newValue)
        }
        get {
            return Double(numPadLabel.text!)!
        }
    }
    
    @IBOutlet private weak var numPadLabel: UILabel!
    
    @IBAction private func touchDigiAction(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            
            let numInTheDisplay = numPadLabel.text!
            numPadLabel.text = numInTheDisplay + digit
        }
        else {
            
            numPadLabel.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var brain = CalculatorBrain()
    
    @IBAction private func operationAction(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let operationSymbolString = sender.currentTitle {
            
            brain.performOperation(symbol: operationSymbolString)
        }
        
        displayValue = brain.result
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
}

