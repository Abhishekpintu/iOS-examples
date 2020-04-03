//
//  ViewController.swift
//  Dicee
//
//  Created by Abhisheka Gopal on 03/04/20.
//  Copyright © 2020 Abhisheka Gopal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomDiceVar1:Int = 0
    var randomDiceVar2:Int = 0
    
    let diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6"]

    @IBOutlet weak var diceImage1: UIImageView!
    @IBOutlet weak var diceImage2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateDiceImages()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
       updateDiceImages()
    }
    
    func updateDiceImages(){
        randomDiceVar1 = Int(arc4random_uniform(6))
               randomDiceVar2 = Int(arc4random_uniform(6))
               print(""+String(randomDiceVar1)+" : "+String(randomDiceVar2))
               diceImage1.image = UIImage(named: diceArray[randomDiceVar1])
               
               diceImage2.image = UIImage(named: diceArray[randomDiceVar2])
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
}

