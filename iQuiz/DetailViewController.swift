//
//  DetailViewController.swift
//  iQuiz
//
//  Created by Ryan Liang on 11/7/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var totalNumberOfQuestions = 0
    var numberOfCorrectAnswers = 0
    var selected : Int = 0
    var correctAnswer : Int = 0
    var questions: [Dictionary<String,Any>] = []
    var detailItem : String?
    var currentQuestion : Dictionary<String,Any> = [:]
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    
    @IBAction func selected(_ sender: UIButton) {
        nextButton.isEnabled = true
        selected = sender.tag
        answer1.setImage(nil, for: .normal)
        answer2.setImage(nil, for: .normal)
        answer3.setImage(nil, for: .normal)
        answer4.setImage(nil, for: .normal)
        var button = self.view.viewWithTag(selected) as? UIButton
        button?.setImage(UIImage(named: "right"), for: .normal)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnswers" {
            let dest = segue.destination as! AnswersViewController
            dest.currentQuestion = currentQuestion
            dest.numberOfQuestionsLeft = questions.count
            dest.correctAnswer = Int((currentQuestion["answer"] as! String))!
            dest.selected = selected
            dest.totalNumberOfQuestions = totalNumberOfQuestions
            dest.numberOfCorrectAnswers = numberOfCorrectAnswers
            dest.questions = questions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nextButton.isEnabled = false
        currentQuestion = questions.removeFirst()
        question.text = currentQuestion["text"] as? String
        var answers = currentQuestion["answers"] as! [String]
        answer1.setTitle(answers[0], for: .normal)
        answer2.setTitle(answers[1], for: .normal)
        answer3.setTitle(answers[2], for: .normal)
        answer4.setTitle(answers[3], for: .normal)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

