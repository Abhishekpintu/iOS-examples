//
//  ViewController.swift
//  Magic8B
//
//  Created by Abhishek G on 03/04/20.
//  Copyright © 2020 Abhishek G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ballImageUI: UIImageView!
    var randomImageUI:Int =  0
    let ballImages=["ball1","ball2","ball3","ball4","ball5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateBallImage()
    }

    @IBAction func askbutton(_ sender: UIButton) {
        updateBallImage()
    }
    
   func updateBallImage(){
        
        randomImageUI = Int(arc4random_uniform(5))
        ballImageUI.image = UIImage(named: ballImages[randomImageUI])
    }
    
}

