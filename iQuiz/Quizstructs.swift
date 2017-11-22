//
//  Quizstructs.swift
//  iQuiz
//
//  Created by Ryan Liang on 11/21/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import UIKit

class Quizstructs {
    
    struct Quiz: Decodable {
        let title: String
        let desc: String
        let questions: [Questions]
    }
    struct Questions: Decodable {
        let text: String
        let answer: String
        let answers: Array<String>
    }

}
