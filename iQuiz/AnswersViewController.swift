//
//  AnswersViewController.swift
//  iQuiz
//
//  Created by Ryan Liang on 11/14/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    
    var questions : [Dictionary<String,Any>] = []
    var currentQuestion : Dictionary<String,Any> = [:]
    var totalNumberOfQuestions : Int = 0
    var numberOfCorrectAnswers : Int = 0
    var numberOfQuestionsLeft : Int = 0
    var correctAnswer : Int = 0
    var selected : Int = 0
    
    @IBAction func nextClicked(_ sender: UIButton) {
        if numberOfQuestionsLeft == 0 {
            performSegue(withIdentifier: "showResult", sender: nil)
        }else {
            performSegue(withIdentifier: "backToQuestion", sender: nil)
        }
    }
    
    
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer1: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = currentQuestion["text"] as? String
        var answers = currentQuestion["answers"] as! [String]
        answer1.setTitle(answers[0], for: .normal)
        answer2.setTitle(answers[1], for: .normal)
        answer3.setTitle(answers[2], for: .normal)
        answer4.setTitle(answers[3], for: .normal)
        let button = self.view.viewWithTag(selected) as? UIButton
        if selected == correctAnswer {
            button?.setImage(UIImage(named: "right"), for: .normal)
            numberOfCorrectAnswers += 1
        }else {
            button?.setImage(UIImage(named: "wrong"), for: .normal)
            
            let correct = self.view.viewWithTag(correctAnswer) as? UIButton
            correct?.setImage(UIImage(named: "right"), for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToQuestion" {
            let dest = segue.destination as! DetailViewController
            dest.numberOfCorrectAnswers = numberOfCorrectAnswers
            dest.questions = questions
            dest.totalNumberOfQuestions = totalNumberOfQuestions
        }
        if segue.identifier == "showResult" {
            let dest = segue.destination as! ResultsViewController
            dest.totalNumberOfQuestions = totalNumberOfQuestions
            dest.numberOfCorrectAnswers = numberOfCorrectAnswers
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
