//
//  ViewController.swift
//  Week 2_LAB 1_Flashcards
//
//  Created by Đặng Đức Trường on 2/26/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Screen: UIView!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var Answer: UILabel!
    
    @IBOutlet weak var Button1_Deco: UIButton!
    
    @IBOutlet weak var Button2_Deco: UIButton!
    
    @IBOutlet weak var Button3_Deco: UIButton!
    
    @IBOutlet weak var Reset_Deco: UIButton!
    
    @IBOutlet weak var Next_Deco: UIButton!
    
    @IBAction func Button1(_ sender: Any) {
        Button1_Deco.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.1733349173, alpha: 1)
        Button1_Deco.layer.borderWidth = 5
        Button1_Deco.titleLabel?.textColor = .black
    }
    @IBAction func Button2(_ sender: Any) {
        Button2_Deco.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.1733349173, alpha: 1)
        Button2_Deco.layer.borderWidth = 5
    }
    @IBAction func Button3(_ sender: Any) {
        Button3_Deco.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        Button3_Deco.layer.borderWidth = 5
        flipFlashcard()
    }
    
    @IBAction func ButtonReset(_ sender: Any) {
        viewDidLoad()
    }
    
    
    @IBAction func TapScreen(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard() {
        UIView.transition(with: Answer, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.Question.isHidden = !self.Question.isHidden
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Back Screen set up
        Screen.backgroundColor = UIColor(red: 0xf7/255, green: 0xed/255, blue: 0xe2/255, alpha: 1.0)
        Screen.layer.shadowRadius = 15.0
        Screen.layer.shadowOpacity = 0.2
        
        // Question set up
        Question.textColor = .black
        Question.layer.cornerRadius = 10 // border radius
        Question.clipsToBounds = true // border radius
        Question.backgroundColor = UIColor(red: 0xf5/255, green: 0xca/255, blue: 0xc3/255, alpha: 1.0)
        Question.isHidden = false
        
        // Answer setup
        Answer.textColor = .black
        Answer.layer.cornerRadius = 10 // border radius
        Answer.layer.masksToBounds = true // border radius
        Answer.backgroundColor = UIColor(red: 0xf2/255, green: 0x84/255, blue: 0x82/255, alpha: 1.0)
        
        // Button 1 setup
        Button1_Deco.titleLabel?.textColor = .black
        Button1_Deco.backgroundColor = UIColor(red: 0xf7/255, green: 0xed/255, blue: 0xe2/255, alpha: 1.0)
        Button1_Deco.layer.cornerRadius = 5
        Button1_Deco.clipsToBounds = true
        Button1_Deco.layer.borderWidth = 0
        
        // Button 2 setup
        Button2_Deco.titleLabel?.textColor = .black
        Button2_Deco.backgroundColor = UIColor(red: 0xf7/255, green: 0xed/255, blue: 0xe2/255, alpha: 1.0)
        Button2_Deco.layer.cornerRadius = 5
        Button2_Deco.clipsToBounds = true
        Button2_Deco.layer.borderWidth = 0
        
        // Button 3 setup
        Button3_Deco.titleLabel?.textColor = .black
        Button3_Deco.backgroundColor = UIColor(red: 0xf7/255, green: 0xed/255, blue: 0xe2/255, alpha: 1.0)
        Button3_Deco.layer.cornerRadius = 5
        Button3_Deco.clipsToBounds = true
        Button3_Deco.layer.borderWidth = 0
        
        // Button RESET setup
        Reset_Deco.backgroundColor = .blue
        Reset_Deco.layer.cornerRadius = 5
        Reset_Deco.clipsToBounds = true
        
        // Button NEXT setup
        Next_Deco.backgroundColor = .blue
        Next_Deco.layer.cornerRadius = 5
        Next_Deco.clipsToBounds = true
        
        Question.text = "Who is the best reactor on Youtube?"
    }
}
