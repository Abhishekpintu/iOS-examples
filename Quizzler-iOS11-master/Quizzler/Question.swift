//
//  Question.swift
//  Quizzler
//
//  Created by Abhishek G on 05/04/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

class Question{
    var questionText:String
    var answer:Bool
    
    init(text:String,correctAnswer:Bool) {
        questionText = text
        answer =  correctAnswer
    }
}
