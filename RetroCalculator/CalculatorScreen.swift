//
//  CalculatorScreen.swift
//  RetroCalculator
//
//  Created by Hai Dang Luong on 17/01/2017.
//  Copyright © 2017 Hai Dang Luong. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorScreen: UIViewController {
    
    // Sound effect for the buttons
    var btnSound : AVAudioPlayer!
    
    // Display the value to the screen
    @IBOutlet weak var outputLabel: UILabel!
    
    // List of operators
    enum Operators : String {
        case Divide = "/"
        case Multiply = "Multiply"
        case Subtract = "Subtract"
        case Add = "Add"
        case Empty = "Empty"
    }
    var currentOperator = Operators.Empty
    
    // Dump Memory Variable for processing the mathematics operations
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var runningValue = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let audioURL = URL(fileURLWithPath: path!)
        
        // Safety first, if for some reasons the sound can't be played then throw and error
        do {
            try btnSound = AVAudioPlayer(contentsOf: audioURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        playAudio()
        runningValue += String(sender.tag)
        outputLabel.text = runningValue
    }
    
    @IBAction func dividePressed(_ sender: UIButton) {
        processOperator(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        processOperator(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(_ sender: UIButton) {
        processOperator(operation: .Subtract)
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        processOperator(operation: .Add)
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        processOperator(operation: currentOperator)
    }
    
    @IBAction func ClearBtnPressed(_ sender: UIButton) {
        leftValue = ""
        rightValue = ""
        runningValue = ""
        currentOperator = Operators.Empty
        outputLabel.text = "0"
    }
    
    func processOperator(operation: Operators) {
        playAudio()
        if currentOperator != Operators.Empty {
            
            // This happens when user press an operator but then press another operator
            if runningValue != "" {
                rightValue = runningValue
                runningValue = ""
                
                if currentOperator == Operators.Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                } else if currentOperator == Operators.Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperator == Operators.Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOperator == Operators.Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                
                leftValue = result
                outputLabel.text = result
            }
        } else {
        // This is the first time an operator being pushed
        leftValue = runningValue
        runningValue = ""
        currentOperator = operation
        }
    }
    
    func playAudio() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }


}

